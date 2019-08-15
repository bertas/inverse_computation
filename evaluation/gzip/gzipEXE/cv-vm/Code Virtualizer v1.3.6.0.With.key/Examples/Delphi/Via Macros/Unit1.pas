unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);

var
  Value, i: Integer;

begin
             
    Value := 0;

    // the following code, inside the Virtualizer macro will be converted
    // into virtual opcodes

    {$I Virtualizer_Start.inc}

	  for i := 0 to  10 do
      Value := Value * 2;

    {$I Virtualizer_End.inc}

     MessageBox(0, 'The Virtualizer Macro #1 has successfully been executed', 'Virtualizer Macro', MB_OK + MB_ICONINFORMATION);

end;

procedure TForm1.Button2Click(Sender: TObject);

var
  Value, i: Integer;

begin

    Value := 0;

    // the following code, inside the ENCODE macro, will go encrypted
    // all the time and decrypted/encrypted again when it's executed

    {$I Virtualizer_Mutate2_Start.inc}

	  for i := 0 to  10 do
      Value := Value * 3;

    {$I Virtualizer_End.inc}

     MessageBox(0, 'The Virtualizer Macro #2 has successfully been executed', 'Virtualizer Macro', MB_OK + MB_ICONINFORMATION);

end;

end.
