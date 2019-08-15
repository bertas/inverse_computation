open Cil
open Ctoputil
module E = Errormsg

let trimBuiltins = function
  | GVarDecl (v, _) -> let ib = H.mem builtinFunctions v.vname in not ib
  | _ -> true

let truncate l n =
  let rec recTruncate r l n =
    if n <= 0 then
      r
    else
      match l with
      | [] -> r
      | hd::tl -> recTruncate (r @ [hd]) tl (n - 1)
  in recTruncate [] l n

let stages = [
  Blacklist.doit;
  Loop2rec.doit;
  Splitpath.doit;
  Killmemop.doit;
  Killglob.doit;
  (* Flushmem must go after Loop2rec because 
     Loop2rec make new function calls *)
  (* Flushmem must go after Killmemop and Killglob 
     because they make new pointers *)
  Flushmem.doit;
  (* Pssa must go after Flushmem *)
  Pssa.doit;
  (* Threetuple must go after Killmemop and Killglob *)
  Threetuple.doit;
]

let main () : unit =
  if Array.length Sys.argv = 1 then
    E.log "Usage: %s file stage\n" Sys.argv.(0)
  else
    let n = 
      if Array.length Sys.argv = 2 then
        List.length stages
      else
        int_of_string Sys.argv.(2)
    in
    initCIL ();
    let cf = Frontc.parse Sys.argv.(1) () in
    cf.globals <- List.filter trimBuiltins cf.globals;
    let countFunctions globs =
      let l = List.filter (function GFun(_, _) -> true | _ -> false) globs in
      List.length l
    in
    let cntAll = countFunctions cf.globals in
    let aliveStages = truncate stages n in
    let blacklist = StrSet.empty in
    let cf', blacklist' = List.fold_left (|>) (cf, blacklist) aliveStages in
    Cfg.clearFileCFG cf';
    Cfg.computeFileCFG cf';
    Deadcodeelim.dce cf';
    Rmtmps.removeUnusedTemps cf';
    dumpFile defaultCilPrinter stdout "" cf';
    let cntFailed = StrSet.cardinal blacklist' in
    StrSet.iter (E.log "%s\n") blacklist';
    E.log "%s: %d/%d\n" cf.fileName (cntAll - cntFailed) cntAll;;


main();;
