# 1 "./gzip.cil.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "./gzip.cil.c"
# 56 "/usr/include/i386-linux-gnu/bits/types.h"
typedef long long __quad_t;
# 57 "/usr/include/i386-linux-gnu/bits/types.h"
typedef unsigned long long __u_quad_t;
# 134 "/usr/include/i386-linux-gnu/bits/types.h"
typedef __u_quad_t __dev_t;
# 135 "/usr/include/i386-linux-gnu/bits/types.h"
typedef unsigned int __uid_t;
# 136 "/usr/include/i386-linux-gnu/bits/types.h"
typedef unsigned int __gid_t;
# 137 "/usr/include/i386-linux-gnu/bits/types.h"
typedef unsigned long __ino_t;
# 139 "/usr/include/i386-linux-gnu/bits/types.h"
typedef unsigned int __mode_t;
# 140 "/usr/include/i386-linux-gnu/bits/types.h"
typedef unsigned int __nlink_t;
# 141 "/usr/include/i386-linux-gnu/bits/types.h"
typedef long __off_t;
# 142 "/usr/include/i386-linux-gnu/bits/types.h"
typedef __quad_t __off64_t;
# 149 "/usr/include/i386-linux-gnu/bits/types.h"
typedef long __time_t;
# 164 "/usr/include/i386-linux-gnu/bits/types.h"
typedef long __blksize_t;
# 169 "/usr/include/i386-linux-gnu/bits/types.h"
typedef long __blkcnt_t;
# 180 "/usr/include/i386-linux-gnu/bits/types.h"
typedef int __ssize_t;
# 23 "/usr/include/i386-linux-gnu/bits/dirent.h"
struct dirent {
   __ino_t d_ino ;
   __off_t d_off ;
   unsigned short d_reclen ;
   unsigned char d_type ;
   char d_name[256] ;
};
# 129 "/usr/include/dirent.h"
struct __dirstream;
# 129 "/usr/include/dirent.h"
typedef struct __dirstream DIR;
# 212 "/usr/lib/gcc/i686-linux-gnu/4.6/include/stddef.h"
typedef unsigned int size_t;
# 87 "/usr/include/i386-linux-gnu/sys/types.h"
typedef __off_t off_t;
# 110 "/usr/include/i386-linux-gnu/sys/types.h"
typedef __ssize_t ssize_t;
# 76 "/usr/include/time.h"
typedef __time_t time_t;
# 120 "/usr/include/time.h"
struct timespec {
   __time_t tv_sec ;
   long tv_nsec ;
};
# 39 "/usr/include/i386-linux-gnu/bits/stat.h"
struct stat {
   __dev_t st_dev ;
   unsigned short __pad1 ;
   __ino_t st_ino ;
   __mode_t st_mode ;
   __nlink_t st_nlink ;
   __uid_t st_uid ;
   __gid_t st_gid ;
   __dev_t st_rdev ;
   unsigned short __pad2 ;
   __off_t st_size ;
   __blksize_t st_blksize ;
   __blkcnt_t st_blocks ;
   struct timespec st_atim ;
   struct timespec st_mtim ;
   struct timespec st_ctim ;
   unsigned long __unused4 ;
   unsigned long __unused5 ;
};
# 45 "/usr/include/stdio.h"
struct _IO_FILE;
# 45 "/usr/include/stdio.h"
struct _IO_FILE;
# 49 "/usr/include/stdio.h"
typedef struct _IO_FILE FILE;
# 172 "/usr/include/libio.h"
struct _IO_FILE;
# 182 "/usr/include/libio.h"
typedef void _IO_lock_t;
# 188 "/usr/include/libio.h"
struct _IO_marker {
   struct _IO_marker *_next ;
   struct _IO_FILE *_sbuf ;
   int _pos ;
};
# 273 "/usr/include/libio.h"
struct _IO_FILE {
   int _flags ;
   char *_IO_read_ptr ;
   char *_IO_read_end ;
   char *_IO_read_base ;
   char *_IO_write_base ;
   char *_IO_write_ptr ;
   char *_IO_write_end ;
   char *_IO_buf_base ;
   char *_IO_buf_end ;
   char *_IO_save_base ;
   char *_IO_backup_base ;
   char *_IO_save_end ;
   struct _IO_marker *_markers ;
   struct _IO_FILE *_chain ;
   int _fileno ;
   int _flags2 ;
   __off_t _old_offset ;
   unsigned short _cur_column ;
   signed char _vtable_offset ;
   char _shortbuf[1] ;
   _IO_lock_t *_lock ;
   __off64_t _offset ;
   void *__pad1 ;
   void *__pad2 ;
   void *__pad3 ;
   void *__pad4 ;
   size_t __pad5 ;
   int _mode ;
   char _unused2[(15U * sizeof(int ) - 4U * sizeof(void *)) - sizeof(size_t )] ;
};
# 343 "/usr/include/libio.h"
typedef struct _IO_FILE _IO_FILE;
# 84 "/usr/include/signal.h"
typedef void (*__sighandler_t)(int );
# 38 "/usr/include/utime.h"
struct utimbuf {
   __time_t actime ;
   __time_t modtime ;
};
# 377 "gzip.c"
typedef void *voidp;
# 390 "gzip.c"
typedef unsigned char uch;
# 391 "gzip.c"
typedef unsigned short ush;
# 392 "gzip.c"
typedef unsigned long ulg;
# 497 "gzip.c"
typedef int file_t;
# 1003 "gzip.c"
typedef ush Pos;
# 1004 "gzip.c"
typedef unsigned int IPos;
# 1089 "gzip.c"
struct config {
   ush good_length ;
   ush max_lazy ;
   ush nice_length ;
   ush max_chain ;
};
# 1089 "gzip.c"
typedef struct config config;
# 1837 "gzip.c"
struct option {
   char const *name ;
   int has_arg ;
   int *flag ;
   int val ;
};
# 2003 "gzip.c"
enum __anonenum_ordering_55 {
    REQUIRE_ORDER = 0,
    PERMUTE = 1,
    RETURN_IN_ORDER = 2
} ;
# 4780 "gzip.c"
union __anonunion_v_56 {
   ush n ;
   struct huft *t ;
};
# 4780 "gzip.c"
struct huft {
   uch e ;
   uch b ;
   union __anonunion_v_56 v ;
};
# 5802 "gzip.c"
union __anonunion_fc_57 {
   ush freq ;
   ush code ;
};
# 5802 "gzip.c"
union __anonunion_dl_58 {
   ush dad ;
   ush len ;
};
# 5802 "gzip.c"
struct ct_data {
   union __anonunion_fc_57 fc ;
   union __anonunion_dl_58 dl ;
};
# 5802 "gzip.c"
typedef struct ct_data ct_data;
# 5839 "gzip.c"
struct tree_desc {
   ct_data *dyn_tree ;
   ct_data *static_tree ;
   int *extra_bits ;
   int extra_base ;
   int elems ;
   int max_length ;
   int max_code ;
};
# 5839 "gzip.c"
typedef struct tree_desc tree_desc;
# 7125 "gzip.c"
typedef unsigned char char_type;
# 7126 "gzip.c"
typedef long code_int;
# 7129 "gzip.c"
typedef unsigned long cmp_code_int;
# 81 "/usr/include/ctype.h"
extern __attribute__((__nothrow__)) unsigned short const **( __attribute__((__leaf__)) __ctype_b_loc)(void) __attribute__((__const__)) ;
# 126 "/usr/include/ctype.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) tolower)(int __c ) ;
# 136 "/usr/include/dirent.h"
extern DIR *( __attribute__((__nonnull__(1))) opendir)(char const *__name ) ;
# 151 "/usr/include/dirent.h"
extern int ( __attribute__((__nonnull__(1))) closedir)(DIR *__dirp ) ;
# 164 "/usr/include/dirent.h"
extern struct dirent *( __attribute__((__nonnull__(1))) readdir)(DIR *__dirp ) ;
# 47 "/usr/include/i386-linux-gnu/bits/errno.h"
extern __attribute__((__nothrow__)) int *( __attribute__((__leaf__)) __errno_location)(void) __attribute__((__const__)) ;
# 119 "/usr/include/fcntl.h"
extern int ( __attribute__((__nonnull__(1))) open)(char const *__file , int __oflag
                                                   , ...) ;
# 463 "/usr/include/libio.h"
extern int _IO_putc(int __c , _IO_FILE *__fp ) ;
# 169 "/usr/include/stdio.h"
extern struct _IO_FILE *stdin ;
# 170 "/usr/include/stdio.h"
extern struct _IO_FILE *stdout ;
# 171 "/usr/include/stdio.h"
extern struct _IO_FILE *stderr ;
# 243 "/usr/include/stdio.h"
extern int fflush(FILE *__stream ) ;
# 357 "/usr/include/stdio.h"
extern int fprintf(FILE * __restrict __stream , char const * __restrict __format
                   , ...) ;
# 363 "/usr/include/stdio.h"
extern int printf(char const * __restrict __format , ...) ;
# 544 "/usr/include/stdio.h"
extern int getchar(void) ;
# 843 "/usr/include/stdio.h"
extern void perror(char const *__s ) ;
# 855 "/usr/include/stdio.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) fileno)(FILE *__stream ) ;
# 61 "/usr/include/malloc.h"
extern __attribute__((__nothrow__)) void *( __attribute__((__leaf__)) malloc)(size_t __size ) __attribute__((__malloc__)) ;
# 64 "/usr/include/malloc.h"
extern __attribute__((__nothrow__)) void *( __attribute__((__leaf__)) calloc)(size_t __nmemb ,
                                                                               size_t __size ) __attribute__((__malloc__)) ;
# 76 "/usr/include/malloc.h"
extern __attribute__((__nothrow__)) void ( __attribute__((__leaf__)) free)(void *__ptr ) ;
# 44 "/usr/include/string.h"
extern __attribute__((__nothrow__)) void *( __attribute__((__nonnull__(1,2), __leaf__)) memcpy)(void * __restrict __dest ,
                                                                                                 void const * __restrict __src ,
                                                                                                 size_t __n ) ;
# 65 "/usr/include/string.h"
extern __attribute__((__nothrow__)) void *( __attribute__((__nonnull__(1), __leaf__)) memset)(void *__s ,
                                                                                               int __c ,
                                                                                               size_t __n ) ;
# 68 "/usr/include/string.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1,2), __leaf__)) memcmp)(void const *__s1 ,
                                                                                               void const *__s2 ,
                                                                                               size_t __n ) __attribute__((__pure__)) ;
# 128 "/usr/include/string.h"
extern __attribute__((__nothrow__)) char *( __attribute__((__nonnull__(1,2), __leaf__)) strcpy)(char * __restrict __dest ,
                                                                                                 char const * __restrict __src ) ;
# 136 "/usr/include/string.h"
extern __attribute__((__nothrow__)) char *( __attribute__((__nonnull__(1,2), __leaf__)) strcat)(char * __restrict __dest ,
                                                                                                 char const * __restrict __src ) ;
# 143 "/usr/include/string.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1,2), __leaf__)) strcmp)(char const *__s1 ,
                                                                                               char const *__s2 ) __attribute__((__pure__)) ;
# 146 "/usr/include/string.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1,2), __leaf__)) strncmp)(char const *__s1 ,
                                                                                                char const *__s2 ,
                                                                                                size_t __n ) __attribute__((__pure__)) ;
# 235 "/usr/include/string.h"
static __attribute__((__nothrow__)) char *( __attribute__((__nonnull__(1), __leaf__)) strchr)(char const *str ,
                                                                                               int chr ) __attribute__((__pure__)) ;
# 262 "/usr/include/string.h"
extern __attribute__((__nothrow__)) char *( __attribute__((__nonnull__(1), __leaf__)) strrchr)(char const *__s ,
                                                                                                int __c ) __attribute__((__pure__)) ;
# 284 "/usr/include/string.h"
extern __attribute__((__nothrow__)) size_t ( __attribute__((__nonnull__(1,2), __leaf__)) strcspn)(char const *__s ,
                                                                                                   char const *__reject ) __attribute__((__pure__)) ;
# 288 "/usr/include/string.h"
extern __attribute__((__nothrow__)) size_t ( __attribute__((__nonnull__(1,2), __leaf__)) strspn)(char const *__s ,
                                                                                                  char const *__accept ) __attribute__((__pure__)) ;
# 399 "/usr/include/string.h"
extern __attribute__((__nothrow__)) size_t ( __attribute__((__nonnull__(1), __leaf__)) strlen)(char const *__s ) __attribute__((__pure__)) ;
# 101 "/usr/include/signal.h"
extern __attribute__((__nothrow__)) __sighandler_t ( __attribute__((__leaf__)) signal)(int __sig ,
                                                                                        void (*__handler)(int ) ) ;
# 148 "/usr/include/stdlib.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1), __leaf__)) atoi)(char const *__nptr ) __attribute__((__pure__)) ;
# 544 "/usr/include/stdlib.h"
extern __attribute__((__nothrow__, __noreturn__)) void ( __attribute__((__leaf__)) exit)(int __status ) ;
# 567 "/usr/include/stdlib.h"
extern __attribute__((__nothrow__)) char *( __attribute__((__nonnull__(1), __leaf__)) getenv)(char const *__name ) ;
# 885 "/usr/include/stdlib.h"
 __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1), __leaf__)) rpmatch)(char const *response ) ;
# 211 "/usr/include/i386-linux-gnu/sys/stat.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1,2), __leaf__)) stat)(char const * __restrict __file ,
                                                                                             struct stat * __restrict __buf ) ;
# 216 "/usr/include/i386-linux-gnu/sys/stat.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(2), __leaf__)) fstat)(int __fd ,
                                                                                            struct stat *__buf ) ;
# 265 "/usr/include/i386-linux-gnu/sys/stat.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1,2), __leaf__)) lstat)(char const * __restrict __file ,
                                                                                              struct stat * __restrict __buf ) ;
# 299 "/usr/include/i386-linux-gnu/sys/stat.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) fchmod)(int __fd ,
                                                                             __mode_t __mode ) ;
# 258 "/usr/include/time.h"
extern __attribute__((__nothrow__)) char *( __attribute__((__leaf__)) ctime)(time_t const *__timer ) ;
# 335 "/usr/include/unistd.h"
extern __attribute__((__nothrow__)) __off_t ( __attribute__((__leaf__)) lseek)(int __fd ,
                                                                                __off_t __offset ,
                                                                                int __whence ) ;
# 354 "/usr/include/unistd.h"
extern int close(int __fd ) ;
# 361 "/usr/include/unistd.h"
extern ssize_t read(int __fd , void *__buf , size_t __nbytes ) ;
# 367 "/usr/include/unistd.h"
extern ssize_t write(int __fd , void const *__buf , size_t __n ) ;
# 479 "/usr/include/unistd.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) fchown)(int __fd ,
                                                                             __uid_t __owner ,
                                                                             __gid_t __group ) ;
# 604 "/usr/include/unistd.h"
extern __attribute__((__noreturn__)) void _exit(int __status ) ;
# 802 "/usr/include/unistd.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) isatty)(int __fd ) ;
# 849 "/usr/include/unistd.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1), __leaf__)) unlink)(char const *__name ) ;
# 59 "/usr/include/getopt.h"
char *optarg ;
# 73 "/usr/include/getopt.h"
int optind ;
# 78 "/usr/include/getopt.h"
int opterr ;
# 82 "/usr/include/getopt.h"
int optopt ;
# 152 "/usr/include/getopt.h"
 __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) getopt)(int argc , char * const *argv ,
                                                                      char const *optstring ) ;
# 46 "/usr/include/utime.h"
extern __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1), __leaf__)) utime)(char const *__file ,
                                                                                            struct utimbuf const *__file_times ) ;
# 407 "gzip.c"
int method ;
# 463 "gzip.c"
uch inbuf[32832] ;
# 464 "gzip.c"
uch outbuf[18432] ;
# 465 "gzip.c"
ush d_buf[32768] ;
# 466 "gzip.c"
uch window[65536L] ;
# 471 "gzip.c"
ush prev[1L << 16] ;
# 479 "gzip.c"
unsigned int insize ;
# 480 "gzip.c"
unsigned int inptr ;
# 481 "gzip.c"
unsigned int outcnt ;
# 482 "gzip.c"
int rsync ;
# 484 "gzip.c"
off_t bytes_in ;
# 485 "gzip.c"
off_t bytes_out ;
# 486 "gzip.c"
off_t header_bytes ;
# 488 "gzip.c"
int ifd ;
# 489 "gzip.c"
int ofd ;
# 490 "gzip.c"
char ifname[1024] ;
# 491 "gzip.c"
char ofname[1024] ;
# 492 "gzip.c"
char *progname ;
# 494 "gzip.c"
time_t time_stamp ;
# 495 "gzip.c"
off_t ifile_size ;
# 539 "gzip.c"
int decrypt ;
# 540 "gzip.c"
int exit_code ;
# 541 "gzip.c"
int verbose ;
# 542 "gzip.c"
int quiet ;
# 543 "gzip.c"
int level ;
# 544 "gzip.c"
int test ;
# 545 "gzip.c"
int to_stdout ;
# 546 "gzip.c"
int save_orig_name ;
# 608 "gzip.c"
int zip(int in , int out ) ;
# 609 "gzip.c"
int file_read(char *buf , unsigned int size ) ;
# 612 "gzip.c"
int unzip(int in , int out ) ;
# 613 "gzip.c"
int check_zipfile(int in ) ;
# 616 "gzip.c"
int unpack(int in , int out ) ;
# 619 "gzip.c"
int unlzh(int in , int out ) ;
# 622 "gzip.c"
void abort_gzip_signal(void) ;
# 625 "gzip.c"
void lm_init(int pack_level , ush *flags ) ;
# 626 "gzip.c"
off_t deflate(void) ;
# 629 "gzip.c"
void ct_init(ush *attr , int *methodp ) ;
# 630 "gzip.c"
int ct_tally(int dist , int lc ) ;
# 631 "gzip.c"
off_t flush_block(char *buf , ulg stored_len , int pad , int eof ) ;
# 634 "gzip.c"
void bi_init(file_t zipfile ) ;
# 635 "gzip.c"
void send_bits(int value , int length ) ;
# 636 "gzip.c"
unsigned int bi_reverse(unsigned int code , int len ) ;
# 637 "gzip.c"
void bi_windup(void) ;
# 638 "gzip.c"
void copy_block(char *buf , unsigned int len , int header ) ;
# 639 "gzip.c"
int (*read_buf)(char *buf , unsigned int size ) ;
# 642 "gzip.c"
int copy(int in , int out ) ;
# 643 "gzip.c"
ulg updcrc(uch *s , unsigned int n ) ;
# 644 "gzip.c"
void clear_bufs(void) ;
# 645 "gzip.c"
int fill_inbuf(int eof_ok ) ;
# 646 "gzip.c"
void flush_outbuf(void) ;
# 647 "gzip.c"
void flush_window(void) ;
# 648 "gzip.c"
void write_buf(int fd , voidp buf , unsigned int cnt ) ;
# 649 "gzip.c"
char *strlwr(char *s ) ;
# 650 "gzip.c"
char *base_name(char *fname ) ;
# 651 "gzip.c"
int xunlink(char *filename ) ;
# 652 "gzip.c"
void make_simple_name(char *name ) ;
# 653 "gzip.c"
char *add_envopt(int *argcp , char ***argvp , char *env___0 ) ;
# 654 "gzip.c"
void error(char *m ) ;
# 655 "gzip.c"
void warning(char *m ) ;
# 656 "gzip.c"
void read_error(void) ;
# 657 "gzip.c"
void write_error(void) ;
# 658 "gzip.c"
void display_ratio(off_t num , off_t den , FILE *file ) ;
# 659 "gzip.c"
void fprint_off(FILE *file , off_t offset , int width ) ;
# 660 "gzip.c"
voidp xmalloc(unsigned int size ) ;
# 663 "gzip.c"
int inflate(void) ;
# 666 "gzip.c"
int yesno(void) ;
# 691 "gzip.c"
static file_t zfile ;
# 693 "gzip.c"
static unsigned short bi_buf ;
# 703 "gzip.c"
static int bi_valid ;
# 718 "gzip.c"
void bi_init(file_t zipfile )
{


  {
# 721 "gzip.c"
  zfile = zipfile;
# 722 "gzip.c"
  bi_buf = (unsigned short)0;
# 723 "gzip.c"
  bi_valid = 0;
# 731 "gzip.c"
  if (zfile != -1) {
# 732 "gzip.c"
    read_buf = & file_read;
  } else {

  }
# 718 "gzip.c"
  return;
}
}
# 740 "gzip.c"
void send_bits(int value , int length )
{
  unsigned int tmp ;
  unsigned int tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int tmp___2 ;

  {
# 753 "gzip.c"
  if (bi_valid > (int )(16U * sizeof(char )) - length) {
# 754 "gzip.c"
    bi_buf = (unsigned short )((int )bi_buf | (value << bi_valid));
# 755 "gzip.c"
    if (outcnt < 16382U) {
# 755 "gzip.c"
      tmp = outcnt;
# 755 "gzip.c"
      outcnt ++;
# 755 "gzip.c"
      outbuf[tmp] = (uch )((int )bi_buf & 255);
# 755 "gzip.c"
      tmp___0 = outcnt;
# 755 "gzip.c"
      outcnt ++;
# 755 "gzip.c"
      outbuf[tmp___0] = (uch )((int )bi_buf >> 8);
    } else {
# 755 "gzip.c"
      tmp___1 = outcnt;
# 755 "gzip.c"
      outcnt ++;
# 755 "gzip.c"
      outbuf[tmp___1] = (uch )((int )bi_buf & 255);
# 755 "gzip.c"
      if (outcnt == 16384U) {
# 755 "gzip.c"
        flush_outbuf();
      } else {

      }
# 755 "gzip.c"
      tmp___2 = outcnt;
# 755 "gzip.c"
      outcnt ++;
# 755 "gzip.c"
      outbuf[tmp___2] = (uch )((int )bi_buf >> 8);
# 755 "gzip.c"
      if (outcnt == 16384U) {
# 755 "gzip.c"
        flush_outbuf();
      } else {

      }
    }
# 756 "gzip.c"
    bi_buf = (unsigned short )((int )((ush )value) >> (16U * sizeof(char ) - (unsigned int )bi_valid));
# 757 "gzip.c"
    bi_valid = (int )((unsigned int )bi_valid + ((unsigned int )length - 16U * sizeof(char )));
  } else {
# 759 "gzip.c"
    bi_buf = (unsigned short )((int )bi_buf | (value << bi_valid));
# 760 "gzip.c"
    bi_valid += length;
  }
# 740 "gzip.c"
  return;
}
}
# 769 "gzip.c"
unsigned int bi_reverse(unsigned int code , int len )
{
  register unsigned int res ;
  unsigned int __retres4 ;

  {
# 773 "gzip.c"
  res = 0U;
  {
# 774 "gzip.c"
  while (1) {
    while_continue: ;
# 775 "gzip.c"
    res |= code & 1U;
# 776 "gzip.c"
    code >>= 1;
# 776 "gzip.c"
    res <<= 1;
# 774 "gzip.c"
    len --;
# 774 "gzip.c"
    if (len > 0) {

    } else {
# 774 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 778 "gzip.c"
  __retres4 = res >> 1;
# 769 "gzip.c"
  return (__retres4);
}
}
# 784 "gzip.c"
void bi_windup(void)
{
  unsigned int tmp ;
  unsigned int tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int tmp___2 ;
  unsigned int tmp___3 ;

  {
# 786 "gzip.c"
  if (bi_valid > 8) {
# 787 "gzip.c"
    if (outcnt < 16382U) {
# 787 "gzip.c"
      tmp = outcnt;
# 787 "gzip.c"
      outcnt ++;
# 787 "gzip.c"
      outbuf[tmp] = (uch )((int )bi_buf & 255);
# 787 "gzip.c"
      tmp___0 = outcnt;
# 787 "gzip.c"
      outcnt ++;
# 787 "gzip.c"
      outbuf[tmp___0] = (uch )((int )bi_buf >> 8);
    } else {
# 787 "gzip.c"
      tmp___1 = outcnt;
# 787 "gzip.c"
      outcnt ++;
# 787 "gzip.c"
      outbuf[tmp___1] = (uch )((int )bi_buf & 255);
# 787 "gzip.c"
      if (outcnt == 16384U) {
# 787 "gzip.c"
        flush_outbuf();
      } else {

      }
# 787 "gzip.c"
      tmp___2 = outcnt;
# 787 "gzip.c"
      outcnt ++;
# 787 "gzip.c"
      outbuf[tmp___2] = (uch )((int )bi_buf >> 8);
# 787 "gzip.c"
      if (outcnt == 16384U) {
# 787 "gzip.c"
        flush_outbuf();
      } else {

      }
    }
  } else
# 788 "gzip.c"
  if (bi_valid > 0) {
# 789 "gzip.c"
    tmp___3 = outcnt;
# 789 "gzip.c"
    outcnt ++;
# 789 "gzip.c"
    outbuf[tmp___3] = (uch )bi_buf;
# 789 "gzip.c"
    if (outcnt == 16384U) {
# 789 "gzip.c"
      flush_outbuf();
    } else {

    }
  } else {

  }
# 791 "gzip.c"
  bi_buf = (unsigned short)0;
# 792 "gzip.c"
  bi_valid = 0;
# 784 "gzip.c"
  return;
}
}
# 802 "gzip.c"
void copy_block(char *buf , unsigned int len , int header )
{
  unsigned int tmp ;
  unsigned int tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int tmp___2 ;
  unsigned int tmp___3 ;
  unsigned int tmp___4 ;
  unsigned int tmp___5 ;
  unsigned int tmp___6 ;
  unsigned int tmp___7 ;
  char *tmp___8 ;
  unsigned int tmp___9 ;

  {
# 807 "gzip.c"
  bi_windup();
# 809 "gzip.c"
  if (header != 0) {
# 810 "gzip.c"
    if (outcnt < 16382U) {
# 810 "gzip.c"
      tmp = outcnt;
# 810 "gzip.c"
      outcnt ++;
# 810 "gzip.c"
      outbuf[tmp] = (uch )((int )((ush )len) & 255);
# 810 "gzip.c"
      tmp___0 = outcnt;
# 810 "gzip.c"
      outcnt ++;
# 810 "gzip.c"
      outbuf[tmp___0] = (uch )((int )((ush )len) >> 8);
    } else {
# 810 "gzip.c"
      tmp___1 = outcnt;
# 810 "gzip.c"
      outcnt ++;
# 810 "gzip.c"
      outbuf[tmp___1] = (uch )((int )((ush )len) & 255);
# 810 "gzip.c"
      if (outcnt == 16384U) {
# 810 "gzip.c"
        flush_outbuf();
      } else {

      }
# 810 "gzip.c"
      tmp___2 = outcnt;
# 810 "gzip.c"
      outcnt ++;
# 810 "gzip.c"
      outbuf[tmp___2] = (uch )((int )((ush )len) >> 8);
# 810 "gzip.c"
      if (outcnt == 16384U) {
# 810 "gzip.c"
        flush_outbuf();
      } else {

      }
    }
# 811 "gzip.c"
    if (outcnt < 16382U) {
# 811 "gzip.c"
      tmp___3 = outcnt;
# 811 "gzip.c"
      outcnt ++;
# 811 "gzip.c"
      outbuf[tmp___3] = (uch )((int )((ush )(~ len)) & 255);
# 811 "gzip.c"
      tmp___4 = outcnt;
# 811 "gzip.c"
      outcnt ++;
# 811 "gzip.c"
      outbuf[tmp___4] = (uch )((int )((ush )(~ len)) >> 8);
    } else {
# 811 "gzip.c"
      tmp___5 = outcnt;
# 811 "gzip.c"
      outcnt ++;
# 811 "gzip.c"
      outbuf[tmp___5] = (uch )((int )((ush )(~ len)) & 255);
# 811 "gzip.c"
      if (outcnt == 16384U) {
# 811 "gzip.c"
        flush_outbuf();
      } else {

      }
# 811 "gzip.c"
      tmp___6 = outcnt;
# 811 "gzip.c"
      outcnt ++;
# 811 "gzip.c"
      outbuf[tmp___6] = (uch )((int )((ush )(~ len)) >> 8);
# 811 "gzip.c"
      if (outcnt == 16384U) {
# 811 "gzip.c"
        flush_outbuf();
      } else {

      }
    }
  } else {

  }
  {
# 819 "gzip.c"
  while (1) {
    while_continue: ;
# 819 "gzip.c"
    tmp___9 = len;
# 819 "gzip.c"
    len --;
# 819 "gzip.c"
    if (tmp___9 != 0) {

    } else {
# 819 "gzip.c"
      goto while_break;
    }
# 824 "gzip.c"
    tmp___7 = outcnt;
# 824 "gzip.c"
    outcnt ++;
# 824 "gzip.c"
    tmp___8 = buf;
# 824 "gzip.c"
    buf ++;
# 824 "gzip.c"
    outbuf[tmp___7] = (uch )*tmp___8;
# 824 "gzip.c"
    if (outcnt == 16384U) {
# 824 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
  while_break: ;
  }
# 802 "gzip.c"
  return;
}
}
# 930 "gzip.c"
int maxbits ;
# 931 "gzip.c"
int block_mode ;
# 933 "gzip.c"
int lzw(int in , int out ) ;
# 934 "gzip.c"
int unlzw(int in , int out ) ;
# 1029 "gzip.c"
ulg window_size = 65536UL;
# 1034 "gzip.c"
long block_start ;
# 1039 "gzip.c"
static unsigned int ins_h ;
# 1048 "gzip.c"
unsigned int prev_length ;
# 1053 "gzip.c"
unsigned int strstart ;
# 1054 "gzip.c"
unsigned int match_start ;
# 1055 "gzip.c"
static int eofile ;
# 1056 "gzip.c"
static unsigned int lookahead ;
# 1058 "gzip.c"
unsigned int max_chain_length ;
# 1063 "gzip.c"
static unsigned int max_lazy_match ;
# 1074 "gzip.c"
static int compr_level ;
# 1077 "gzip.c"
unsigned int good_match ;
# 1080 "gzip.c"
static ulg rsync_sum ;
# 1081 "gzip.c"
static ulg rsync_chunk_end ;
# 1099 "gzip.c"
int nice_match ;
# 1102 "gzip.c"
static config configuration_table[10] =
# 1102 "gzip.c"
  { {(ush )0, (ush )0, (ush )0, (ush )0},
        {(ush )4, (ush )4, (ush )8, (ush )4},
        {(ush )4, (ush )5, (ush )16, (ush )8},
        {(ush )4, (ush )6, (ush )32, (ush )32},
        {(ush )4, (ush )4, (ush )16, (ush )16},
        {(ush )8, (ush )16, (ush )32, (ush )32},
        {(ush )8, (ush )16, (ush )128, (ush )128},
        {(ush )8, (ush )32, (ush )128, (ush )256},
        {(ush )32, (ush )128, (ush )258, (ush )1024},
        {(ush )32, (ush )258, (ush )258, (ush )4096}};
# 1127 "gzip.c"
static void fill_window(void) ;
# 1128 "gzip.c"
static off_t deflate_fast(void) ;
# 1130 "gzip.c"
int longest_match(IPos cur_match ) ;
# 1163 "gzip.c"
void lm_init(int pack_level , ush *flags )
{
  register unsigned int j ;
  unsigned int tmp ;
  int tmp___0 ;
  ush *mem_6 ;

  {
# 1169 "gzip.c"
  if (pack_level < 1) {
# 1169 "gzip.c"
    error((char *)"bad pack level");
  } else
# 1169 "gzip.c"
  if (pack_level > 9) {
# 1169 "gzip.c"
    error((char *)"bad pack level");
  } else {

  }
# 1170 "gzip.c"
  compr_level = pack_level;
# 1176 "gzip.c"
  mem_6 = prev + 32768;
# 1176 "gzip.c"
  memset((voidp )((char *)(prev + 32768)), 0, (unsigned int )(1 << 15) * sizeof(*mem_6));
# 1181 "gzip.c"
  rsync_chunk_end = 4294967295UL;
# 1182 "gzip.c"
  rsync_sum = (ulg )0;
# 1186 "gzip.c"
  max_lazy_match = (unsigned int )configuration_table[pack_level].max_lazy;
# 1187 "gzip.c"
  good_match = (unsigned int )configuration_table[pack_level].good_length;
# 1189 "gzip.c"
  nice_match = (int )configuration_table[pack_level].nice_length;
# 1191 "gzip.c"
  max_chain_length = (unsigned int )configuration_table[pack_level].max_chain;
# 1192 "gzip.c"
  if (pack_level == 1) {
# 1193 "gzip.c"
    *flags = (ush )((int )*flags | 4);
  } else
# 1194 "gzip.c"
  if (pack_level == 9) {
# 1195 "gzip.c"
    *flags = (ush )((int )*flags | 2);
  } else {

  }
# 1199 "gzip.c"
  strstart = 0U;
# 1200 "gzip.c"
  block_start = 0L;
# 1205 "gzip.c"
  if (sizeof(int ) <= 2U) {
# 1205 "gzip.c"
    tmp = 32768U;
  } else {
# 1205 "gzip.c"
    tmp = 65536U;
  }
# 1205 "gzip.c"
  tmp___0 = (*read_buf)((char *)(window), tmp);
# 1205 "gzip.c"
  lookahead = (unsigned int )tmp___0;
# 1208 "gzip.c"
  if (lookahead == 0U) {
# 1209 "gzip.c"
    eofile = 1;
# 1209 "gzip.c"
    lookahead = 0U;
# 1210 "gzip.c"
    goto return_label;
  } else
# 1208 "gzip.c"
  if (lookahead == 4294967295U) {
# 1209 "gzip.c"
    eofile = 1;
# 1209 "gzip.c"
    lookahead = 0U;
# 1210 "gzip.c"
    goto return_label;
  } else {

  }
# 1212 "gzip.c"
  eofile = 0;
  {
# 1216 "gzip.c"
  while (1) {
    while_continue: ;
# 1216 "gzip.c"
    if (lookahead < 262U) {
# 1216 "gzip.c"
      if (eofile == 0) {

      } else {
# 1216 "gzip.c"
        goto while_break;
      }
    } else {
# 1216 "gzip.c"
      goto while_break;
    }
# 1216 "gzip.c"
    fill_window();
  }
  while_break: ;
  }
# 1218 "gzip.c"
  ins_h = 0U;
# 1219 "gzip.c"
  j = 0U;
  {
# 1219 "gzip.c"
  while (1) {
    while_continue___0: ;
# 1219 "gzip.c"
    if (j < 2U) {

    } else {
# 1219 "gzip.c"
      goto while_break___0;
    }
# 1219 "gzip.c"
    ins_h = ((ins_h << 5) ^ (unsigned int )window[j]) & ((unsigned int )(1 << 15) - 1U);
# 1219 "gzip.c"
    j ++;
  }
  while_break___0: ;
  }

  return_label:
# 1163 "gzip.c"
  return;
}
}
# 1238 "gzip.c"
int longest_match(IPos cur_match )
{
  unsigned int chain_length ;
  register uch *scan ;
  register uch *match ;
  register int len ;
  int best_len ;
  IPos limit ;
  unsigned int tmp ;
  register uch *strend ;
  register uch scan_end1 ;
  register uch scan_end ;
  uch *mem_12 ;
  uch *mem_13 ;
  uch *mem_14 ;
  uch *mem_15 ;
  uch *mem_16 ;
  uch *mem_17 ;
  uch *mem_18 ;

  {
# 1241 "gzip.c"
  chain_length = max_chain_length;
# 1242 "gzip.c"
  scan = window + strstart;
# 1245 "gzip.c"
  best_len = (int )prev_length;
# 1246 "gzip.c"
  if (strstart > 32506U) {
# 1246 "gzip.c"
    tmp = strstart - 32506U;
  } else {
# 1246 "gzip.c"
    tmp = 0U;
  }
# 1246 "gzip.c"
  limit = tmp;
# 1266 "gzip.c"
  strend = (window + strstart) + 258;
# 1267 "gzip.c"
  mem_12 = scan + (best_len - 1);
# 1267 "gzip.c"
  scan_end1 = *mem_12;
# 1268 "gzip.c"
  mem_13 = scan + best_len;
# 1268 "gzip.c"
  scan_end = *mem_13;
# 1272 "gzip.c"
  if (prev_length >= good_match) {
# 1273 "gzip.c"
    chain_length >>= 2;
  } else {

  }
  {
# 1277 "gzip.c"
  while (1) {
    while_continue: ;
# 1279 "gzip.c"
    match = window + cur_match;
    {
# 1318 "gzip.c"
    mem_14 = match + best_len;
# 1318 "gzip.c"
    if ((int )*mem_14 != (int )scan_end) {
# 1321 "gzip.c"
      goto __Cont;
    } else {
      {
# 1318 "gzip.c"
      mem_15 = match + (best_len - 1);
# 1318 "gzip.c"
      if ((int )*mem_15 != (int )scan_end1) {
# 1321 "gzip.c"
        goto __Cont;
      } else
# 1318 "gzip.c"
      if ((int )*match != (int )*scan) {
# 1321 "gzip.c"
        goto __Cont;
      } else {
# 1318 "gzip.c"
        match ++;
        {
# 1318 "gzip.c"
        mem_16 = scan + 1;
# 1318 "gzip.c"
        if ((int )*match != (int )*mem_16) {
# 1321 "gzip.c"
          goto __Cont;
        } else {

        }
        }
      }
      }
    }
    }
# 1329 "gzip.c"
    scan += 2;
# 1329 "gzip.c"
    match ++;
    {
# 1334 "gzip.c"
    while (1) {
      while_continue___0: ;
# 1334 "gzip.c"
      scan ++;
# 1334 "gzip.c"
      match ++;
# 1334 "gzip.c"
      if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
        scan ++;
# 1334 "gzip.c"
        match ++;
# 1334 "gzip.c"
        if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
          scan ++;
# 1334 "gzip.c"
          match ++;
# 1334 "gzip.c"
          if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
            scan ++;
# 1334 "gzip.c"
            match ++;
# 1334 "gzip.c"
            if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
              scan ++;
# 1334 "gzip.c"
              match ++;
# 1334 "gzip.c"
              if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
                scan ++;
# 1334 "gzip.c"
                match ++;
# 1334 "gzip.c"
                if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
                  scan ++;
# 1334 "gzip.c"
                  match ++;
# 1334 "gzip.c"
                  if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
                    scan ++;
# 1334 "gzip.c"
                    match ++;
# 1334 "gzip.c"
                    if ((int )*scan == (int )*match) {
# 1334 "gzip.c"
                      if ((unsigned int )scan < (unsigned int )strend) {

                      } else {
# 1334 "gzip.c"
                        goto while_break___0;
                      }
                    } else {
# 1334 "gzip.c"
                      goto while_break___0;
                    }
                  } else {
# 1334 "gzip.c"
                    goto while_break___0;
                  }
                } else {
# 1334 "gzip.c"
                  goto while_break___0;
                }
              } else {
# 1334 "gzip.c"
                goto while_break___0;
              }
            } else {
# 1334 "gzip.c"
              goto while_break___0;
            }
          } else {
# 1334 "gzip.c"
            goto while_break___0;
          }
        } else {
# 1334 "gzip.c"
          goto while_break___0;
        }
      } else {
# 1334 "gzip.c"
        goto while_break___0;
      }
    }
    while_break___0: ;
    }
# 1341 "gzip.c"
    len = 258 - (strend - scan);
# 1342 "gzip.c"
    scan = strend - 258;
# 1346 "gzip.c"
    if (len > best_len) {
# 1347 "gzip.c"
      match_start = cur_match;
# 1348 "gzip.c"
      best_len = len;
# 1349 "gzip.c"
      if (len >= nice_match) {
# 1349 "gzip.c"
        goto while_break;
      } else {

      }
# 1353 "gzip.c"
      mem_17 = scan + (best_len - 1);
# 1353 "gzip.c"
      scan_end1 = *mem_17;
# 1354 "gzip.c"
      mem_18 = scan + best_len;
# 1354 "gzip.c"
      scan_end = *mem_18;
    } else {

    }
    __Cont:
# 1277 "gzip.c"
    cur_match = (IPos )prev[cur_match & 32767U];
# 1277 "gzip.c"
    if (cur_match > limit) {
# 1277 "gzip.c"
      chain_length --;
# 1277 "gzip.c"
      if (chain_length != 0U) {

      } else {
# 1277 "gzip.c"
        goto while_break;
      }
    } else {
# 1277 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 1360 "gzip.c"
  return (best_len);
}
}
# 1397 "gzip.c"
static void fill_window(void)
{
  register unsigned int n ;
  register unsigned int m ;
  unsigned int more ;
  unsigned int tmp ;
  unsigned int tmp___0 ;
  int tmp___1 ;
  ush *mem_7 ;
  ush *mem_8 ;

  {
# 1400 "gzip.c"
  more = (unsigned int )((window_size - (ulg )lookahead) - (ulg )strstart);
# 1406 "gzip.c"
  if (more == 4294967295U) {
# 1410 "gzip.c"
    more --;
  } else
# 1411 "gzip.c"
  if (strstart >= 65274U) {
# 1417 "gzip.c"
    memcpy((void * __restrict )((char *)(window)), (void const * __restrict )((char *)(window) + 32768),
           32768U);
# 1418 "gzip.c"
    match_start -= 32768U;
# 1419 "gzip.c"
    strstart -= 32768U;
# 1420 "gzip.c"
    if (rsync_chunk_end != 4294967295UL) {
# 1421 "gzip.c"
      rsync_chunk_end -= 32768UL;
    } else {

    }
# 1423 "gzip.c"
    block_start -= 32768L;
# 1425 "gzip.c"
    n = 0U;
    {
# 1425 "gzip.c"
    while (1) {
      while_continue: ;
# 1425 "gzip.c"
      if (n < (unsigned int )(1 << 15)) {

      } else {
# 1425 "gzip.c"
        goto while_break;
      }
# 1426 "gzip.c"
      mem_7 = (prev + 32768) + n;
# 1426 "gzip.c"
      m = (unsigned int )*mem_7;
# 1427 "gzip.c"
      if (m >= 32768U) {
# 1427 "gzip.c"
        tmp = m - 32768U;
      } else {
# 1427 "gzip.c"
        tmp = 0U;
      }
# 1427 "gzip.c"
      mem_8 = (prev + 32768) + n;
# 1427 "gzip.c"
      *mem_8 = (Pos )tmp;
# 1425 "gzip.c"
      n ++;
    }
    while_break: ;
    }
# 1429 "gzip.c"
    n = 0U;
    {
# 1429 "gzip.c"
    while (1) {
      while_continue___0: ;
# 1429 "gzip.c"
      if (n < 32768U) {

      } else {
# 1429 "gzip.c"
        goto while_break___0;
      }
# 1430 "gzip.c"
      m = (unsigned int )prev[n];
# 1431 "gzip.c"
      if (m >= 32768U) {
# 1431 "gzip.c"
        tmp___0 = m - 32768U;
      } else {
# 1431 "gzip.c"
        tmp___0 = 0U;
      }
# 1431 "gzip.c"
      prev[n] = (Pos )tmp___0;
# 1429 "gzip.c"
      n ++;
    }
    while_break___0: ;
    }
# 1436 "gzip.c"
    more += 32768U;
  } else {

  }
# 1439 "gzip.c"
  if (eofile == 0) {
# 1440 "gzip.c"
    tmp___1 = (*read_buf)(((char *)(window) + strstart) + lookahead, more);
# 1440 "gzip.c"
    n = (unsigned int )tmp___1;
# 1441 "gzip.c"
    if (n == 0U) {
# 1442 "gzip.c"
      eofile = 1;
    } else
# 1441 "gzip.c"
    if (n == 4294967295U) {
# 1442 "gzip.c"
      eofile = 1;
    } else {
# 1444 "gzip.c"
      lookahead += n;
    }
  } else {

  }
# 1397 "gzip.c"
  return;
}
}
# 1449 "gzip.c"
static void rsync_roll(unsigned int start , unsigned int num )
{
  unsigned int i ;

  {
# 1455 "gzip.c"
  if (start < 4096U) {
# 1457 "gzip.c"
    i = start;
    {
# 1457 "gzip.c"
    while (1) {
      while_continue: ;
# 1457 "gzip.c"
      if (i < 4096U) {

      } else {
# 1457 "gzip.c"
        goto while_break;
      }
# 1458 "gzip.c"
      if (i == start + num) {
# 1458 "gzip.c"
        goto return_label;
      } else {

      }
# 1459 "gzip.c"
      rsync_sum += (ulg )window[i];
# 1457 "gzip.c"
      i ++;
    }
    while_break: ;
    }
# 1461 "gzip.c"
    num -= 4096U - start;
# 1462 "gzip.c"
    start = 4096U;
  } else {

  }
# 1466 "gzip.c"
  i = start;
  {
# 1466 "gzip.c"
  while (1) {
    while_continue___0: ;
# 1466 "gzip.c"
    if (i < start + num) {

    } else {
# 1466 "gzip.c"
      goto while_break___0;
    }
# 1468 "gzip.c"
    rsync_sum += (ulg )window[i];
# 1470 "gzip.c"
    rsync_sum -= (ulg )window[i - 4096U];
# 1471 "gzip.c"
    if (rsync_chunk_end == 4294967295UL) {
# 1471 "gzip.c"
      if (rsync_sum % 4096UL == 0UL) {
# 1472 "gzip.c"
        rsync_chunk_end = (ulg )i;
      } else {

      }
    } else {

    }
# 1466 "gzip.c"
    i ++;
  }
  while_break___0: ;
  }

  return_label:
# 1449 "gzip.c"
  return;
}
}
# 1496 "gzip.c"
static off_t deflate_fast(void)
{
  IPos hash_head ;
  int flush ;
  unsigned int match_length ;
  int tmp ;
  char *tmp___0 ;
  char *tmp___1 ;
  off_t tmp___2 ;
  ush *mem_8 ;
  ush *mem_9 ;
  ush *mem_10 ;
  ush *mem_11 ;

  {
# 1500 "gzip.c"
  match_length = 0U;
# 1502 "gzip.c"
  prev_length = 2U;
  {
# 1503 "gzip.c"
  while (1) {
    while_continue: ;
# 1503 "gzip.c"
    if (lookahead != 0U) {

    } else {
# 1503 "gzip.c"
      goto while_break;
    }
# 1507 "gzip.c"
    ins_h = ((ins_h << 5) ^ (unsigned int )window[(strstart + 3U) - 1U]) & ((unsigned int )(1 << 15) - 1U);
# 1507 "gzip.c"
    mem_8 = (prev + 32768) + ins_h;
# 1507 "gzip.c"
    hash_head = (IPos )*mem_8;
# 1507 "gzip.c"
    prev[strstart & 32767U] = (ush )hash_head;
# 1507 "gzip.c"
    mem_9 = (prev + 32768) + ins_h;
# 1507 "gzip.c"
    *mem_9 = (ush )strstart;
# 1512 "gzip.c"
    if (hash_head != 0U) {
# 1512 "gzip.c"
      if (strstart - hash_head <= 32506U) {
# 1512 "gzip.c"
        if ((ulg )strstart <= window_size - 262UL) {
# 1518 "gzip.c"
          tmp = longest_match(hash_head);
# 1518 "gzip.c"
          match_length = (unsigned int )tmp;
# 1520 "gzip.c"
          if (match_length > lookahead) {
# 1520 "gzip.c"
            match_length = lookahead;
          } else {

          }
        } else {

        }
      } else {

      }
    } else {

    }
# 1522 "gzip.c"
    if (match_length >= 3U) {
# 1525 "gzip.c"
      flush = ct_tally((int )(strstart - match_start), (int )(match_length - 3U));
# 1527 "gzip.c"
      lookahead -= match_length;
      {
# 1529 "gzip.c"
      while (1) {
        while_continue___0: ;
# 1529 "gzip.c"
        if (rsync != 0) {
# 1529 "gzip.c"
          rsync_roll(strstart, match_length);
        } else {

        }
# 1529 "gzip.c"
        goto while_break___0;
      }
      while_break___0: ;
      }
# 1533 "gzip.c"
      if (match_length <= max_lazy_match) {
# 1534 "gzip.c"
        match_length --;
        {
# 1535 "gzip.c"
        while (1) {
          while_continue___1: ;
# 1536 "gzip.c"
          strstart ++;
# 1537 "gzip.c"
          ins_h = ((ins_h << 5) ^ (unsigned int )window[(strstart + 3U) - 1U]) & ((unsigned int )(1 << 15) - 1U);
# 1537 "gzip.c"
          mem_10 = (prev + 32768) + ins_h;
# 1537 "gzip.c"
          hash_head = (IPos )*mem_10;
# 1537 "gzip.c"
          prev[strstart & 32767U] = (ush )hash_head;
# 1537 "gzip.c"
          mem_11 = (prev + 32768) + ins_h;
# 1537 "gzip.c"
          *mem_11 = (ush )strstart;
# 1535 "gzip.c"
          match_length --;
# 1535 "gzip.c"
          if (match_length != 0U) {

          } else {
# 1535 "gzip.c"
            goto while_break___1;
          }
        }
        while_break___1: ;
        }
# 1544 "gzip.c"
        strstart ++;
      } else {
# 1546 "gzip.c"
        strstart += match_length;
# 1547 "gzip.c"
        match_length = 0U;
# 1548 "gzip.c"
        ins_h = (unsigned int )window[strstart];
# 1549 "gzip.c"
        ins_h = ((ins_h << 5) ^ (unsigned int )window[strstart + 1U]) & ((unsigned int )(1 << 15) - 1U);
      }
    } else {
# 1557 "gzip.c"
      flush = ct_tally(0, (int )window[strstart]);
      {
# 1558 "gzip.c"
      while (1) {
        while_continue___2: ;
# 1558 "gzip.c"
        if (rsync != 0) {
# 1558 "gzip.c"
          rsync_roll(strstart, 1U);
        } else {

        }
# 1558 "gzip.c"
        goto while_break___2;
      }
      while_break___2: ;
      }
# 1559 "gzip.c"
      lookahead --;
# 1560 "gzip.c"
      strstart ++;
    }
# 1562 "gzip.c"
    if (rsync != 0) {
# 1562 "gzip.c"
      if ((ulg )strstart > rsync_chunk_end) {
# 1563 "gzip.c"
        rsync_chunk_end = 4294967295UL;
# 1564 "gzip.c"
        flush = 2;
      } else {

      }
    } else {

    }
# 1566 "gzip.c"
    if (flush != 0) {
# 1566 "gzip.c"
      if (block_start >= 0L) {
# 1566 "gzip.c"
        tmp___0 = (char *)(& window[(unsigned int )block_start]);
      } else {
# 1566 "gzip.c"
        tmp___0 = (char *)((void *)0);
      }
# 1566 "gzip.c"
      flush_block(tmp___0, (ulg )((long )strstart - block_start), flush - 1, 0);
# 1566 "gzip.c"
      block_start = (long )strstart;
    } else {

    }
    {
# 1573 "gzip.c"
    while (1) {
      while_continue___3: ;
# 1573 "gzip.c"
      if (lookahead < 262U) {
# 1573 "gzip.c"
        if (eofile == 0) {

        } else {
# 1573 "gzip.c"
          goto while_break___3;
        }
      } else {
# 1573 "gzip.c"
        goto while_break___3;
      }
# 1573 "gzip.c"
      fill_window();
    }
    while_break___3: ;
    }
  }
  while_break: ;
  }
# 1576 "gzip.c"
  if (block_start >= 0L) {
# 1576 "gzip.c"
    tmp___1 = (char *)(& window[(unsigned int )block_start]);
  } else {
# 1576 "gzip.c"
    tmp___1 = (char *)((void *)0);
  }
# 1576 "gzip.c"
  tmp___2 = flush_block(tmp___1, (ulg )((long )strstart - block_start), flush - 1,
                        1);
# 1576 "gzip.c"
  return (tmp___2);
}
}
# 1584 "gzip.c"
off_t deflate(void)
{
  IPos hash_head ;
  IPos prev_match ;
  int flush ;
  int match_available ;
  register unsigned int match_length ;
  off_t tmp ;
  int tmp___0 ;
  char *tmp___1 ;
  char *tmp___2 ;
  char *tmp___3 ;
  char *tmp___4 ;
  off_t tmp___5 ;
  ush *mem_13 ;
  ush *mem_14 ;
  ush *mem_15 ;
  ush *mem_16 ;
  off_t __retres17 ;

  {
# 1589 "gzip.c"
  match_available = 0;
# 1590 "gzip.c"
  match_length = 2U;
# 1592 "gzip.c"
  if (compr_level <= 3) {
# 1592 "gzip.c"
    tmp = deflate_fast();
# 1592 "gzip.c"
    __retres17 = tmp;
# 1592 "gzip.c"
    goto return_label;
  } else {

  }
  {
# 1595 "gzip.c"
  while (1) {
    while_continue: ;
# 1595 "gzip.c"
    if (lookahead != 0U) {

    } else {
# 1595 "gzip.c"
      goto while_break;
    }
# 1599 "gzip.c"
    ins_h = ((ins_h << 5) ^ (unsigned int )window[(strstart + 3U) - 1U]) & ((unsigned int )(1 << 15) - 1U);
# 1599 "gzip.c"
    mem_13 = (prev + 32768) + ins_h;
# 1599 "gzip.c"
    hash_head = (IPos )*mem_13;
# 1599 "gzip.c"
    prev[strstart & 32767U] = (ush )hash_head;
# 1599 "gzip.c"
    mem_14 = (prev + 32768) + ins_h;
# 1599 "gzip.c"
    *mem_14 = (ush )strstart;
# 1603 "gzip.c"
    prev_length = match_length;
# 1603 "gzip.c"
    prev_match = match_start;
# 1604 "gzip.c"
    match_length = 2U;
# 1606 "gzip.c"
    if (hash_head != 0U) {
# 1606 "gzip.c"
      if (prev_length < max_lazy_match) {
# 1606 "gzip.c"
        if (strstart - hash_head <= 32506U) {
# 1606 "gzip.c"
          if ((ulg )strstart <= window_size - 262UL) {
# 1613 "gzip.c"
            tmp___0 = longest_match(hash_head);
# 1613 "gzip.c"
            match_length = (unsigned int )tmp___0;
# 1615 "gzip.c"
            if (match_length > lookahead) {
# 1615 "gzip.c"
              match_length = lookahead;
            } else {

            }
# 1618 "gzip.c"
            if (match_length == 3U) {
# 1618 "gzip.c"
              if (strstart - match_start > 4096U) {
# 1622 "gzip.c"
                match_length --;
              } else {

              }
            } else {

            }
          } else {

          }
        } else {

        }
      } else {

      }
    } else {

    }
# 1628 "gzip.c"
    if (prev_length >= 3U) {
# 1628 "gzip.c"
      if (match_length <= prev_length) {
# 1632 "gzip.c"
        flush = ct_tally((int )((strstart - 1U) - prev_match), (int )(prev_length - 3U));
# 1637 "gzip.c"
        lookahead -= prev_length - 1U;
# 1638 "gzip.c"
        prev_length -= 2U;
        {
# 1639 "gzip.c"
        while (1) {
          while_continue___0: ;
# 1639 "gzip.c"
          if (rsync != 0) {
# 1639 "gzip.c"
            rsync_roll(strstart, prev_length + 1U);
          } else {

          }
# 1639 "gzip.c"
          goto while_break___0;
        }
        while_break___0: ;
        }
        {
# 1640 "gzip.c"
        while (1) {
          while_continue___1: ;
# 1641 "gzip.c"
          strstart ++;
# 1642 "gzip.c"
          ins_h = ((ins_h << 5) ^ (unsigned int )window[(strstart + 3U) - 1U]) & ((unsigned int )(1 << 15) - 1U);
# 1642 "gzip.c"
          mem_15 = (prev + 32768) + ins_h;
# 1642 "gzip.c"
          hash_head = (IPos )*mem_15;
# 1642 "gzip.c"
          prev[strstart & 32767U] = (ush )hash_head;
# 1642 "gzip.c"
          mem_16 = (prev + 32768) + ins_h;
# 1642 "gzip.c"
          *mem_16 = (ush )strstart;
# 1640 "gzip.c"
          prev_length --;
# 1640 "gzip.c"
          if (prev_length != 0U) {

          } else {
# 1640 "gzip.c"
            goto while_break___1;
          }
        }
        while_break___1: ;
        }
# 1649 "gzip.c"
        match_available = 0;
# 1650 "gzip.c"
        match_length = 2U;
# 1651 "gzip.c"
        strstart ++;
# 1653 "gzip.c"
        if (rsync != 0) {
# 1653 "gzip.c"
          if ((ulg )strstart > rsync_chunk_end) {
# 1654 "gzip.c"
            rsync_chunk_end = 4294967295UL;
# 1655 "gzip.c"
            flush = 2;
          } else {

          }
        } else {

        }
# 1657 "gzip.c"
        if (flush != 0) {
# 1657 "gzip.c"
          if (block_start >= 0L) {
# 1657 "gzip.c"
            tmp___1 = (char *)(& window[(unsigned int )block_start]);
          } else {
# 1657 "gzip.c"
            tmp___1 = (char *)((void *)0);
          }
# 1657 "gzip.c"
          flush_block(tmp___1, (ulg )((long )strstart - block_start), flush - 1, 0);
# 1657 "gzip.c"
          block_start = (long )strstart;
        } else {

        }
      } else {
# 1628 "gzip.c"
        goto _L;
      }
    } else
    _L:
# 1658 "gzip.c"
    if (match_available != 0) {
# 1664 "gzip.c"
      flush = ct_tally(0, (int )window[strstart - 1U]);
# 1665 "gzip.c"
      if (rsync != 0) {
# 1665 "gzip.c"
        if ((ulg )strstart > rsync_chunk_end) {
# 1666 "gzip.c"
          rsync_chunk_end = 4294967295UL;
# 1667 "gzip.c"
          flush = 2;
        } else {

        }
      } else {

      }
# 1669 "gzip.c"
      if (flush != 0) {
# 1669 "gzip.c"
        if (block_start >= 0L) {
# 1669 "gzip.c"
          tmp___2 = (char *)(& window[(unsigned int )block_start]);
        } else {
# 1669 "gzip.c"
          tmp___2 = (char *)((void *)0);
        }
# 1669 "gzip.c"
        flush_block(tmp___2, (ulg )((long )strstart - block_start), flush - 1, 0);
# 1669 "gzip.c"
        block_start = (long )strstart;
      } else {

      }
      {
# 1670 "gzip.c"
      while (1) {
        while_continue___2: ;
# 1670 "gzip.c"
        if (rsync != 0) {
# 1670 "gzip.c"
          rsync_roll(strstart, 1U);
        } else {

        }
# 1670 "gzip.c"
        goto while_break___2;
      }
      while_break___2: ;
      }
# 1671 "gzip.c"
      strstart ++;
# 1672 "gzip.c"
      lookahead --;
    } else {
# 1677 "gzip.c"
      if (rsync != 0) {
# 1677 "gzip.c"
        if ((ulg )strstart > rsync_chunk_end) {
# 1679 "gzip.c"
          rsync_chunk_end = 4294967295UL;
# 1680 "gzip.c"
          flush = 2;
# 1681 "gzip.c"
          if (block_start >= 0L) {
# 1681 "gzip.c"
            tmp___3 = (char *)(& window[(unsigned int )block_start]);
          } else {
# 1681 "gzip.c"
            tmp___3 = (char *)((void *)0);
          }
# 1681 "gzip.c"
          flush_block(tmp___3, (ulg )((long )strstart - block_start), flush - 1, 0);
# 1681 "gzip.c"
          block_start = (long )strstart;
        } else {

        }
      } else {

      }
# 1683 "gzip.c"
      match_available = 1;
      {
# 1684 "gzip.c"
      while (1) {
        while_continue___3: ;
# 1684 "gzip.c"
        if (rsync != 0) {
# 1684 "gzip.c"
          rsync_roll(strstart, 1U);
        } else {

        }
# 1684 "gzip.c"
        goto while_break___3;
      }
      while_break___3: ;
      }
# 1685 "gzip.c"
      strstart ++;
# 1686 "gzip.c"
      lookahead --;
    }
    {
# 1695 "gzip.c"
    while (1) {
      while_continue___4: ;
# 1695 "gzip.c"
      if (lookahead < 262U) {
# 1695 "gzip.c"
        if (eofile == 0) {

        } else {
# 1695 "gzip.c"
          goto while_break___4;
        }
      } else {
# 1695 "gzip.c"
        goto while_break___4;
      }
# 1695 "gzip.c"
      fill_window();
    }
    while_break___4: ;
    }
  }
  while_break: ;
  }
# 1697 "gzip.c"
  if (match_available != 0) {
# 1697 "gzip.c"
    ct_tally(0, (int )window[strstart - 1U]);
  } else {

  }
# 1699 "gzip.c"
  if (block_start >= 0L) {
# 1699 "gzip.c"
    tmp___4 = (char *)(& window[(unsigned int )block_start]);
  } else {
# 1699 "gzip.c"
    tmp___4 = (char *)((void *)0);
  }
# 1699 "gzip.c"
  tmp___5 = flush_block(tmp___4, (ulg )((long )strstart - block_start), flush - 1,
                        1);
# 1699 "gzip.c"
  __retres17 = tmp___5;
  return_label:
# 1584 "gzip.c"
  return (__retres17);
}
}
# 1893 "gzip.c"
int getopt_long(int argc , char * const *argv , char const *options , struct option const *long_options ,
                int *opt_index ) ;
# 1895 "gzip.c"
int getopt_long_only(int argc , char * const *argv , char const *options , struct option const *long_options ,
                     int *opt_index ) ;
# 1900 "gzip.c"
int _getopt_internal(int argc , char * const *argv , char const *optstring , struct option const *longopts ,
                     int *longind , int long_only ) ;
# 1946 "gzip.c"
int optind = 1;
# 1952 "gzip.c"
int __getopt_initialized ;
# 1961 "gzip.c"
static char *nextchar ;
# 1966 "gzip.c"
int opterr = 1;
# 1972 "gzip.c"
int optopt = '?';
# 2003 "gzip.c"
static enum __anonenum_ordering_55 ordering ;
# 2009 "gzip.c"
static char *posixly_correct ;
# 2020 "gzip.c"
static __attribute__((__nothrow__)) char *( __attribute__((__nonnull__(1), __leaf__)) strchr)(char const *str ,
                                                                                               int chr ) __attribute__((__pure__)) ;
# 2020 "gzip.c"
static char *( __attribute__((__nonnull__(1), __leaf__)) strchr)(char const *str ,
                                                                 int chr )
{
  char *__retres3 ;

  {
  {
# 2025 "gzip.c"
  while (1) {
    while_continue: ;
# 2025 "gzip.c"
    if (*str != 0) {

    } else {
# 2025 "gzip.c"
      goto while_break;
    }
# 2027 "gzip.c"
    if ((int const )*str == (int const )chr) {
# 2028 "gzip.c"
      __retres3 = (char *)str;
# 2028 "gzip.c"
      goto return_label;
    } else {

    }
# 2029 "gzip.c"
    str ++;
  }
  while_break: ;
  }
# 2031 "gzip.c"
  __retres3 = (char *)0;
  return_label:
# 2020 "gzip.c"
  return (__retres3);
}
}
# 2053 "gzip.c"
static int first_nonopt ;
# 2054 "gzip.c"
static int last_nonopt ;
# 2112 "gzip.c"
static void exchange(char **argv ) ;
# 2115 "gzip.c"
static void exchange(char **argv )
{
  int bottom ;
  int middle ;
  int top ;
  char *tem ;
  int len ;
  register int i ;
  int len___0 ;
  register int i___0 ;
  char **mem_10 ;
  char **mem_11 ;
  char **mem_12 ;
  char **mem_13 ;
  char **mem_14 ;
  char **mem_15 ;
  char **mem_16 ;
  char **mem_17 ;

  {
# 2119 "gzip.c"
  bottom = first_nonopt;
# 2120 "gzip.c"
  middle = last_nonopt;
# 2121 "gzip.c"
  top = optind;
  {
# 2151 "gzip.c"
  while (1) {
    while_continue: ;
# 2151 "gzip.c"
    if (top > middle) {
# 2151 "gzip.c"
      if (middle > bottom) {

      } else {
# 2151 "gzip.c"
        goto while_break;
      }
    } else {
# 2151 "gzip.c"
      goto while_break;
    }
# 2153 "gzip.c"
    if (top - middle > middle - bottom) {
# 2156 "gzip.c"
      len = middle - bottom;
# 2160 "gzip.c"
      i = 0;
      {
# 2160 "gzip.c"
      while (1) {
        while_continue___0: ;
# 2160 "gzip.c"
        if (i < len) {

        } else {
# 2160 "gzip.c"
          goto while_break___0;
        }
# 2162 "gzip.c"
        mem_10 = argv + (bottom + i);
# 2162 "gzip.c"
        tem = *mem_10;
# 2163 "gzip.c"
        mem_11 = argv + (bottom + i);
# 2163 "gzip.c"
        mem_12 = argv + ((top - (middle - bottom)) + i);
# 2163 "gzip.c"
        *mem_11 = *mem_12;
# 2164 "gzip.c"
        mem_13 = argv + ((top - (middle - bottom)) + i);
# 2164 "gzip.c"
        *mem_13 = tem;
# 2160 "gzip.c"
        i ++;
      }
      while_break___0: ;
      }
# 2168 "gzip.c"
      top -= len;
    } else {
# 2173 "gzip.c"
      len___0 = top - middle;
# 2177 "gzip.c"
      i___0 = 0;
      {
# 2177 "gzip.c"
      while (1) {
        while_continue___1: ;
# 2177 "gzip.c"
        if (i___0 < len___0) {

        } else {
# 2177 "gzip.c"
          goto while_break___1;
        }
# 2179 "gzip.c"
        mem_14 = argv + (bottom + i___0);
# 2179 "gzip.c"
        tem = *mem_14;
# 2180 "gzip.c"
        mem_15 = argv + (bottom + i___0);
# 2180 "gzip.c"
        mem_16 = argv + (middle + i___0);
# 2180 "gzip.c"
        *mem_15 = *mem_16;
# 2181 "gzip.c"
        mem_17 = argv + (middle + i___0);
# 2181 "gzip.c"
        *mem_17 = tem;
# 2177 "gzip.c"
        i___0 ++;
      }
      while_break___1: ;
      }
# 2185 "gzip.c"
      bottom += len___0;
    }
  }
  while_break: ;
  }
# 2191 "gzip.c"
  first_nonopt += optind - last_nonopt;
# 2192 "gzip.c"
  last_nonopt = optind;
# 2115 "gzip.c"
  return;
}
}
# 2198 "gzip.c"
static char const *_getopt_initialize(int argc , char * const *argv , char const *optstring ) ;
# 2200 "gzip.c"
static char const *_getopt_initialize(int argc , char * const *argv , char const *optstring )
{
  char const *mem_4 ;
  char const *mem_5 ;

  {
# 2210 "gzip.c"
  last_nonopt = optind;
# 2210 "gzip.c"
  first_nonopt = last_nonopt;
# 2212 "gzip.c"
  nextchar = (char *)((void *)0);
# 2214 "gzip.c"
  posixly_correct = getenv("POSIXLY_CORRECT");
  {
# 2218 "gzip.c"
  mem_4 = optstring + 0;
# 2218 "gzip.c"
  if ((int const )*mem_4 == 45) {
# 2220 "gzip.c"
    ordering = (enum __anonenum_ordering_55 )2;
# 2221 "gzip.c"
    optstring ++;
  } else {
    {
# 2223 "gzip.c"
    mem_5 = optstring + 0;
# 2223 "gzip.c"
    if ((int const )*mem_5 == 43) {
# 2225 "gzip.c"
      ordering = (enum __anonenum_ordering_55 )0;
# 2226 "gzip.c"
      optstring ++;
    } else
# 2228 "gzip.c"
    if ((unsigned int )posixly_correct != (unsigned int )((void *)0)) {
# 2229 "gzip.c"
      ordering = (enum __anonenum_ordering_55 )0;
    } else {
# 2231 "gzip.c"
      ordering = (enum __anonenum_ordering_55 )1;
    }
    }
  }
  }
# 2263 "gzip.c"
  return (optstring);
}
}
# 2322 "gzip.c"
int _getopt_internal(int argc , char * const *argv , char const *optstring , struct option const *longopts ,
                     int *longind , int long_only )
{
  int print_errors ;
  int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  char *nameend ;
  struct option const *p ;
  struct option const *pfound ;
  int exact ;
  int ambig ;
  int indfound ;
  int option_index ;
  size_t tmp___2 ;
  int tmp___3 ;
  size_t tmp___4 ;
  size_t tmp___5 ;
  int tmp___6 ;
  size_t tmp___7 ;
  int tmp___8 ;
  size_t tmp___9 ;
  char *tmp___10 ;
  char *tmp___11 ;
  char c ;
  char *tmp___12 ;
  char *temp ;
  char *tmp___13 ;
  char *nameend___0 ;
  struct option const *p___0 ;
  struct option const *pfound___0 ;
  int exact___0 ;
  int ambig___0 ;
  int indfound___0 ;
  int option_index___0 ;
  int tmp___14 ;
  size_t tmp___15 ;
  int tmp___16 ;
  size_t tmp___17 ;
  size_t tmp___18 ;
  int tmp___19 ;
  size_t tmp___20 ;
  int tmp___21 ;
  size_t tmp___22 ;
  int tmp___23 ;
  char const *mem_49 ;
  char * const *mem_50 ;
  char *mem_51 ;
  char * const *mem_52 ;
  char *mem_53 ;
  char * const *mem_54 ;
  char * const *mem_55 ;
  char *mem_56 ;
  char * const *mem_57 ;
  char *mem_58 ;
  char * const *mem_59 ;
  char * const *mem_60 ;
  char *mem_61 ;
  char * const *mem_62 ;
  char * const *mem_63 ;
  char *mem_64 ;
  char * const *mem_65 ;
  char *mem_66 ;
  char * const *mem_67 ;
  char *mem_68 ;
  char * const *mem_69 ;
  char * const *mem_70 ;
  char * const *mem_71 ;
  char *mem_72 ;
  char * const *mem_73 ;
  char * const *mem_74 ;
  char * const *mem_75 ;
  char *mem_76 ;
  char * const *mem_77 ;
  char * const *mem_78 ;
  char * const *mem_79 ;
  char const *mem_80 ;
  int *mem_81 ;
  char * const *mem_82 ;
  char *mem_83 ;
  char * const *mem_84 ;
  char *mem_85 ;
  char * const *mem_86 ;
  char * const *mem_87 ;
  char * const *mem_88 ;
  char *mem_89 ;
  char * const *mem_90 ;
  char * const *mem_91 ;
  char *mem_92 ;
  char *mem_93 ;
  char * const *mem_94 ;
  char const *mem_95 ;
  char * const *mem_96 ;
  char * const *mem_97 ;
  char * const *mem_98 ;
  char * const *mem_99 ;
  char * const *mem_100 ;
  char * const *mem_101 ;
  char * const *mem_102 ;
  char const *mem_103 ;
  int *mem_104 ;
  char *mem_105 ;
  char *mem_106 ;
  char * const *mem_107 ;
  char const *mem_108 ;
  char * const *mem_109 ;
  int __retres110 ;

  {
# 2331 "gzip.c"
  print_errors = opterr;
  {
# 2332 "gzip.c"
  mem_49 = optstring + 0;
# 2332 "gzip.c"
  if ((int const )*mem_49 == 58) {
# 2333 "gzip.c"
    print_errors = 0;
  } else {

  }
  }
# 2335 "gzip.c"
  if (argc < 1) {
# 2336 "gzip.c"
    __retres110 = -1;
# 2336 "gzip.c"
    goto return_label;
  } else {

  }
# 2338 "gzip.c"
  optarg = (char *)((void *)0);
# 2340 "gzip.c"
  if (optind == 0) {
# 2340 "gzip.c"
    goto _L;
  } else
# 2340 "gzip.c"
  if (__getopt_initialized == 0) {
    _L:
# 2342 "gzip.c"
    if (optind == 0) {
# 2343 "gzip.c"
      optind = 1;
    } else {

    }
# 2344 "gzip.c"
    optstring = _getopt_initialize(argc, argv, optstring);
# 2345 "gzip.c"
    __getopt_initialized = 1;
  } else {

  }
# 2360 "gzip.c"
  if ((unsigned int )nextchar == (unsigned int )((void *)0)) {
# 2360 "gzip.c"
    goto _L___3;
  } else
# 2360 "gzip.c"
  if ((int )*nextchar == 0) {
    _L___3:
# 2366 "gzip.c"
    if (last_nonopt > optind) {
# 2367 "gzip.c"
      last_nonopt = optind;
    } else {

    }
# 2368 "gzip.c"
    if (first_nonopt > optind) {
# 2369 "gzip.c"
      first_nonopt = optind;
    } else {

    }
# 2371 "gzip.c"
    if ((unsigned int )ordering == 1U) {
# 2376 "gzip.c"
      if (first_nonopt != last_nonopt) {
# 2376 "gzip.c"
        if (last_nonopt != optind) {
# 2377 "gzip.c"
          exchange((char **)argv);
        } else {
# 2376 "gzip.c"
          goto _L___0;
        }
      } else
      _L___0:
# 2378 "gzip.c"
      if (last_nonopt != optind) {
# 2379 "gzip.c"
        first_nonopt = optind;
      } else {

      }
      {
# 2384 "gzip.c"
      while (1) {
        while_continue: ;
# 2384 "gzip.c"
        if (optind < argc) {
          {
# 2384 "gzip.c"
          mem_50 = argv + optind;
# 2384 "gzip.c"
          mem_51 = *mem_50 + 0;
# 2384 "gzip.c"
          if ((int )*mem_51 != 45) {

          } else {
            {
# 2384 "gzip.c"
            mem_52 = argv + optind;
# 2384 "gzip.c"
            mem_53 = *mem_52 + 1;
# 2384 "gzip.c"
            if ((int )*mem_53 == 0) {

            } else {
# 2384 "gzip.c"
              goto while_break;
            }
            }
          }
          }
        } else {
# 2384 "gzip.c"
          goto while_break;
        }
# 2385 "gzip.c"
        optind ++;
      }
      while_break: ;
      }
# 2386 "gzip.c"
      last_nonopt = optind;
    } else {

    }
# 2394 "gzip.c"
    if (optind != argc) {
# 2394 "gzip.c"
      mem_54 = argv + optind;
# 2394 "gzip.c"
      tmp = strcmp((char const *)*mem_54, "--");
# 2394 "gzip.c"
      if (tmp != 0) {

      } else {
# 2396 "gzip.c"
        optind ++;
# 2398 "gzip.c"
        if (first_nonopt != last_nonopt) {
# 2398 "gzip.c"
          if (last_nonopt != optind) {
# 2399 "gzip.c"
            exchange((char **)argv);
          } else {
# 2398 "gzip.c"
            goto _L___1;
          }
        } else
        _L___1:
# 2400 "gzip.c"
        if (first_nonopt == last_nonopt) {
# 2401 "gzip.c"
          first_nonopt = optind;
        } else {

        }
# 2402 "gzip.c"
        last_nonopt = argc;
# 2404 "gzip.c"
        optind = argc;
      }
    } else {

    }
# 2410 "gzip.c"
    if (optind == argc) {
# 2414 "gzip.c"
      if (first_nonopt != last_nonopt) {
# 2415 "gzip.c"
        optind = first_nonopt;
      } else {

      }
# 2416 "gzip.c"
      __retres110 = -1;
# 2416 "gzip.c"
      goto return_label;
    } else {

    }
    {
# 2422 "gzip.c"
    mem_55 = argv + optind;
# 2422 "gzip.c"
    mem_56 = *mem_55 + 0;
# 2422 "gzip.c"
    if ((int )*mem_56 != 45) {
# 2422 "gzip.c"
      goto _L___2;
    } else {
      {
# 2422 "gzip.c"
      mem_57 = argv + optind;
# 2422 "gzip.c"
      mem_58 = *mem_57 + 1;
# 2422 "gzip.c"
      if ((int )*mem_58 == 0) {
        _L___2:
# 2424 "gzip.c"
        if ((unsigned int )ordering == 0U) {
# 2425 "gzip.c"
          __retres110 = -1;
# 2425 "gzip.c"
          goto return_label;
        } else {

        }
# 2426 "gzip.c"
        tmp___0 = optind;
# 2426 "gzip.c"
        optind ++;
# 2426 "gzip.c"
        mem_59 = argv + tmp___0;
# 2426 "gzip.c"
        optarg = (char *)*mem_59;
# 2427 "gzip.c"
        __retres110 = 1;
# 2427 "gzip.c"
        goto return_label;
      } else {

      }
      }
    }
    }
# 2433 "gzip.c"
    if ((unsigned int )longopts != (unsigned int )((void *)0)) {
      {
# 2433 "gzip.c"
      mem_60 = argv + optind;
# 2433 "gzip.c"
      mem_61 = *mem_60 + 1;
# 2433 "gzip.c"
      if ((int )*mem_61 == 45) {
# 2433 "gzip.c"
        tmp___1 = 1;
      } else {
# 2433 "gzip.c"
        tmp___1 = 0;
      }
      }
    } else {
# 2433 "gzip.c"
      tmp___1 = 0;
    }
# 2433 "gzip.c"
    mem_62 = argv + optind;
# 2433 "gzip.c"
    nextchar = (char *)((*mem_62 + 1) + tmp___1);
  } else {

  }
# 2452 "gzip.c"
  if ((unsigned int )longopts != (unsigned int )((void *)0)) {
    {
# 2452 "gzip.c"
    mem_63 = argv + optind;
# 2452 "gzip.c"
    mem_64 = *mem_63 + 1;
# 2452 "gzip.c"
    if ((int )*mem_64 == 45) {
# 2452 "gzip.c"
      goto _L___6;
    } else
# 2452 "gzip.c"
    if (long_only != 0) {
      {
# 2452 "gzip.c"
      mem_65 = argv + optind;
# 2452 "gzip.c"
      mem_66 = *mem_65 + 2;
# 2452 "gzip.c"
      if (*mem_66 != 0) {
# 2452 "gzip.c"
        goto _L___6;
      } else {
# 2452 "gzip.c"
        mem_67 = argv + optind;
# 2452 "gzip.c"
        mem_68 = *mem_67 + 1;
# 2452 "gzip.c"
        tmp___11 = strchr(optstring, (int )*mem_68);
# 2452 "gzip.c"
        if (tmp___11 != 0) {

        } else {
          _L___6:
# 2458 "gzip.c"
          pfound = (struct option const *)((void *)0);
# 2459 "gzip.c"
          exact = 0;
# 2460 "gzip.c"
          ambig = 0;
# 2461 "gzip.c"
          indfound = -1;
# 2464 "gzip.c"
          nameend = nextchar;
          {
# 2464 "gzip.c"
          while (1) {
            while_continue___0: ;
# 2464 "gzip.c"
            if (*nameend != 0) {
# 2464 "gzip.c"
              if ((int )*nameend != 61) {

              } else {
# 2464 "gzip.c"
                goto while_break___0;
              }
            } else {
# 2464 "gzip.c"
              goto while_break___0;
            }
# 2464 "gzip.c"
            nameend ++;
          }
          while_break___0: ;
          }
# 2469 "gzip.c"
          p = longopts;
# 2469 "gzip.c"
          option_index = 0;
          {
# 2469 "gzip.c"
          while (1) {
            while_continue___1: ;
# 2469 "gzip.c"
            if (p->name != 0) {

            } else {
# 2469 "gzip.c"
              goto while_break___1;
            }
# 2470 "gzip.c"
            tmp___3 = strncmp((char const *)p->name, (char const *)nextchar, (size_t )(nameend - nextchar));
# 2470 "gzip.c"
            if (tmp___3 != 0) {

            } else {
# 2472 "gzip.c"
              tmp___2 = strlen((char const *)p->name);
# 2472 "gzip.c"
              if ((unsigned int )(nameend - nextchar) == tmp___2) {
# 2476 "gzip.c"
                pfound = p;
# 2477 "gzip.c"
                indfound = option_index;
# 2478 "gzip.c"
                exact = 1;
# 2479 "gzip.c"
                goto while_break___1;
              } else
# 2481 "gzip.c"
              if ((unsigned int )pfound == (unsigned int )((void *)0)) {
# 2484 "gzip.c"
                pfound = p;
# 2485 "gzip.c"
                indfound = option_index;
              } else
# 2487 "gzip.c"
              if (long_only != 0) {
# 2492 "gzip.c"
                ambig = 1;
              } else
# 2487 "gzip.c"
              if (pfound->has_arg != p->has_arg) {
# 2492 "gzip.c"
                ambig = 1;
              } else
# 2487 "gzip.c"
              if ((unsigned int )pfound->flag != (unsigned int )p->flag) {
# 2492 "gzip.c"
                ambig = 1;
              } else
# 2487 "gzip.c"
              if (pfound->val != p->val) {
# 2492 "gzip.c"
                ambig = 1;
              } else {

              }
            }
# 2469 "gzip.c"
            p ++;
# 2469 "gzip.c"
            option_index ++;
          }
          while_break___1: ;
          }
# 2495 "gzip.c"
          if (ambig != 0) {
# 2495 "gzip.c"
            if (exact == 0) {
# 2497 "gzip.c"
              if (print_errors != 0) {
# 2498 "gzip.c"
                mem_69 = argv + 0;
# 2498 "gzip.c"
                mem_70 = argv + optind;
# 2498 "gzip.c"
                fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `%s\' is ambiguous\n",
                        *mem_69, *mem_70);
              } else {

              }
# 2500 "gzip.c"
              tmp___4 = strlen((char const *)nextchar);
# 2500 "gzip.c"
              nextchar += tmp___4;
# 2501 "gzip.c"
              optind ++;
# 2502 "gzip.c"
              optopt = 0;
# 2503 "gzip.c"
              __retres110 = '?';
# 2503 "gzip.c"
              goto return_label;
            } else {

            }
          } else {

          }
# 2506 "gzip.c"
          if ((unsigned int )pfound != (unsigned int )((void *)0)) {
# 2508 "gzip.c"
            option_index = indfound;
# 2509 "gzip.c"
            optind ++;
# 2510 "gzip.c"
            if (*nameend != 0) {
# 2514 "gzip.c"
              if (pfound->has_arg != 0) {
# 2515 "gzip.c"
                optarg = nameend + 1;
              } else {
# 2518 "gzip.c"
                if (print_errors != 0) {
                  {
# 2520 "gzip.c"
                  mem_71 = argv + (optind - 1);
# 2520 "gzip.c"
                  mem_72 = *mem_71 + 1;
# 2520 "gzip.c"
                  if ((int )*mem_72 == 45) {
# 2522 "gzip.c"
                    mem_73 = argv + 0;
# 2522 "gzip.c"
                    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `--%s\' doesn\'t allow an argument\n",
                            *mem_73, pfound->name);
                  } else {
# 2527 "gzip.c"
                    mem_74 = argv + 0;
# 2527 "gzip.c"
                    mem_75 = argv + (optind - 1);
# 2527 "gzip.c"
                    mem_76 = *mem_75 + 0;
# 2527 "gzip.c"
                    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `%c%s\' doesn\'t allow an argument\n",
                            *mem_74, (int )*mem_76, pfound->name);
                  }
                  }
                } else {

                }
# 2532 "gzip.c"
                tmp___5 = strlen((char const *)nextchar);
# 2532 "gzip.c"
                nextchar += tmp___5;
# 2534 "gzip.c"
                optopt = (int )pfound->val;
# 2535 "gzip.c"
                __retres110 = '?';
# 2535 "gzip.c"
                goto return_label;
              }
            } else
# 2538 "gzip.c"
            if (pfound->has_arg == 1) {
# 2540 "gzip.c"
              if (optind < argc) {
# 2541 "gzip.c"
                tmp___6 = optind;
# 2541 "gzip.c"
                optind ++;
# 2541 "gzip.c"
                mem_77 = argv + tmp___6;
# 2541 "gzip.c"
                optarg = (char *)*mem_77;
              } else {
# 2544 "gzip.c"
                if (print_errors != 0) {
# 2545 "gzip.c"
                  mem_78 = argv + 0;
# 2545 "gzip.c"
                  mem_79 = argv + (optind - 1);
# 2545 "gzip.c"
                  fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `%s\' requires an argument\n",
                          *mem_78, *mem_79);
                } else {

                }
# 2548 "gzip.c"
                tmp___7 = strlen((char const *)nextchar);
# 2548 "gzip.c"
                nextchar += tmp___7;
# 2549 "gzip.c"
                optopt = (int )pfound->val;
                {
# 2550 "gzip.c"
                mem_80 = optstring + 0;
# 2550 "gzip.c"
                if ((int const )*mem_80 == 58) {
# 2550 "gzip.c"
                  tmp___8 = ':';
                } else {
# 2550 "gzip.c"
                  tmp___8 = '?';
                }
                }
# 2550 "gzip.c"
                __retres110 = tmp___8;
# 2550 "gzip.c"
                goto return_label;
              }
            } else {

            }
# 2553 "gzip.c"
            tmp___9 = strlen((char const *)nextchar);
# 2553 "gzip.c"
            nextchar += tmp___9;
# 2554 "gzip.c"
            if ((unsigned int )longind != (unsigned int )((void *)0)) {
# 2555 "gzip.c"
              *longind = option_index;
            } else {

            }
# 2556 "gzip.c"
            if (pfound->flag != 0) {
# 2558 "gzip.c"
              mem_81 = pfound->flag;
# 2558 "gzip.c"
              *mem_81 = (int )pfound->val;
# 2559 "gzip.c"
              __retres110 = 0;
# 2559 "gzip.c"
              goto return_label;
            } else {

            }
# 2561 "gzip.c"
            __retres110 = (int )pfound->val;
# 2561 "gzip.c"
            goto return_label;
          } else {

          }
# 2568 "gzip.c"
          if (long_only == 0) {
# 2568 "gzip.c"
            goto _L___4;
          } else {
            {
# 2568 "gzip.c"
            mem_82 = argv + optind;
# 2568 "gzip.c"
            mem_83 = *mem_82 + 1;
# 2568 "gzip.c"
            if ((int )*mem_83 == 45) {
# 2568 "gzip.c"
              goto _L___4;
            } else {
# 2568 "gzip.c"
              tmp___10 = strchr(optstring, (int )*nextchar);
# 2568 "gzip.c"
              if ((unsigned int )tmp___10 == (unsigned int )((void *)0)) {
                _L___4:
# 2571 "gzip.c"
                if (print_errors != 0) {
                  {
# 2573 "gzip.c"
                  mem_84 = argv + optind;
# 2573 "gzip.c"
                  mem_85 = *mem_84 + 1;
# 2573 "gzip.c"
                  if ((int )*mem_85 == 45) {
# 2575 "gzip.c"
                    mem_86 = argv + 0;
# 2575 "gzip.c"
                    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: unrecognized option `--%s\'\n",
                            *mem_86, nextchar);
                  } else {
# 2579 "gzip.c"
                    mem_87 = argv + 0;
# 2579 "gzip.c"
                    mem_88 = argv + optind;
# 2579 "gzip.c"
                    mem_89 = *mem_88 + 0;
# 2579 "gzip.c"
                    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: unrecognized option `%c%s\'\n",
                            *mem_87, (int )*mem_89, nextchar);
                  }
                  }
                } else {

                }
# 2582 "gzip.c"
                nextchar = (char *)"";
# 2583 "gzip.c"
                optind ++;
# 2584 "gzip.c"
                optopt = 0;
# 2585 "gzip.c"
                __retres110 = '?';
# 2585 "gzip.c"
                goto return_label;
              } else {

              }
            }
            }
          }
        }
      }
      }
    } else {

    }
    }
  } else {

  }
# 2592 "gzip.c"
  tmp___12 = nextchar;
# 2592 "gzip.c"
  nextchar ++;
# 2592 "gzip.c"
  c = *tmp___12;
# 2593 "gzip.c"
  tmp___13 = strchr(optstring, (int )c);
# 2593 "gzip.c"
  temp = tmp___13;
# 2596 "gzip.c"
  if ((int )*nextchar == 0) {
# 2597 "gzip.c"
    optind ++;
  } else {

  }
# 2599 "gzip.c"
  if ((unsigned int )temp == (unsigned int )((void *)0)) {
# 2599 "gzip.c"
    goto _L___7;
  } else
# 2599 "gzip.c"
  if ((int )c == 58) {
    _L___7:
# 2601 "gzip.c"
    if (print_errors != 0) {
# 2603 "gzip.c"
      if (posixly_correct != 0) {
# 2605 "gzip.c"
        mem_90 = argv + 0;
# 2605 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: illegal option -- %c\n",
                *mem_90, (int )c);
      } else {
# 2608 "gzip.c"
        mem_91 = argv + 0;
# 2608 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: invalid option -- %c\n",
                *mem_91, (int )c);
      }
    } else {

    }
# 2611 "gzip.c"
    optopt = (int )c;
# 2612 "gzip.c"
    __retres110 = '?';
# 2612 "gzip.c"
    goto return_label;
  } else {

  }
  {
# 2615 "gzip.c"
  mem_92 = temp + 0;
# 2615 "gzip.c"
  if ((int )*mem_92 == 87) {
    {
# 2615 "gzip.c"
    mem_93 = temp + 1;
# 2615 "gzip.c"
    if ((int )*mem_93 == 59) {
# 2619 "gzip.c"
      pfound___0 = (struct option const *)((void *)0);
# 2620 "gzip.c"
      exact___0 = 0;
# 2621 "gzip.c"
      ambig___0 = 0;
# 2622 "gzip.c"
      indfound___0 = 0;
# 2626 "gzip.c"
      if ((int )*nextchar != 0) {
# 2628 "gzip.c"
        optarg = nextchar;
# 2631 "gzip.c"
        optind ++;
      } else
# 2633 "gzip.c"
      if (optind == argc) {
# 2635 "gzip.c"
        if (print_errors != 0) {
# 2638 "gzip.c"
          mem_94 = argv + 0;
# 2638 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option requires an argument -- %c\n",
                  *mem_94, (int )c);
        } else {

        }
# 2641 "gzip.c"
        optopt = (int )c;
        {
# 2642 "gzip.c"
        mem_95 = optstring + 0;
# 2642 "gzip.c"
        if ((int const )*mem_95 == 58) {
# 2643 "gzip.c"
          c = (char )':';
        } else {
# 2645 "gzip.c"
          c = (char )'?';
        }
        }
# 2646 "gzip.c"
        __retres110 = (int )c;
# 2646 "gzip.c"
        goto return_label;
      } else {
# 2651 "gzip.c"
        tmp___14 = optind;
# 2651 "gzip.c"
        optind ++;
# 2651 "gzip.c"
        mem_96 = argv + tmp___14;
# 2651 "gzip.c"
        optarg = (char *)*mem_96;
      }
# 2656 "gzip.c"
      nameend___0 = optarg;
# 2656 "gzip.c"
      nextchar = nameend___0;
      {
# 2656 "gzip.c"
      while (1) {
        while_continue___2: ;
# 2656 "gzip.c"
        if (*nameend___0 != 0) {
# 2656 "gzip.c"
          if ((int )*nameend___0 != 61) {

          } else {
# 2656 "gzip.c"
            goto while_break___2;
          }
        } else {
# 2656 "gzip.c"
          goto while_break___2;
        }
# 2656 "gzip.c"
        nameend___0 ++;
      }
      while_break___2: ;
      }
# 2661 "gzip.c"
      p___0 = longopts;
# 2661 "gzip.c"
      option_index___0 = 0;
      {
# 2661 "gzip.c"
      while (1) {
        while_continue___3: ;
# 2661 "gzip.c"
        if (p___0->name != 0) {

        } else {
# 2661 "gzip.c"
          goto while_break___3;
        }
# 2662 "gzip.c"
        tmp___16 = strncmp((char const *)p___0->name, (char const *)nextchar,
                           (size_t )(nameend___0 - nextchar));
# 2662 "gzip.c"
        if (tmp___16 != 0) {

        } else {
# 2664 "gzip.c"
          tmp___15 = strlen((char const *)p___0->name);
# 2664 "gzip.c"
          if ((unsigned int )(nameend___0 - nextchar) == tmp___15) {
# 2667 "gzip.c"
            pfound___0 = p___0;
# 2668 "gzip.c"
            indfound___0 = option_index___0;
# 2669 "gzip.c"
            exact___0 = 1;
# 2670 "gzip.c"
            goto while_break___3;
          } else
# 2672 "gzip.c"
          if ((unsigned int )pfound___0 == (unsigned int )((void *)0)) {
# 2675 "gzip.c"
            pfound___0 = p___0;
# 2676 "gzip.c"
            indfound___0 = option_index___0;
          } else {
# 2680 "gzip.c"
            ambig___0 = 1;
          }
        }
# 2661 "gzip.c"
        p___0 ++;
# 2661 "gzip.c"
        option_index___0 ++;
      }
      while_break___3: ;
      }
# 2682 "gzip.c"
      if (ambig___0 != 0) {
# 2682 "gzip.c"
        if (exact___0 == 0) {
# 2684 "gzip.c"
          if (print_errors != 0) {
# 2685 "gzip.c"
            mem_97 = argv + 0;
# 2685 "gzip.c"
            mem_98 = argv + optind;
# 2685 "gzip.c"
            fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `-W %s\' is ambiguous\n",
                    *mem_97, *mem_98);
          } else {

          }
# 2687 "gzip.c"
          tmp___17 = strlen((char const *)nextchar);
# 2687 "gzip.c"
          nextchar += tmp___17;
# 2688 "gzip.c"
          optind ++;
# 2689 "gzip.c"
          __retres110 = '?';
# 2689 "gzip.c"
          goto return_label;
        } else {

        }
      } else {

      }
# 2691 "gzip.c"
      if ((unsigned int )pfound___0 != (unsigned int )((void *)0)) {
# 2693 "gzip.c"
        option_index___0 = indfound___0;
# 2694 "gzip.c"
        if (*nameend___0 != 0) {
# 2698 "gzip.c"
          if (pfound___0->has_arg != 0) {
# 2699 "gzip.c"
            optarg = nameend___0 + 1;
          } else {
# 2702 "gzip.c"
            if (print_errors != 0) {
# 2703 "gzip.c"
              mem_99 = argv + 0;
# 2703 "gzip.c"
              fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `-W %s\' doesn\'t allow an argument\n",
                      *mem_99, pfound___0->name);
            } else {

            }
# 2707 "gzip.c"
            tmp___18 = strlen((char const *)nextchar);
# 2707 "gzip.c"
            nextchar += tmp___18;
# 2708 "gzip.c"
            __retres110 = '?';
# 2708 "gzip.c"
            goto return_label;
          }
        } else
# 2711 "gzip.c"
        if (pfound___0->has_arg == 1) {
# 2713 "gzip.c"
          if (optind < argc) {
# 2714 "gzip.c"
            tmp___19 = optind;
# 2714 "gzip.c"
            optind ++;
# 2714 "gzip.c"
            mem_100 = argv + tmp___19;
# 2714 "gzip.c"
            optarg = (char *)*mem_100;
          } else {
# 2717 "gzip.c"
            if (print_errors != 0) {
# 2718 "gzip.c"
              mem_101 = argv + 0;
# 2718 "gzip.c"
              mem_102 = argv + (optind - 1);
# 2718 "gzip.c"
              fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option `%s\' requires an argument\n",
                      *mem_101, *mem_102);
            } else {

            }
# 2721 "gzip.c"
            tmp___20 = strlen((char const *)nextchar);
# 2721 "gzip.c"
            nextchar += tmp___20;
            {
# 2722 "gzip.c"
            mem_103 = optstring + 0;
# 2722 "gzip.c"
            if ((int const )*mem_103 == 58) {
# 2722 "gzip.c"
              tmp___21 = ':';
            } else {
# 2722 "gzip.c"
              tmp___21 = '?';
            }
            }
# 2722 "gzip.c"
            __retres110 = tmp___21;
# 2722 "gzip.c"
            goto return_label;
          }
        } else {

        }
# 2725 "gzip.c"
        tmp___22 = strlen((char const *)nextchar);
# 2725 "gzip.c"
        nextchar += tmp___22;
# 2726 "gzip.c"
        if ((unsigned int )longind != (unsigned int )((void *)0)) {
# 2727 "gzip.c"
          *longind = option_index___0;
        } else {

        }
# 2728 "gzip.c"
        if (pfound___0->flag != 0) {
# 2730 "gzip.c"
          mem_104 = pfound___0->flag;
# 2730 "gzip.c"
          *mem_104 = (int )pfound___0->val;
# 2731 "gzip.c"
          __retres110 = 0;
# 2731 "gzip.c"
          goto return_label;
        } else {

        }
# 2733 "gzip.c"
        __retres110 = (int )pfound___0->val;
# 2733 "gzip.c"
        goto return_label;
      } else {

      }
# 2735 "gzip.c"
      nextchar = (char *)((void *)0);
# 2736 "gzip.c"
      __retres110 = 'W';
# 2736 "gzip.c"
      goto return_label;
    } else {

    }
    }
  } else {

  }
  }
  {
# 2738 "gzip.c"
  mem_105 = temp + 1;
# 2738 "gzip.c"
  if ((int )*mem_105 == 58) {
    {
# 2740 "gzip.c"
    mem_106 = temp + 2;
# 2740 "gzip.c"
    if ((int )*mem_106 == 58) {
# 2743 "gzip.c"
      if ((int )*nextchar != 0) {
# 2745 "gzip.c"
        optarg = nextchar;
# 2746 "gzip.c"
        optind ++;
      } else {
# 2749 "gzip.c"
        optarg = (char *)((void *)0);
      }
# 2750 "gzip.c"
      nextchar = (char *)((void *)0);
    } else {
# 2755 "gzip.c"
      if ((int )*nextchar != 0) {
# 2757 "gzip.c"
        optarg = nextchar;
# 2760 "gzip.c"
        optind ++;
      } else
# 2762 "gzip.c"
      if (optind == argc) {
# 2764 "gzip.c"
        if (print_errors != 0) {
# 2767 "gzip.c"
          mem_107 = argv + 0;
# 2767 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option requires an argument -- %c\n",
                  *mem_107, (int )c);
        } else {

        }
# 2771 "gzip.c"
        optopt = (int )c;
        {
# 2772 "gzip.c"
        mem_108 = optstring + 0;
# 2772 "gzip.c"
        if ((int const )*mem_108 == 58) {
# 2773 "gzip.c"
          c = (char )':';
        } else {
# 2775 "gzip.c"
          c = (char )'?';
        }
        }
      } else {
# 2780 "gzip.c"
        tmp___23 = optind;
# 2780 "gzip.c"
        optind ++;
# 2780 "gzip.c"
        mem_109 = argv + tmp___23;
# 2780 "gzip.c"
        optarg = (char *)*mem_109;
      }
# 2781 "gzip.c"
      nextchar = (char *)((void *)0);
    }
    }
  } else {

  }
  }
# 2784 "gzip.c"
  __retres110 = (int )c;
  return_label:
# 2322 "gzip.c"
  return (__retres110);
}
}
# 2788 "gzip.c"
 __attribute__((__nothrow__)) int ( __attribute__((__leaf__)) getopt)(int argc , char * const *argv ,
                                                                      char const *optstring ) ;
# 2788 "gzip.c"
int ( __attribute__((__leaf__)) getopt)(int argc , char * const *argv , char const *optstring )
{
  int tmp ;

  {
# 2794 "gzip.c"
  tmp = _getopt_internal(argc, argv, optstring, (struct option const *)0, (int *)0,
                         0);
# 2794 "gzip.c"
  return (tmp);
}
}
# 2849 "gzip.c"
static char *license_msg[7] = { (char *)"Copyright 2002 Free Software Foundation", (char *)"Copyright 1992-1993 Jean-loup Gailly", (char *)"This program comes with ABSOLUTELY NO WARRANTY.", (char *)"You may redistribute copies of this program",
        (char *)"under the terms of the GNU General Public License.", (char *)"For more information about these matters, see the file named COPYING.", (char *)0};
# 2986 "gzip.c"
int ascii = 0;
# 2987 "gzip.c"
int to_stdout = 0;
# 2988 "gzip.c"
int decompress = 0;
# 2989 "gzip.c"
int force = 0;
# 2990 "gzip.c"
int no_name = -1;
# 2991 "gzip.c"
int no_time = -1;
# 2992 "gzip.c"
int recursive = 0;
# 2993 "gzip.c"
int list = 0;
# 2994 "gzip.c"
int verbose = 0;
# 2995 "gzip.c"
int quiet = 0;
# 2996 "gzip.c"
int do_lzw = 0;
# 2997 "gzip.c"
int test = 0;
# 2998 "gzip.c"
int foreground ;
# 3000 "gzip.c"
int maxbits = 16;
# 3001 "gzip.c"
int method = 8;
# 3002 "gzip.c"
int level = 6;
# 3003 "gzip.c"
int exit_code = 0;
# 3005 "gzip.c"
int last_member ;
# 3006 "gzip.c"
int part_nb ;
# 3009 "gzip.c"
char *env ;
# 3010 "gzip.c"
char **args = (char **)((void *)0);
# 3011 "gzip.c"
char *z_suffix ;
# 3012 "gzip.c"
size_t z_len ;
# 3016 "gzip.c"
off_t total_in ;
# 3017 "gzip.c"
off_t total_out ;
# 3020 "gzip.c"
int remove_ofname = 0;
# 3021 "gzip.c"
struct stat istat ;
# 3027 "gzip.c"
int rsync = 0;
# 3029 "gzip.c"
struct option longopts[25] =
# 3029 "gzip.c"
  { {"ascii", 0, (int *)0, 'a'},
        {"to-stdout", 0, (int *)0, 'c'},
        {"stdout", 0, (int *)0, 'c'},
        {"decompress", 0, (int *)0, 'd'},
        {"uncompress", 0, (int *)0, 'd'},
        {"force", 0, (int *)0, 'f'},
        {"help", 0, (int *)0, 'h'},
        {"list", 0, (int *)0, 'l'},
        {"license", 0, (int *)0, 'L'},
        {"no-name", 0, (int *)0, 'n'},
        {"name", 0, (int *)0, 'N'},
        {"quiet", 0, (int *)0, 'q'},
        {"silent", 0, (int *)0, 'q'},
        {"recursive", 0, (int *)0, 'r'},
        {"suffix", 1, (int *)0, 'S'},
        {"test", 0, (int *)0, 't'},
        {"no-time", 0, (int *)0, 'T'},
        {"verbose", 0, (int *)0, 'v'},
        {"version", 0, (int *)0, 'V'},
        {"fast", 0, (int *)0, '1'},
        {"best", 0, (int *)0, '9'},
        {"lzw", 0, (int *)0, 'Z'},
        {"bits", 1, (int *)0, 'b'},
        {"rsyncable", 0, (int *)0, 'R'},
        {(char const *)0, 0, (int *)0, 0}};
# 3063 "gzip.c"
static void usage(void) ;
# 3064 "gzip.c"
static void help(void) ;
# 3065 "gzip.c"
static void license(void) ;
# 3066 "gzip.c"
static void version(void) ;
# 3067 "gzip.c"
static int input_eof(void) ;
# 3068 "gzip.c"
static void treat_stdin(void) ;
# 3069 "gzip.c"
static void treat_file(char *iname ) ;
# 3070 "gzip.c"
static int create_outfile(void) ;
# 3071 "gzip.c"
static int do_stat(char *name , struct stat *sbuf ) ;
# 3072 "gzip.c"
static char *get_suffix(char *name ) ;
# 3073 "gzip.c"
static int get_istat(char *iname , struct stat *sbuf ) ;
# 3074 "gzip.c"
static int make_ofname(void) ;
# 3075 "gzip.c"
static int same_file(struct stat *stat1 , struct stat *stat2 ) ;
# 3076 "gzip.c"
static int name_too_long(char *name , struct stat *statb ) ;
# 3077 "gzip.c"
static void shorten_name(char *name ) ;
# 3078 "gzip.c"
static int get_method(int in ) ;
# 3079 "gzip.c"
static void do_list(int ifd___0 , int method___0 ) ;
# 3080 "gzip.c"
static int check_ofname(void) ;
# 3081 "gzip.c"
static void copy_stat(struct stat *ifstat ) ;
# 3082 "gzip.c"
static void do_exit(int exitcode ) ;
# 3083 "gzip.c"
int main(int argc , char **argv ) ;
# 3084 "gzip.c"
int (*work)(int infile , int outfile ) = & zip;
# 3087 "gzip.c"
static void treat_dir(char *dir ) ;
# 3090 "gzip.c"
static void reset_times(char *name , struct stat *statb ) ;
# 3096 "gzip.c"
static void usage(void)
{


  {
# 3098 "gzip.c"
  printf((char const * __restrict )"usage: %s [-%scdfhlLnN%stvV19] [-S suffix] [file ...]\n",
         progname, "", "r");
# 3096 "gzip.c"
  return;
}
}
# 3106 "gzip.c"
static void help(void) ;
# 3106 "gzip.c"
static char *help_msg[20] =
# 3106 "gzip.c"
  { (char *)" -c --stdout      write on standard output, keep original files unchanged", (char *)" -d --decompress  decompress", (char *)" -f --force       force overwrite of output file and compress links", (char *)" -h --help        give this help",
        (char *)" -l --list        list compressed file contents", (char *)" -L --license     display software license", (char *)" -n --no-name     do not save or restore the original name and time stamp", (char *)" -N --name        save or restore the original name and time stamp",
        (char *)" -q --quiet       suppress all warnings", (char *)" -r --recursive   operate recursively on directories", (char *)" -S .suf  --suffix .suf     use suffix .suf on compressed files", (char *)" -t --test        test compressed file integrity",
        (char *)" -v --verbose     verbose mode", (char *)" -V --version     display version number", (char *)" -1 --fast        compress faster", (char *)" -9 --best        compress better",
        (char *)"    --rsyncable   Make rsync-friendly archive", (char *)" file...          files to (de)compress. If none given, use standard input.", (char *)"Report bugs to <bug-gzip@gnu.org>.", (char *)0};
# 3104 "gzip.c"
static void help(void)
{
  char **p ;
  char **tmp ;

  {
# 3142 "gzip.c"
  p = help_msg;
# 3144 "gzip.c"
  printf((char const * __restrict )"%s %s\n(%s)\n", progname, "1.3.5", "2002-09-30");
# 3145 "gzip.c"
  usage();
  {
# 3146 "gzip.c"
  while (1) {
    while_continue: ;
# 3146 "gzip.c"
    if (*p != 0) {

    } else {
# 3146 "gzip.c"
      goto while_break;
    }
# 3146 "gzip.c"
    tmp = p;
# 3146 "gzip.c"
    p ++;
# 3146 "gzip.c"
    printf((char const * __restrict )"%s\n", *tmp);
  }
  while_break: ;
  }
# 3104 "gzip.c"
  return;
}
}
# 3150 "gzip.c"
static void license(void)
{
  char **p ;
  char **tmp ;

  {
# 3152 "gzip.c"
  p = license_msg;
# 3154 "gzip.c"
  printf((char const * __restrict )"%s %s\n(%s)\n", progname, "1.3.5", "2002-09-30");
  {
# 3155 "gzip.c"
  while (1) {
    while_continue: ;
# 3155 "gzip.c"
    if (*p != 0) {

    } else {
# 3155 "gzip.c"
      goto while_break;
    }
# 3155 "gzip.c"
    tmp = p;
# 3155 "gzip.c"
    p ++;
# 3155 "gzip.c"
    printf((char const * __restrict )"%s\n", *tmp);
  }
  while_break: ;
  }
# 3150 "gzip.c"
  return;
}
}
# 3159 "gzip.c"
static void version(void)
{


  {
# 3161 "gzip.c"
  license();
# 3162 "gzip.c"
  printf((char const * __restrict )"Compilation options:\n%s %s ", "DIRENT", "UTIME");
# 3164 "gzip.c"
  printf((char const * __restrict )"STDC_HEADERS ");
# 3167 "gzip.c"
  printf((char const * __restrict )"HAVE_UNISTD_H ");
# 3170 "gzip.c"
  printf((char const * __restrict )"HAVE_MEMORY_H ");
# 3173 "gzip.c"
  printf((char const * __restrict )"HAVE_STRING_H ");
# 3176 "gzip.c"
  printf((char const * __restrict )"HAVE_LSTAT ");
# 3199 "gzip.c"
  printf((char const * __restrict )"\n");
# 3200 "gzip.c"
  printf((char const * __restrict )"Written by Jean-loup Gailly.\n");
# 3159 "gzip.c"
  return;
}
}
# 3203 "gzip.c"
static void progerror(char *string )
{
  int e ;
  int *tmp ;
  int *tmp___0 ;

  {
# 3206 "gzip.c"
  tmp = __errno_location();
# 3206 "gzip.c"
  e = *tmp;
# 3207 "gzip.c"
  fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: ", progname);
# 3208 "gzip.c"
  tmp___0 = __errno_location();
# 3208 "gzip.c"
  *tmp___0 = e;
# 3209 "gzip.c"
  perror((char const *)string);
# 3210 "gzip.c"
  exit_code = 1;
# 3203 "gzip.c"
  return;
}
}
# 3214 "gzip.c"
int main(int argc , char **argv )
{
  int file_count ;
  int proglen ;
  int optc ;
  size_t tmp ;
  int tmp___0 ;
  __sighandler_t tmp___1 ;
  __sighandler_t tmp___2 ;
  __sighandler_t tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;
  __sighandler_t tmp___8 ;
  int tmp___9 ;
  int tmp___10 ;
  char **mem_18 ;
  char *mem_19 ;
  char **mem_20 ;

  {
# 3224 "gzip.c"
  mem_18 = argv + 0;
# 3224 "gzip.c"
  progname = base_name(*mem_18);
# 3225 "gzip.c"
  tmp = strlen((char const *)progname);
# 3225 "gzip.c"
  proglen = (int )tmp;
# 3228 "gzip.c"
  if (proglen > 4) {
# 3228 "gzip.c"
    tmp___0 = strcmp((char const *)((progname + proglen) - 4), ".exe");
# 3228 "gzip.c"
    if (tmp___0 == 0) {
# 3229 "gzip.c"
      mem_19 = progname + (proglen - 4);
# 3229 "gzip.c"
      *mem_19 = (char )'\000';
    } else {

    }
  } else {

  }
# 3233 "gzip.c"
  env = add_envopt(& argc, & argv, (char *)"GZIP");
# 3234 "gzip.c"
  if ((unsigned int )env != (unsigned int )((void *)0)) {
# 3234 "gzip.c"
    args = argv;
  } else {

  }
# 3236 "gzip.c"
  tmp___1 = signal(2, (void (*)(int ))1);
# 3236 "gzip.c"
  foreground = (unsigned int )tmp___1 != (unsigned int )((void (*)(int ))1);
# 3237 "gzip.c"
  if (foreground != 0) {
# 3238 "gzip.c"
    signal(2, (void (*)(int ))(& abort_gzip_signal));
  } else {

  }
# 3241 "gzip.c"
  tmp___2 = signal(15, (void (*)(int ))1);
# 3241 "gzip.c"
  if ((unsigned int )tmp___2 != (unsigned int )((void (*)(int ))1)) {
# 3242 "gzip.c"
    signal(15, (void (*)(int ))(& abort_gzip_signal));
  } else {

  }
# 3246 "gzip.c"
  tmp___3 = signal(1, (void (*)(int ))1);
# 3246 "gzip.c"
  if ((unsigned int )tmp___3 != (unsigned int )((void (*)(int ))1)) {
# 3247 "gzip.c"
    signal(1, (void (*)(int ))(& abort_gzip_signal));
  } else {

  }
# 3259 "gzip.c"
  tmp___6 = strncmp((char const *)progname, "un", (size_t )2);
# 3259 "gzip.c"
  if (tmp___6 == 0) {
# 3261 "gzip.c"
    decompress = 1;
  } else {
# 3259 "gzip.c"
    tmp___7 = strncmp((char const *)progname, "gun", (size_t )3);
# 3259 "gzip.c"
    if (tmp___7 == 0) {
# 3261 "gzip.c"
      decompress = 1;
    } else {
# 3262 "gzip.c"
      tmp___4 = strcmp((char const *)(progname + 1), "cat");
# 3262 "gzip.c"
      if (tmp___4 == 0) {
# 3264 "gzip.c"
        to_stdout = 1;
# 3264 "gzip.c"
        decompress = to_stdout;
      } else {
# 3262 "gzip.c"
        tmp___5 = strcmp((char const *)progname, "gzcat");
# 3262 "gzip.c"
        if (tmp___5 == 0) {
# 3264 "gzip.c"
          to_stdout = 1;
# 3264 "gzip.c"
          decompress = to_stdout;
        } else {

        }
      }
    }
  }
# 3268 "gzip.c"
  z_suffix = (char *)".gz";
# 3269 "gzip.c"
  z_len = strlen((char const *)z_suffix);
  {
# 3271 "gzip.c"
  while (1) {
    while_continue: ;
# 3271 "gzip.c"
    optc = getopt_long(argc, (char * const *)argv, "ab:cdfhH?lLmMnNqrS:tvVZ123456789",
                       (struct option const *)(longopts), (int *)0);
# 3271 "gzip.c"
    if (optc != -1) {

    } else {
# 3271 "gzip.c"
      goto while_break;
    }
    {
# 3274 "gzip.c"
    if (optc == 97) {
# 3274 "gzip.c"
      goto case_97;
    } else {

    }
# 3276 "gzip.c"
    if (optc == 98) {
# 3276 "gzip.c"
      goto case_98;
    } else {

    }
# 3287 "gzip.c"
    if (optc == 99) {
# 3287 "gzip.c"
      goto case_99;
    } else {

    }
# 3289 "gzip.c"
    if (optc == 100) {
# 3289 "gzip.c"
      goto case_100;
    } else {

    }
# 3291 "gzip.c"
    if (optc == 102) {
# 3291 "gzip.c"
      goto case_102;
    } else {

    }
# 3293 "gzip.c"
    if (optc == 63) {
# 3293 "gzip.c"
      goto case_63;
    } else {

    }
# 3293 "gzip.c"
    if (optc == 72) {
# 3293 "gzip.c"
      goto case_63;
    } else {

    }
# 3293 "gzip.c"
    if (optc == 104) {
# 3293 "gzip.c"
      goto case_63;
    } else {

    }
# 3295 "gzip.c"
    if (optc == 108) {
# 3295 "gzip.c"
      goto case_108;
    } else {

    }
# 3297 "gzip.c"
    if (optc == 76) {
# 3297 "gzip.c"
      goto case_76;
    } else {

    }
# 3299 "gzip.c"
    if (optc == 109) {
# 3299 "gzip.c"
      goto case_109;
    } else {

    }
# 3301 "gzip.c"
    if (optc == 77) {
# 3301 "gzip.c"
      goto case_77;
    } else {

    }
# 3303 "gzip.c"
    if (optc == 110) {
# 3303 "gzip.c"
      goto case_110;
    } else {

    }
# 3305 "gzip.c"
    if (optc == 78) {
# 3305 "gzip.c"
      goto case_78;
    } else {

    }
# 3307 "gzip.c"
    if (optc == 113) {
# 3307 "gzip.c"
      goto case_113;
    } else {

    }
# 3309 "gzip.c"
    if (optc == 114) {
# 3309 "gzip.c"
      goto case_114;
    } else {

    }
# 3317 "gzip.c"
    if (optc == 82) {
# 3317 "gzip.c"
      goto case_82;
    } else {

    }
# 3320 "gzip.c"
    if (optc == 83) {
# 3320 "gzip.c"
      goto case_83;
    } else {

    }
# 3327 "gzip.c"
    if (optc == 116) {
# 3327 "gzip.c"
      goto case_116;
    } else {

    }
# 3330 "gzip.c"
    if (optc == 118) {
# 3330 "gzip.c"
      goto case_118;
    } else {

    }
# 3332 "gzip.c"
    if (optc == 86) {
# 3332 "gzip.c"
      goto case_86;
    } else {

    }
# 3334 "gzip.c"
    if (optc == 90) {
# 3334 "gzip.c"
      goto case_90;
    } else {

    }
# 3344 "gzip.c"
    if (optc == 57) {
# 3344 "gzip.c"
      goto case_57;
    } else {

    }
# 3344 "gzip.c"
    if (optc == 56) {
# 3344 "gzip.c"
      goto case_57;
    } else {

    }
# 3344 "gzip.c"
    if (optc == 55) {
# 3344 "gzip.c"
      goto case_57;
    } else {

    }
# 3344 "gzip.c"
    if (optc == 54) {
# 3344 "gzip.c"
      goto case_57;
    } else {

    }
# 3344 "gzip.c"
    if (optc == 53) {
# 3344 "gzip.c"
      goto case_57;
    } else {

    }
# 3343 "gzip.c"
    if (optc == 52) {
# 3343 "gzip.c"
      goto case_57;
    } else {

    }
# 3343 "gzip.c"
    if (optc == 51) {
# 3343 "gzip.c"
      goto case_57;
    } else {

    }
# 3343 "gzip.c"
    if (optc == 50) {
# 3343 "gzip.c"
      goto case_57;
    } else {

    }
# 3343 "gzip.c"
    if (optc == 49) {
# 3343 "gzip.c"
      goto case_57;
    } else {

    }
# 3347 "gzip.c"
    goto switch_default;
    case_97:
# 3275 "gzip.c"
    ascii = 1;
# 3275 "gzip.c"
    goto switch_break;
    case_98:
# 3277 "gzip.c"
    maxbits = atoi((char const *)optarg);
    {
# 3278 "gzip.c"
    while (1) {
      while_continue___0: ;
# 3278 "gzip.c"
      if (*optarg != 0) {

      } else {
# 3278 "gzip.c"
        goto while_break___0;
      }
# 3279 "gzip.c"
      if (48 <= (int )*optarg) {
# 3279 "gzip.c"
        if ((int )*optarg <= 57) {

        } else {
# 3281 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: -b operand is not an integer\n",
                  progname);
# 3283 "gzip.c"
          usage();
# 3284 "gzip.c"
          do_exit(1);
        }
      } else {
# 3281 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: -b operand is not an integer\n",
                progname);
# 3283 "gzip.c"
        usage();
# 3284 "gzip.c"
        do_exit(1);
      }
# 3278 "gzip.c"
      optarg ++;
    }
    while_break___0: ;
    }
# 3286 "gzip.c"
    goto switch_break;
    case_99:
# 3288 "gzip.c"
    to_stdout = 1;
# 3288 "gzip.c"
    goto switch_break;
    case_100:
# 3290 "gzip.c"
    decompress = 1;
# 3290 "gzip.c"
    goto switch_break;
    case_102:
# 3292 "gzip.c"
    force ++;
# 3292 "gzip.c"
    goto switch_break;
    case_63:
    case_72:
    case_104:
# 3294 "gzip.c"
    help();
# 3294 "gzip.c"
    do_exit(0);
# 3294 "gzip.c"
    goto switch_break;
    case_108:
# 3296 "gzip.c"
    to_stdout = 1;
# 3296 "gzip.c"
    decompress = to_stdout;
# 3296 "gzip.c"
    list = decompress;
# 3296 "gzip.c"
    goto switch_break;
    case_76:
# 3298 "gzip.c"
    license();
# 3298 "gzip.c"
    do_exit(0);
# 3298 "gzip.c"
    goto switch_break;
    case_109:
# 3300 "gzip.c"
    no_time = 1;
# 3300 "gzip.c"
    goto switch_break;
    case_77:
# 3302 "gzip.c"
    no_time = 0;
# 3302 "gzip.c"
    goto switch_break;
    case_110:
# 3304 "gzip.c"
    no_time = 1;
# 3304 "gzip.c"
    no_name = no_time;
# 3304 "gzip.c"
    goto switch_break;
    case_78:
# 3306 "gzip.c"
    no_time = 0;
# 3306 "gzip.c"
    no_name = no_time;
# 3306 "gzip.c"
    goto switch_break;
    case_113:
# 3308 "gzip.c"
    quiet = 1;
# 3308 "gzip.c"
    verbose = 0;
# 3308 "gzip.c"
    goto switch_break;
    case_114:
# 3315 "gzip.c"
    recursive = 1;
# 3315 "gzip.c"
    goto switch_break;
    case_82:
# 3318 "gzip.c"
    rsync = 1;
# 3318 "gzip.c"
    goto switch_break;
    case_83:
# 3324 "gzip.c"
    z_len = strlen((char const *)optarg);
# 3325 "gzip.c"
    z_suffix = optarg;
# 3326 "gzip.c"
    goto switch_break;
    case_116:
# 3328 "gzip.c"
    to_stdout = 1;
# 3328 "gzip.c"
    decompress = to_stdout;
# 3328 "gzip.c"
    test = decompress;
# 3329 "gzip.c"
    goto switch_break;
    case_118:
# 3331 "gzip.c"
    verbose ++;
# 3331 "gzip.c"
    quiet = 0;
# 3331 "gzip.c"
    goto switch_break;
    case_86:
# 3333 "gzip.c"
    version();
# 3333 "gzip.c"
    do_exit(0);
# 3333 "gzip.c"
    goto switch_break;
    case_90:
# 3338 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: -Z not supported in this version\n",
            progname);
# 3340 "gzip.c"
    usage();
# 3341 "gzip.c"
    do_exit(1);
# 3341 "gzip.c"
    goto switch_break;
    case_57:
    case_56:
    case_55:
    case_54:
    case_53:
    case_52:
    case_51:
    case_50:
    case_49:
# 3345 "gzip.c"
    level = optc - 48;
# 3346 "gzip.c"
    goto switch_break;
    switch_default:
# 3349 "gzip.c"
    usage();
# 3350 "gzip.c"
    do_exit(1);
    switch_break: ;
    }
  }
  while_break: ;
  }
# 3356 "gzip.c"
  if (quiet != 0) {
# 3356 "gzip.c"
    tmp___8 = signal(13, (void (*)(int ))1);
# 3356 "gzip.c"
    if ((unsigned int )tmp___8 != (unsigned int )((void (*)(int ))1)) {
# 3357 "gzip.c"
      signal(13, (void (*)(int ))(& abort_gzip_signal));
    } else {

    }
  } else {

  }
# 3363 "gzip.c"
  if (no_time < 0) {
# 3363 "gzip.c"
    no_time = decompress;
  } else {

  }
# 3364 "gzip.c"
  if (no_name < 0) {
# 3364 "gzip.c"
    no_name = decompress;
  } else {

  }
# 3366 "gzip.c"
  file_count = argc - optind;
# 3370 "gzip.c"
  if (ascii != 0) {
# 3370 "gzip.c"
    if (quiet == 0) {
# 3371 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: option --ascii ignored on this system\n",
              progname);
    } else {

    }
  } else {

  }
# 3375 "gzip.c"
  if (z_len == 0U) {
# 3375 "gzip.c"
    if (decompress == 0) {
# 3376 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: incorrect suffix \'%s\'\n",
              progname, z_suffix);
# 3378 "gzip.c"
      do_exit(1);
    } else {
# 3375 "gzip.c"
      goto _L;
    }
  } else
  _L:
# 3375 "gzip.c"
  if (z_len > 30U) {
# 3376 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: incorrect suffix \'%s\'\n",
            progname, z_suffix);
# 3378 "gzip.c"
    do_exit(1);
  } else {

  }
# 3380 "gzip.c"
  if (do_lzw != 0) {
# 3380 "gzip.c"
    if (decompress == 0) {
# 3380 "gzip.c"
      work = & lzw;
    } else {

    }
  } else {

  }
# 3395 "gzip.c"
  if (file_count != 0) {
# 3396 "gzip.c"
    if (to_stdout != 0) {
# 3396 "gzip.c"
      if (test == 0) {
# 3396 "gzip.c"
        if (list == 0) {
# 3396 "gzip.c"
          if (decompress == 0) {
# 3396 "gzip.c"
            tmp___9 = 1;
          } else
# 3396 "gzip.c"
          if (ascii == 0) {
# 3396 "gzip.c"
            tmp___9 = 1;
          } else {
# 3396 "gzip.c"
            tmp___9 = 0;
          }
        } else {
# 3396 "gzip.c"
          tmp___9 = 0;
        }
      } else {
# 3396 "gzip.c"
        tmp___9 = 0;
      }
    } else {
# 3396 "gzip.c"
      tmp___9 = 0;
    }
    {
# 3399 "gzip.c"
    while (1) {
      while_continue___1: ;
# 3399 "gzip.c"
      if (optind < argc) {

      } else {
# 3399 "gzip.c"
        goto while_break___1;
      }
# 3400 "gzip.c"
      tmp___10 = optind;
# 3400 "gzip.c"
      optind ++;
# 3400 "gzip.c"
      mem_20 = argv + tmp___10;
# 3400 "gzip.c"
      treat_file(*mem_20);
    }
    while_break___1: ;
    }
  } else {
# 3403 "gzip.c"
    treat_stdin();
  }
# 3405 "gzip.c"
  if (list != 0) {
# 3405 "gzip.c"
    if (quiet == 0) {
# 3405 "gzip.c"
      if (file_count > 1) {
# 3406 "gzip.c"
        do_list(-1, -1);
      } else {

      }
    } else {

    }
  } else {

  }
# 3408 "gzip.c"
  do_exit(exit_code);
# 3409 "gzip.c"
  return (exit_code);
}
}
# 3413 "gzip.c"
static int input_eof(void)
{
  int tmp ;
  int __retres2 ;

  {
# 3416 "gzip.c"
  if (decompress == 0) {
# 3417 "gzip.c"
    __retres2 = 1;
# 3417 "gzip.c"
    goto return_label;
  } else
# 3416 "gzip.c"
  if (last_member != 0) {
# 3417 "gzip.c"
    __retres2 = 1;
# 3417 "gzip.c"
    goto return_label;
  } else {

  }
# 3419 "gzip.c"
  if (inptr == insize) {
# 3421 "gzip.c"
    if (insize != 32768U) {
# 3422 "gzip.c"
      __retres2 = 1;
# 3422 "gzip.c"
      goto return_label;
    } else {
# 3421 "gzip.c"
      tmp = fill_inbuf(1);
# 3421 "gzip.c"
      if (tmp == -1) {
# 3422 "gzip.c"
        __retres2 = 1;
# 3422 "gzip.c"
        goto return_label;
      } else {

      }
    }
# 3425 "gzip.c"
    inptr = 0U;
  } else {

  }
# 3428 "gzip.c"
  __retres2 = 0;
  return_label:
# 3413 "gzip.c"
  return (__retres2);
}
}
# 3434 "gzip.c"
static void treat_stdin(void)
{
  char const *tmp ;
  char const *tmp___0 ;
  struct _IO_FILE *tmp___1 ;
  int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;
  int tmp___8 ;
  int tmp___9 ;
  int tmp___10 ;
  int tmp___11 ;

  {
# 3436 "gzip.c"
  if (force == 0) {
# 3436 "gzip.c"
    if (list == 0) {
# 3436 "gzip.c"
      if (decompress != 0) {
# 3436 "gzip.c"
        tmp___1 = stdin;
      } else {
# 3436 "gzip.c"
        tmp___1 = stdout;
      }
# 3436 "gzip.c"
      tmp___2 = fileno(tmp___1);
# 3436 "gzip.c"
      tmp___3 = isatty(tmp___2);
# 3436 "gzip.c"
      if (tmp___3 != 0) {
# 3450 "gzip.c"
        if (decompress != 0) {
# 3450 "gzip.c"
          tmp = "de";
        } else {
# 3450 "gzip.c"
          tmp = "";
        }
# 3450 "gzip.c"
        if (decompress != 0) {
# 3450 "gzip.c"
          tmp___0 = "read from";
        } else {
# 3450 "gzip.c"
          tmp___0 = "written to";
        }
# 3450 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: compressed data not %s a terminal. Use -f to force %scompression.\n",
                progname, tmp___0, tmp);
# 3454 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"For help, type: %s -h\n",
                progname);
# 3455 "gzip.c"
        do_exit(1);
      } else {

      }
    } else {

    }
  } else {

  }
# 3458 "gzip.c"
  if (decompress != 0) {
# 3458 "gzip.c"
    tmp___4 = 1;
  } else
# 3458 "gzip.c"
  if (ascii == 0) {
# 3458 "gzip.c"
    tmp___4 = 1;
  } else {
# 3458 "gzip.c"
    tmp___4 = 0;
  }
# 3461 "gzip.c"
  if (test == 0) {
# 3461 "gzip.c"
    if (list == 0) {
# 3461 "gzip.c"
      if (decompress == 0) {
# 3461 "gzip.c"
        tmp___5 = 1;
      } else
# 3461 "gzip.c"
      if (ascii == 0) {
# 3461 "gzip.c"
        tmp___5 = 1;
      } else {
# 3461 "gzip.c"
        tmp___5 = 0;
      }
    } else {
# 3461 "gzip.c"
      tmp___5 = 0;
    }
  } else {
# 3461 "gzip.c"
    tmp___5 = 0;
  }
# 3464 "gzip.c"
  strcpy((char * __restrict )(ifname), (char const * __restrict )"stdin");
# 3465 "gzip.c"
  strcpy((char * __restrict )(ofname), (char const * __restrict )"stdout");
# 3468 "gzip.c"
  time_stamp = (time_t )0;
# 3471 "gzip.c"
  if (list != 0) {
# 3471 "gzip.c"
    goto _L;
  } else
# 3471 "gzip.c"
  if (no_time == 0) {
    _L:
# 3472 "gzip.c"
    tmp___6 = fileno(stdin);
# 3472 "gzip.c"
    tmp___7 = fstat(tmp___6, & istat);
# 3472 "gzip.c"
    if (tmp___7 != 0) {
# 3473 "gzip.c"
      progerror((char *)"standard input");
# 3474 "gzip.c"
      do_exit(1);
    } else {

    }
# 3479 "gzip.c"
    time_stamp = istat.st_mtim.tv_sec;
  } else {

  }
# 3482 "gzip.c"
  ifile_size = -1L;
# 3484 "gzip.c"
  clear_bufs();
# 3485 "gzip.c"
  to_stdout = 1;
# 3486 "gzip.c"
  part_nb = 0;
# 3488 "gzip.c"
  if (decompress != 0) {
# 3489 "gzip.c"
    method = get_method(ifd);
# 3490 "gzip.c"
    if (method < 0) {
# 3491 "gzip.c"
      do_exit(exit_code);
    } else {

    }
  } else {

  }
# 3494 "gzip.c"
  if (list != 0) {
# 3495 "gzip.c"
    do_list(ifd, method);
# 3496 "gzip.c"
    goto return_label;
  } else {

  }
  {
# 3501 "gzip.c"
  while (1) {
    while_continue: ;
# 3502 "gzip.c"
    tmp___8 = fileno(stdout);
# 3502 "gzip.c"
    tmp___9 = fileno(stdin);
# 3502 "gzip.c"
    tmp___10 = (*work)(tmp___9, tmp___8);
# 3502 "gzip.c"
    if (tmp___10 != 0) {
# 3502 "gzip.c"
      goto return_label;
    } else {

    }
# 3504 "gzip.c"
    tmp___11 = input_eof();
# 3504 "gzip.c"
    if (tmp___11 != 0) {
# 3505 "gzip.c"
      goto while_break;
    } else {

    }
# 3507 "gzip.c"
    method = get_method(ifd);
# 3508 "gzip.c"
    if (method < 0) {
# 3508 "gzip.c"
      goto return_label;
    } else {

    }
# 3509 "gzip.c"
    bytes_out = (off_t )0;
  }
  while_break: ;
  }
# 3512 "gzip.c"
  if (verbose != 0) {
# 3513 "gzip.c"
    if (test != 0) {
# 3514 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )" OK\n");
    } else
# 3516 "gzip.c"
    if (decompress == 0) {
# 3517 "gzip.c"
      display_ratio(bytes_in - (bytes_out - header_bytes), bytes_in, stderr);
# 3518 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n");
    } else {

    }
  } else {

  }

  return_label:
# 3434 "gzip.c"
  return;
}
}
# 3531 "gzip.c"
static void treat_file(char *iname )
{
  int cflag ;
  int tmp ;
  int tmp___0 ;
  struct stat st ;
  int tmp___1 ;
  int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;

  {
# 3535 "gzip.c"
  tmp = strcmp((char const *)iname, "-");
# 3535 "gzip.c"
  if (tmp == 0) {
# 3536 "gzip.c"
    cflag = to_stdout;
# 3537 "gzip.c"
    treat_stdin();
# 3538 "gzip.c"
    to_stdout = cflag;
# 3539 "gzip.c"
    goto return_label;
  } else {

  }
# 3543 "gzip.c"
  tmp___0 = get_istat(iname, & istat);
# 3543 "gzip.c"
  if (tmp___0 != 0) {
# 3543 "gzip.c"
    goto return_label;
  } else {

  }
# 3546 "gzip.c"
  if ((istat.st_mode & 61440U) == 16384U) {
# 3548 "gzip.c"
    if (recursive != 0) {
# 3550 "gzip.c"
      st = istat;
# 3551 "gzip.c"
      treat_dir(iname);
# 3554 "gzip.c"
      reset_times(iname, & st);
    } else {
# 3558 "gzip.c"
      if (quiet == 0) {
# 3558 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s is a directory -- ignored\n",
                progname, ifname);
      } else {

      }
# 3558 "gzip.c"
      if (exit_code == 0) {
# 3558 "gzip.c"
        exit_code = 2;
      } else {

      }
    }
# 3559 "gzip.c"
    goto return_label;
  } else {

  }
# 3561 "gzip.c"
  if ((istat.st_mode & 61440U) != 32768U) {
# 3562 "gzip.c"
    if (quiet == 0) {
# 3562 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s is not a directory or a regular file - ignored\n",
              progname, ifname);
    } else {

    }
# 3562 "gzip.c"
    if (exit_code == 0) {
# 3562 "gzip.c"
      exit_code = 2;
    } else {

    }
# 3565 "gzip.c"
    goto return_label;
  } else {

  }
# 3567 "gzip.c"
  if (istat.st_nlink > 1U) {
# 3567 "gzip.c"
    if (to_stdout == 0) {
# 3567 "gzip.c"
      if (force == 0) {
# 3568 "gzip.c"
        if (quiet == 0) {
# 3568 "gzip.c"
          if (istat.st_nlink > 2U) {
# 3568 "gzip.c"
            tmp___1 = 's';
          } else {
# 3568 "gzip.c"
            tmp___1 = ' ';
          }
# 3568 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s has %lu other link%c -- unchanged\n",
                  progname, ifname, (unsigned long )istat.st_nlink - 1UL, tmp___1);
        } else {

        }
# 3568 "gzip.c"
        if (exit_code == 0) {
# 3568 "gzip.c"
          exit_code = 2;
        } else {

        }
# 3571 "gzip.c"
        goto return_label;
      } else {

      }
    } else {

    }
  } else {

  }
# 3574 "gzip.c"
  ifile_size = istat.st_size;
# 3575 "gzip.c"
  if (no_time != 0) {
# 3575 "gzip.c"
    if (list == 0) {
# 3575 "gzip.c"
      time_stamp = (time_t )0;
    } else {
# 3575 "gzip.c"
      time_stamp = istat.st_mtim.tv_sec;
    }
  } else {
# 3575 "gzip.c"
    time_stamp = istat.st_mtim.tv_sec;
  }
# 3580 "gzip.c"
  if (to_stdout != 0) {
# 3580 "gzip.c"
    if (list == 0) {
# 3580 "gzip.c"
      if (test == 0) {
# 3581 "gzip.c"
        strcpy((char * __restrict )(ofname), (char const * __restrict )"stdout");
      } else {
# 3580 "gzip.c"
        goto _L___0;
      }
    } else {
# 3580 "gzip.c"
      goto _L___0;
    }
  } else {
    _L___0:
# 3583 "gzip.c"
    tmp___2 = make_ofname();
# 3583 "gzip.c"
    if (tmp___2 != 0) {
# 3584 "gzip.c"
      goto return_label;
    } else {

    }
  }
# 3591 "gzip.c"
  if (ascii != 0) {
# 3591 "gzip.c"
    if (decompress == 0) {
# 3591 "gzip.c"
      tmp___3 = 0;
    } else {
# 3591 "gzip.c"
      tmp___3 = 0;
    }
  } else {
# 3591 "gzip.c"
    tmp___3 = 0;
  }
# 3591 "gzip.c"
  ifd = open((char const *)(ifname), tmp___3, 384);
# 3593 "gzip.c"
  if (ifd == -1) {
# 3594 "gzip.c"
    progerror(ifname);
# 3595 "gzip.c"
    goto return_label;
  } else {

  }
# 3597 "gzip.c"
  clear_bufs();
# 3598 "gzip.c"
  part_nb = 0;
# 3600 "gzip.c"
  if (decompress != 0) {
# 3601 "gzip.c"
    method = get_method(ifd);
# 3602 "gzip.c"
    if (method < 0) {
# 3603 "gzip.c"
      close(ifd);
# 3604 "gzip.c"
      goto return_label;
    } else {

    }
  } else {

  }
# 3607 "gzip.c"
  if (list != 0) {
# 3608 "gzip.c"
    do_list(ifd, method);
# 3609 "gzip.c"
    close(ifd);
# 3610 "gzip.c"
    goto return_label;
  } else {

  }
# 3617 "gzip.c"
  if (to_stdout != 0) {
# 3618 "gzip.c"
    ofd = fileno(stdout);
  } else {
# 3621 "gzip.c"
    tmp___4 = create_outfile();
# 3621 "gzip.c"
    if (tmp___4 != 0) {
# 3621 "gzip.c"
      goto return_label;
    } else {

    }
# 3623 "gzip.c"
    if (decompress == 0) {
# 3623 "gzip.c"
      if (save_orig_name != 0) {
# 3623 "gzip.c"
        if (verbose == 0) {
# 3623 "gzip.c"
          if (quiet == 0) {
# 3624 "gzip.c"
            fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s compressed to %s\n",
                    progname, ifname, ofname);
          } else {

          }
        } else {

        }
      } else {

      }
    } else {

    }
  }
# 3629 "gzip.c"
  if (save_orig_name == 0) {
# 3629 "gzip.c"
    save_orig_name = ! no_name;
  } else {

  }
# 3631 "gzip.c"
  if (verbose != 0) {
# 3632 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s:\t", ifname);
  } else {

  }
  {
# 3637 "gzip.c"
  while (1) {
    while_continue: ;
# 3638 "gzip.c"
    tmp___5 = (*work)(ifd, ofd);
# 3638 "gzip.c"
    if (tmp___5 != 0) {
# 3639 "gzip.c"
      method = -1;
# 3640 "gzip.c"
      goto while_break;
    } else {

    }
# 3643 "gzip.c"
    tmp___6 = input_eof();
# 3643 "gzip.c"
    if (tmp___6 != 0) {
# 3644 "gzip.c"
      goto while_break;
    } else {

    }
# 3646 "gzip.c"
    method = get_method(ifd);
# 3647 "gzip.c"
    if (method < 0) {
# 3647 "gzip.c"
      goto while_break;
    } else {

    }
# 3648 "gzip.c"
    bytes_out = (off_t )0;
  }
  while_break: ;
  }
# 3651 "gzip.c"
  close(ifd);
# 3652 "gzip.c"
  if (to_stdout == 0) {
# 3654 "gzip.c"
    copy_stat(& istat);
# 3655 "gzip.c"
    tmp___7 = close(ofd);
# 3655 "gzip.c"
    if (tmp___7 != 0) {
# 3656 "gzip.c"
      write_error();
    } else {

    }
  } else {

  }
# 3658 "gzip.c"
  if (method == -1) {
# 3659 "gzip.c"
    if (to_stdout == 0) {
# 3659 "gzip.c"
      xunlink(ofname);
    } else {

    }
# 3660 "gzip.c"
    goto return_label;
  } else {

  }
# 3663 "gzip.c"
  if (verbose != 0) {
# 3664 "gzip.c"
    if (test != 0) {
# 3665 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )" OK");
    } else
# 3666 "gzip.c"
    if (decompress != 0) {
# 3667 "gzip.c"
      display_ratio(bytes_out - (bytes_in - header_bytes), bytes_out, stderr);
    } else {
# 3669 "gzip.c"
      display_ratio(bytes_in - (bytes_out - header_bytes), bytes_in, stderr);
    }
# 3671 "gzip.c"
    if (test == 0) {
# 3671 "gzip.c"
      if (to_stdout == 0) {
# 3672 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )" -- replaced with %s",
                ofname);
      } else {

      }
    } else {

    }
# 3674 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n");
  } else {

  }

  return_label:
# 3531 "gzip.c"
  return;
}
}
# 3687 "gzip.c"
static int create_outfile(void)
{
  struct stat ostat ;
  int flags ;
  int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  int __retres6 ;

  {
# 3690 "gzip.c"
  flags = 193;
# 3692 "gzip.c"
  if (ascii != 0) {
# 3692 "gzip.c"
    if (decompress != 0) {
# 3693 "gzip.c"
      flags &= -1;
    } else {

    }
  } else {

  }
  {
# 3695 "gzip.c"
  while (1) {
    while_continue: ;
# 3697 "gzip.c"
    tmp = check_ofname();
# 3697 "gzip.c"
    if (tmp != 0) {
# 3698 "gzip.c"
      close(ifd);
# 3699 "gzip.c"
      __retres6 = 1;
# 3699 "gzip.c"
      goto return_label;
    } else {

    }
# 3702 "gzip.c"
    remove_ofname = 1;
# 3703 "gzip.c"
    ofd = open((char const *)(ofname), flags, 384);
# 3704 "gzip.c"
    if (ofd == -1) {
# 3705 "gzip.c"
      progerror(ofname);
# 3706 "gzip.c"
      close(ifd);
# 3707 "gzip.c"
      __retres6 = 1;
# 3707 "gzip.c"
      goto return_label;
    } else {

    }
# 3714 "gzip.c"
    tmp___0 = fstat(ofd, & ostat);
# 3714 "gzip.c"
    if (tmp___0 != 0) {
# 3716 "gzip.c"
      progerror(ofname);
# 3717 "gzip.c"
      close(ifd);
# 3717 "gzip.c"
      close(ofd);
# 3718 "gzip.c"
      xunlink(ofname);
# 3719 "gzip.c"
      __retres6 = 1;
# 3719 "gzip.c"
      goto return_label;
    } else {

    }
# 3721 "gzip.c"
    tmp___1 = name_too_long(ofname, & ostat);
# 3721 "gzip.c"
    if (tmp___1 != 0) {

    } else {
# 3721 "gzip.c"
      __retres6 = 0;
# 3721 "gzip.c"
      goto return_label;
    }
# 3723 "gzip.c"
    if (decompress != 0) {
# 3725 "gzip.c"
      if (quiet == 0) {
# 3725 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: warning, name truncated\n",
                progname, ofname);
      } else {

      }
# 3725 "gzip.c"
      if (exit_code == 0) {
# 3725 "gzip.c"
        exit_code = 2;
      } else {

      }
# 3727 "gzip.c"
      __retres6 = 0;
# 3727 "gzip.c"
      goto return_label;
    } else {

    }
# 3729 "gzip.c"
    close(ofd);
# 3730 "gzip.c"
    xunlink(ofname);
# 3736 "gzip.c"
    shorten_name(ofname);
  }
  while_break: ;
  }
  return_label:
# 3687 "gzip.c"
  return (__retres6);
}
}
# 3744 "gzip.c"
static int do_stat(char *name , struct stat *sbuf )
{
  int *tmp ;
  int tmp___0 ;
  int tmp___1 ;
  int __retres6 ;

  {
# 3748 "gzip.c"
  tmp = __errno_location();
# 3748 "gzip.c"
  *tmp = 0;
# 3749 "gzip.c"
  if (to_stdout == 0) {
# 3749 "gzip.c"
    if (force == 0) {
# 3750 "gzip.c"
      tmp___0 = lstat((char const * __restrict )name, (struct stat * __restrict )sbuf);
# 3750 "gzip.c"
      __retres6 = tmp___0;
# 3750 "gzip.c"
      goto return_label;
    } else {

    }
  } else {

  }
# 3752 "gzip.c"
  tmp___1 = stat((char const * __restrict )name, (struct stat * __restrict )sbuf);
# 3752 "gzip.c"
  __retres6 = tmp___1;
  return_label:
# 3744 "gzip.c"
  return (__retres6);
}
}
# 3772 "gzip.c"
static char *get_suffix(char *name ) ;
# 3772 "gzip.c"
static char *known_suffixes[9] =
# 3772 "gzip.c"
  { (char *)((void *)0), (char *)".gz", (char *)".z", (char *)".taz",
        (char *)".tgz", (char *)"-gz", (char *)"-z", (char *)"_z",
        (char *)((void *)0)};
# 3767 "gzip.c"
static char *get_suffix(char *name )
{
  int nlen ;
  int slen ;
  char suffix[33] ;
  char **suf ;
  int tmp ;
  size_t tmp___0 ;
  size_t tmp___1 ;
  int s ;
  size_t tmp___2 ;
  int tmp___3 ;
  char *__retres12 ;

  {
# 3778 "gzip.c"
  suf = known_suffixes;
# 3780 "gzip.c"
  *suf = z_suffix;
# 3781 "gzip.c"
  tmp = strcmp((char const *)z_suffix, "z");
# 3781 "gzip.c"
  if (tmp == 0) {
# 3781 "gzip.c"
    suf ++;
  } else {

  }
# 3790 "gzip.c"
  tmp___0 = strlen((char const *)name);
# 3790 "gzip.c"
  nlen = (int )tmp___0;
# 3791 "gzip.c"
  if (nlen <= 32) {
# 3792 "gzip.c"
    strcpy((char * __restrict )(suffix), (char const * __restrict )name);
  } else {
# 3794 "gzip.c"
    strcpy((char * __restrict )(suffix), (char const * __restrict )(((name + nlen) - 30) - 2));
  }
# 3796 "gzip.c"
  strlwr(suffix);
# 3797 "gzip.c"
  tmp___1 = strlen((char const *)(suffix));
# 3797 "gzip.c"
  slen = (int )tmp___1;
  {
# 3798 "gzip.c"
  while (1) {
    while_continue: ;
# 3799 "gzip.c"
    tmp___2 = strlen((char const *)*suf);
# 3799 "gzip.c"
    s = (int )tmp___2;
# 3800 "gzip.c"
    if (slen > s) {
# 3800 "gzip.c"
      if ((int )suffix[(slen - s) - 1] != 47) {
# 3800 "gzip.c"
        tmp___3 = strcmp((char const *)((suffix + slen) - s), (char const *)*suf);
# 3800 "gzip.c"
        if (tmp___3 == 0) {
# 3802 "gzip.c"
          __retres12 = (name + nlen) - s;
# 3802 "gzip.c"
          goto return_label;
        } else {

        }
      } else {

      }
    } else {

    }
# 3798 "gzip.c"
    suf ++;
# 3798 "gzip.c"
    if ((unsigned int )*suf != (unsigned int )((void *)0)) {

    } else {
# 3798 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 3806 "gzip.c"
  __retres12 = (char *)((void *)0);
  return_label:
# 3767 "gzip.c"
  return (__retres12);
}
}
# 3823 "gzip.c"
static int get_istat(char *iname , struct stat *sbuf ) ;
# 3823 "gzip.c"
static char *suffixes[6] = { (char *)((void *)0), (char *)".gz", (char *)".z", (char *)"-z",
        (char *)".Z", (char *)((void *)0)};
# 3817 "gzip.c"
static int get_istat(char *iname , struct stat *sbuf )
{
  int ilen ;
  int z_suffix_errno ;
  char **suf ;
  char *s ;
  size_t tmp ;
  int tmp___0 ;
  int *tmp___1 ;
  size_t tmp___2 ;
  int tmp___3 ;
  char *s0 ;
  size_t tmp___4 ;
  int tmp___5 ;
  int *tmp___6 ;
  int tmp___7 ;
  int *tmp___8 ;
  int __retres18 ;

  {
# 3822 "gzip.c"
  z_suffix_errno = 0;
# 3824 "gzip.c"
  suf = suffixes;
# 3830 "gzip.c"
  *suf = z_suffix;
# 3832 "gzip.c"
  tmp = strlen((char const *)iname);
# 3832 "gzip.c"
  if (sizeof(ifname) - 1U <= tmp) {
# 3833 "gzip.c"
    goto name_too_long;
  } else {

  }
# 3835 "gzip.c"
  strcpy((char * __restrict )(ifname), (char const * __restrict )iname);
# 3838 "gzip.c"
  tmp___0 = do_stat(ifname, sbuf);
# 3838 "gzip.c"
  if (tmp___0 == 0) {
# 3838 "gzip.c"
    __retres18 = 0;
# 3838 "gzip.c"
    goto return_label;
  } else {

  }
# 3840 "gzip.c"
  if (decompress == 0) {
# 3841 "gzip.c"
    progerror(ifname);
# 3842 "gzip.c"
    __retres18 = 1;
# 3842 "gzip.c"
    goto return_label;
  } else {
# 3840 "gzip.c"
    tmp___1 = __errno_location();
# 3840 "gzip.c"
    if (*tmp___1 != 2) {
# 3841 "gzip.c"
      progerror(ifname);
# 3842 "gzip.c"
      __retres18 = 1;
# 3842 "gzip.c"
      goto return_label;
    } else {

    }
  }
# 3847 "gzip.c"
  s = get_suffix(ifname);
# 3848 "gzip.c"
  if ((unsigned int )s != (unsigned int )((void *)0)) {
# 3849 "gzip.c"
    progerror(ifname);
# 3850 "gzip.c"
    __retres18 = 1;
# 3850 "gzip.c"
    goto return_label;
  } else {

  }
# 3859 "gzip.c"
  tmp___2 = strlen((char const *)(ifname));
# 3859 "gzip.c"
  ilen = (int )tmp___2;
# 3860 "gzip.c"
  tmp___3 = strcmp((char const *)z_suffix, ".gz");
# 3860 "gzip.c"
  if (tmp___3 == 0) {
# 3860 "gzip.c"
    suf ++;
  } else {

  }
  {
# 3863 "gzip.c"
  while (1) {
    while_continue: ;
# 3864 "gzip.c"
    s = *suf;
# 3864 "gzip.c"
    s0 = s;
# 3865 "gzip.c"
    strcpy((char * __restrict )(ifname), (char const * __restrict )iname);
# 3874 "gzip.c"
    tmp___4 = strlen((char const *)s);
# 3874 "gzip.c"
    if (sizeof(ifname) <= (size_t )ilen + tmp___4) {
# 3875 "gzip.c"
      goto name_too_long;
    } else {

    }
# 3876 "gzip.c"
    strcat((char * __restrict )(ifname), (char const * __restrict )s);
# 3877 "gzip.c"
    tmp___5 = do_stat(ifname, sbuf);
# 3877 "gzip.c"
    if (tmp___5 == 0) {
# 3877 "gzip.c"
      __retres18 = 0;
# 3877 "gzip.c"
      goto return_label;
    } else {

    }
# 3878 "gzip.c"
    tmp___7 = strcmp((char const *)s0, (char const *)z_suffix);
# 3878 "gzip.c"
    if (tmp___7 == 0) {
# 3879 "gzip.c"
      tmp___6 = __errno_location();
# 3879 "gzip.c"
      z_suffix_errno = *tmp___6;
    } else {

    }
# 3863 "gzip.c"
    suf ++;
# 3863 "gzip.c"
    if ((unsigned int )*suf != (unsigned int )((void *)0)) {

    } else {
# 3863 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 3883 "gzip.c"
  strcpy((char * __restrict )(ifname), (char const * __restrict )iname);
# 3891 "gzip.c"
  strcat((char * __restrict )(ifname), (char const * __restrict )z_suffix);
# 3892 "gzip.c"
  tmp___8 = __errno_location();
# 3892 "gzip.c"
  *tmp___8 = z_suffix_errno;
# 3893 "gzip.c"
  progerror(ifname);
# 3894 "gzip.c"
  __retres18 = 1;
# 3894 "gzip.c"
  goto return_label;
  name_too_long:
# 3897 "gzip.c"
  fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: file name too long\n",
          progname, iname);
# 3898 "gzip.c"
  exit_code = 1;
# 3899 "gzip.c"
  __retres18 = 1;
  return_label:
# 3817 "gzip.c"
  return (__retres18);
}
}
# 3906 "gzip.c"
static int make_ofname(void)
{
  char *suff ;
  int tmp ;
  int tmp___0 ;
  size_t tmp___1 ;
  int __retres5 ;

  {
# 3910 "gzip.c"
  strcpy((char * __restrict )(ofname), (char const * __restrict )(ifname));
# 3912 "gzip.c"
  suff = get_suffix(ofname);
# 3914 "gzip.c"
  if (decompress != 0) {
# 3915 "gzip.c"
    if ((unsigned int )suff == (unsigned int )((void *)0)) {
# 3919 "gzip.c"
      if (recursive == 0) {
# 3919 "gzip.c"
        if (list != 0) {
# 3919 "gzip.c"
          __retres5 = 0;
# 3919 "gzip.c"
          goto return_label;
        } else
# 3919 "gzip.c"
        if (test != 0) {
# 3919 "gzip.c"
          __retres5 = 0;
# 3919 "gzip.c"
          goto return_label;
        } else {

        }
      } else {

      }
# 3922 "gzip.c"
      if (verbose != 0) {
# 3922 "gzip.c"
        goto _L;
      } else
# 3922 "gzip.c"
      if (recursive == 0) {
# 3922 "gzip.c"
        if (quiet == 0) {
          _L:
# 3923 "gzip.c"
          if (quiet == 0) {
# 3923 "gzip.c"
            fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: unknown suffix -- ignored\n",
                    progname, ifname);
          } else {

          }
# 3923 "gzip.c"
          if (exit_code == 0) {
# 3923 "gzip.c"
            exit_code = 2;
          } else {

          }
        } else {

        }
      } else {

      }
# 3926 "gzip.c"
      __retres5 = 2;
# 3926 "gzip.c"
      goto return_label;
    } else {

    }
# 3929 "gzip.c"
    strlwr(suff);
# 3930 "gzip.c"
    tmp = strcmp((char const *)suff, ".tgz");
# 3930 "gzip.c"
    if (tmp == 0) {
# 3931 "gzip.c"
      strcpy((char * __restrict )suff, (char const * __restrict )".tar");
    } else {
# 3930 "gzip.c"
      tmp___0 = strcmp((char const *)suff, ".taz");
# 3930 "gzip.c"
      if (tmp___0 == 0) {
# 3931 "gzip.c"
        strcpy((char * __restrict )suff, (char const * __restrict )".tar");
      } else {
# 3933 "gzip.c"
        *suff = (char )'\000';
      }
    }
  } else
# 3937 "gzip.c"
  if ((unsigned int )suff != (unsigned int )((void *)0)) {
# 3939 "gzip.c"
    if (verbose != 0) {
# 3941 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s already has %s suffix -- unchanged\n",
              progname, ifname, suff);
    } else
# 3939 "gzip.c"
    if (recursive == 0) {
# 3939 "gzip.c"
      if (quiet == 0) {
# 3941 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s already has %s suffix -- unchanged\n",
                progname, ifname, suff);
      } else {

      }
    } else {

    }
# 3944 "gzip.c"
    __retres5 = 2;
# 3944 "gzip.c"
    goto return_label;
  } else {
# 3946 "gzip.c"
    save_orig_name = 0;
# 3971 "gzip.c"
    tmp___1 = strlen((char const *)(ofname));
# 3971 "gzip.c"
    if (sizeof(ofname) <= tmp___1 + z_len) {
# 3972 "gzip.c"
      goto name_too_long;
    } else {

    }
# 3973 "gzip.c"
    strcat((char * __restrict )(ofname), (char const * __restrict )z_suffix);
  }
# 3976 "gzip.c"
  __retres5 = 0;
# 3976 "gzip.c"
  goto return_label;
  name_too_long:
# 3979 "gzip.c"
  if (quiet == 0) {
# 3979 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: file name too long\n",
            progname, ifname);
  } else {

  }
# 3979 "gzip.c"
  if (exit_code == 0) {
# 3979 "gzip.c"
    exit_code = 2;
  } else {

  }
# 3980 "gzip.c"
  __retres5 = 2;
  return_label:
# 3906 "gzip.c"
  return (__retres5);
}
}
# 3995 "gzip.c"
static int get_method(int in )
{
  uch flags ;
  char magic[2] ;
  int imagic1 ;
  ulg stamp ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  unsigned int tmp___4 ;
  int tmp___5 ;
  int tmp___6 ;
  unsigned int tmp___7 ;
  int tmp___8 ;
  int tmp___9 ;
  unsigned int tmp___10 ;
  int tmp___11 ;
  int tmp___12 ;
  unsigned int tmp___13 ;
  int tmp___14 ;
  int tmp___15 ;
  unsigned int tmp___16 ;
  int tmp___17 ;
  int tmp___18 ;
  unsigned int tmp___19 ;
  int tmp___20 ;
  int tmp___21 ;
  unsigned int tmp___22 ;
  int tmp___23 ;
  int tmp___24 ;
  unsigned int tmp___25 ;
  int tmp___26 ;
  int tmp___27 ;
  unsigned int tmp___28 ;
  unsigned int tmp___29 ;
  unsigned int part ;
  unsigned int tmp___30 ;
  int tmp___31 ;
  int tmp___32 ;
  unsigned int tmp___33 ;
  int tmp___34 ;
  int tmp___35 ;
  unsigned int len ;
  unsigned int tmp___36 ;
  int tmp___37 ;
  int tmp___38 ;
  unsigned int tmp___39 ;
  int tmp___40 ;
  int tmp___41 ;
  unsigned int tmp___42 ;
  unsigned int tmp___43 ;
  char c ;
  unsigned int tmp___44 ;
  int tmp___45 ;
  char *p ;
  char *tmp___46 ;
  char *base ;
  char *base2 ;
  unsigned int tmp___47 ;
  int tmp___48 ;
  int tmp___49 ;
  char *tmp___50 ;
  unsigned int tmp___51 ;
  int tmp___52 ;
  int tmp___53 ;
  int tmp___54 ;
  int tmp___55 ;
  int tmp___56 ;
  int tmp___57 ;
  int tmp___58 ;
  int tmp___59 ;
  int tmp___60 ;
  int tmp___61 ;
  int inbyte ;
  unsigned int tmp___62 ;
  int tmp___63 ;
  int __retres78 ;

  {
# 4006 "gzip.c"
  if (force != 0) {
# 4006 "gzip.c"
    if (to_stdout != 0) {
# 4007 "gzip.c"
      if (inptr < insize) {
# 4007 "gzip.c"
        tmp = inptr;
# 4007 "gzip.c"
        inptr ++;
# 4007 "gzip.c"
        tmp___1 = (int )inbuf[tmp];
      } else {
# 4007 "gzip.c"
        tmp___0 = fill_inbuf(1);
# 4007 "gzip.c"
        tmp___1 = tmp___0;
      }
# 4007 "gzip.c"
      magic[0] = (char )tmp___1;
# 4008 "gzip.c"
      if (inptr < insize) {
# 4008 "gzip.c"
        tmp___2 = inptr;
# 4008 "gzip.c"
        inptr ++;
# 4008 "gzip.c"
        imagic1 = (int )inbuf[tmp___2];
      } else {
# 4008 "gzip.c"
        tmp___3 = fill_inbuf(1);
# 4008 "gzip.c"
        imagic1 = tmp___3;
      }
# 4009 "gzip.c"
      magic[1] = (char )imagic1;
    } else {
# 4006 "gzip.c"
      goto _L;
    }
  } else {
    _L:
# 4012 "gzip.c"
    if (inptr < insize) {
# 4012 "gzip.c"
      tmp___4 = inptr;
# 4012 "gzip.c"
      inptr ++;
# 4012 "gzip.c"
      tmp___6 = (int )inbuf[tmp___4];
    } else {
# 4012 "gzip.c"
      tmp___5 = fill_inbuf(0);
# 4012 "gzip.c"
      tmp___6 = tmp___5;
    }
# 4012 "gzip.c"
    magic[0] = (char )tmp___6;
# 4013 "gzip.c"
    if (inptr < insize) {
# 4013 "gzip.c"
      tmp___7 = inptr;
# 4013 "gzip.c"
      inptr ++;
# 4013 "gzip.c"
      tmp___9 = (int )inbuf[tmp___7];
    } else {
# 4013 "gzip.c"
      tmp___8 = fill_inbuf(0);
# 4013 "gzip.c"
      tmp___9 = tmp___8;
    }
# 4013 "gzip.c"
    magic[1] = (char )tmp___9;
# 4014 "gzip.c"
    imagic1 = 0;
  }
# 4016 "gzip.c"
  method = -1;
# 4017 "gzip.c"
  part_nb ++;
# 4018 "gzip.c"
  header_bytes = (off_t )0;
# 4019 "gzip.c"
  last_member = 0;
# 4022 "gzip.c"
  tmp___60 = memcmp((void const *)(magic), (void const *)"\037\213", (size_t )2);
# 4022 "gzip.c"
  if (tmp___60 == 0) {
# 4022 "gzip.c"
    goto _L___4;
  } else {
# 4022 "gzip.c"
    tmp___61 = memcmp((void const *)(magic), (void const *)"\037\236", (size_t )2);
# 4022 "gzip.c"
    if (tmp___61 == 0) {
      _L___4:
# 4025 "gzip.c"
      if (inptr < insize) {
# 4025 "gzip.c"
        tmp___10 = inptr;
# 4025 "gzip.c"
        inptr ++;
# 4025 "gzip.c"
        tmp___12 = (int )inbuf[tmp___10];
      } else {
# 4025 "gzip.c"
        tmp___11 = fill_inbuf(0);
# 4025 "gzip.c"
        tmp___12 = tmp___11;
      }
# 4025 "gzip.c"
      method = tmp___12;
# 4026 "gzip.c"
      if (method != 8) {
# 4027 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: unknown method %d -- not supported\n",
                progname, ifname, method);
# 4030 "gzip.c"
        exit_code = 1;
# 4031 "gzip.c"
        __retres78 = -1;
# 4031 "gzip.c"
        goto return_label;
      } else {

      }
# 4033 "gzip.c"
      work = & unzip;
# 4034 "gzip.c"
      if (inptr < insize) {
# 4034 "gzip.c"
        tmp___13 = inptr;
# 4034 "gzip.c"
        inptr ++;
# 4034 "gzip.c"
        tmp___15 = (int )inbuf[tmp___13];
      } else {
# 4034 "gzip.c"
        tmp___14 = fill_inbuf(0);
# 4034 "gzip.c"
        tmp___15 = tmp___14;
      }
# 4034 "gzip.c"
      flags = (uch )tmp___15;
# 4036 "gzip.c"
      if (((int )flags & 32) != 0) {
# 4037 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s is encrypted -- not supported\n",
                progname, ifname);
# 4040 "gzip.c"
        exit_code = 1;
# 4041 "gzip.c"
        __retres78 = -1;
# 4041 "gzip.c"
        goto return_label;
      } else {

      }
# 4043 "gzip.c"
      if (((int )flags & 2) != 0) {
# 4044 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s is a a multi-part gzip file -- not supported\n",
                progname, ifname);
# 4047 "gzip.c"
        exit_code = 1;
# 4048 "gzip.c"
        if (force <= 1) {
# 4048 "gzip.c"
          __retres78 = -1;
# 4048 "gzip.c"
          goto return_label;
        } else {

        }
      } else {

      }
# 4050 "gzip.c"
      if (((int )flags & 192) != 0) {
# 4051 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s has flags 0x%x -- not supported\n",
                progname, ifname, (int )flags);
# 4054 "gzip.c"
        exit_code = 1;
# 4055 "gzip.c"
        if (force <= 1) {
# 4055 "gzip.c"
          __retres78 = -1;
# 4055 "gzip.c"
          goto return_label;
        } else {

        }
      } else {

      }
# 4057 "gzip.c"
      if (inptr < insize) {
# 4057 "gzip.c"
        tmp___16 = inptr;
# 4057 "gzip.c"
        inptr ++;
# 4057 "gzip.c"
        tmp___18 = (int )inbuf[tmp___16];
      } else {
# 4057 "gzip.c"
        tmp___17 = fill_inbuf(0);
# 4057 "gzip.c"
        tmp___18 = tmp___17;
      }
# 4057 "gzip.c"
      stamp = (ulg )tmp___18;
# 4058 "gzip.c"
      if (inptr < insize) {
# 4058 "gzip.c"
        tmp___19 = inptr;
# 4058 "gzip.c"
        inptr ++;
# 4058 "gzip.c"
        tmp___21 = (int )inbuf[tmp___19];
      } else {
# 4058 "gzip.c"
        tmp___20 = fill_inbuf(0);
# 4058 "gzip.c"
        tmp___21 = tmp___20;
      }
# 4058 "gzip.c"
      stamp |= (ulg )tmp___21 << 8;
# 4059 "gzip.c"
      if (inptr < insize) {
# 4059 "gzip.c"
        tmp___22 = inptr;
# 4059 "gzip.c"
        inptr ++;
# 4059 "gzip.c"
        tmp___24 = (int )inbuf[tmp___22];
      } else {
# 4059 "gzip.c"
        tmp___23 = fill_inbuf(0);
# 4059 "gzip.c"
        tmp___24 = tmp___23;
      }
# 4059 "gzip.c"
      stamp |= (ulg )tmp___24 << 16;
# 4060 "gzip.c"
      if (inptr < insize) {
# 4060 "gzip.c"
        tmp___25 = inptr;
# 4060 "gzip.c"
        inptr ++;
# 4060 "gzip.c"
        tmp___27 = (int )inbuf[tmp___25];
      } else {
# 4060 "gzip.c"
        tmp___26 = fill_inbuf(0);
# 4060 "gzip.c"
        tmp___27 = tmp___26;
      }
# 4060 "gzip.c"
      stamp |= (ulg )tmp___27 << 24;
# 4061 "gzip.c"
      if (stamp != 0UL) {
# 4061 "gzip.c"
        if (no_time == 0) {
# 4061 "gzip.c"
          time_stamp = (time_t )stamp;
        } else {

        }
      } else {

      }
# 4063 "gzip.c"
      if (inptr < insize) {
# 4063 "gzip.c"
        tmp___28 = inptr;
# 4063 "gzip.c"
        inptr ++;
      } else {
# 4063 "gzip.c"
        fill_inbuf(0);
      }
# 4064 "gzip.c"
      if (inptr < insize) {
# 4064 "gzip.c"
        tmp___29 = inptr;
# 4064 "gzip.c"
        inptr ++;
      } else {
# 4064 "gzip.c"
        fill_inbuf(0);
      }
# 4066 "gzip.c"
      if (((int )flags & 2) != 0) {
# 4067 "gzip.c"
        if (inptr < insize) {
# 4067 "gzip.c"
          tmp___30 = inptr;
# 4067 "gzip.c"
          inptr ++;
# 4067 "gzip.c"
          tmp___32 = (int )inbuf[tmp___30];
        } else {
# 4067 "gzip.c"
          tmp___31 = fill_inbuf(0);
# 4067 "gzip.c"
          tmp___32 = tmp___31;
        }
# 4067 "gzip.c"
        part = (unsigned int )tmp___32;
# 4068 "gzip.c"
        if (inptr < insize) {
# 4068 "gzip.c"
          tmp___33 = inptr;
# 4068 "gzip.c"
          inptr ++;
# 4068 "gzip.c"
          tmp___35 = (int )inbuf[tmp___33];
        } else {
# 4068 "gzip.c"
          tmp___34 = fill_inbuf(0);
# 4068 "gzip.c"
          tmp___35 = tmp___34;
        }
# 4068 "gzip.c"
        part |= (unsigned int )tmp___35 << 8;
# 4069 "gzip.c"
        if (verbose != 0) {
# 4070 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: part number %u\n",
                  progname, ifname, part);
        } else {

        }
      } else {

      }
# 4074 "gzip.c"
      if (((int )flags & 4) != 0) {
# 4075 "gzip.c"
        if (inptr < insize) {
# 4075 "gzip.c"
          tmp___36 = inptr;
# 4075 "gzip.c"
          inptr ++;
# 4075 "gzip.c"
          tmp___38 = (int )inbuf[tmp___36];
        } else {
# 4075 "gzip.c"
          tmp___37 = fill_inbuf(0);
# 4075 "gzip.c"
          tmp___38 = tmp___37;
        }
# 4075 "gzip.c"
        len = (unsigned int )tmp___38;
# 4076 "gzip.c"
        if (inptr < insize) {
# 4076 "gzip.c"
          tmp___39 = inptr;
# 4076 "gzip.c"
          inptr ++;
# 4076 "gzip.c"
          tmp___41 = (int )inbuf[tmp___39];
        } else {
# 4076 "gzip.c"
          tmp___40 = fill_inbuf(0);
# 4076 "gzip.c"
          tmp___41 = tmp___40;
        }
# 4076 "gzip.c"
        len |= (unsigned int )tmp___41 << 8;
# 4077 "gzip.c"
        if (verbose != 0) {
# 4078 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: extra field of %u bytes ignored\n",
                  progname, ifname, len);
        } else {

        }
        {
# 4081 "gzip.c"
        while (1) {
          while_continue: ;
# 4081 "gzip.c"
          tmp___43 = len;
# 4081 "gzip.c"
          len --;
# 4081 "gzip.c"
          if (tmp___43 != 0) {

          } else {
# 4081 "gzip.c"
            goto while_break;
          }
# 4081 "gzip.c"
          if (inptr < insize) {
# 4081 "gzip.c"
            tmp___42 = inptr;
# 4081 "gzip.c"
            inptr ++;
          } else {
# 4081 "gzip.c"
            fill_inbuf(0);
          }
        }
        while_break: ;
        }
      } else {

      }
# 4085 "gzip.c"
      if (((int )flags & 8) != 0) {
# 4086 "gzip.c"
        if (no_name != 0) {
# 4086 "gzip.c"
          goto _L___0;
        } else
# 4086 "gzip.c"
        if (to_stdout != 0) {
# 4086 "gzip.c"
          if (list == 0) {
# 4086 "gzip.c"
            goto _L___0;
          } else {
# 4086 "gzip.c"
            goto _L___1;
          }
        } else
        _L___1:
# 4086 "gzip.c"
        if (part_nb > 1) {
          _L___0:
          {
# 4089 "gzip.c"
          while (1) {
            while_continue___0: ;
# 4089 "gzip.c"
            if (inptr < insize) {
# 4089 "gzip.c"
              tmp___44 = inptr;
# 4089 "gzip.c"
              inptr ++;
# 4089 "gzip.c"
              c = (char )inbuf[tmp___44];
            } else {
# 4089 "gzip.c"
              tmp___45 = fill_inbuf(0);
# 4089 "gzip.c"
              c = (char )tmp___45;
            }
# 4089 "gzip.c"
            if ((int )c != 0) {

            } else {
# 4089 "gzip.c"
              goto while_break___0;
            }
          }
          while_break___0: ;
          }
        } else {
# 4092 "gzip.c"
          tmp___46 = base_name(ofname);
# 4092 "gzip.c"
          p = tmp___46;
# 4093 "gzip.c"
          base = p;
          {
# 4095 "gzip.c"
          while (1) {
            while_continue___1: ;
# 4096 "gzip.c"
            if (inptr < insize) {
# 4096 "gzip.c"
              tmp___47 = inptr;
# 4096 "gzip.c"
              inptr ++;
# 4096 "gzip.c"
              tmp___49 = (int )inbuf[tmp___47];
            } else {
# 4096 "gzip.c"
              tmp___48 = fill_inbuf(0);
# 4096 "gzip.c"
              tmp___49 = tmp___48;
            }
# 4096 "gzip.c"
            *p = (char )tmp___49;
# 4097 "gzip.c"
            tmp___50 = p;
# 4097 "gzip.c"
            p ++;
# 4097 "gzip.c"
            if ((int )*tmp___50 == 0) {
# 4097 "gzip.c"
              goto while_break___1;
            } else {

            }
# 4098 "gzip.c"
            if ((unsigned int )p >= (unsigned int )(ofname + sizeof(ofname))) {
# 4099 "gzip.c"
              error((char *)"corrupted input -- file name too large");
            } else {

            }
          }
          while_break___1: ;
          }
# 4102 "gzip.c"
          base2 = base_name(base);
# 4103 "gzip.c"
          strcpy((char * __restrict )base, (char const * __restrict )base2);
# 4105 "gzip.c"
          if (list == 0) {
# 4107 "gzip.c"
            if (base != 0) {
# 4107 "gzip.c"
              list = 0;
            } else {

            }
          } else {

          }
        }
      } else {

      }
# 4113 "gzip.c"
      if (((int )flags & 16) != 0) {
        {
# 4114 "gzip.c"
        while (1) {
          while_continue___2: ;
# 4114 "gzip.c"
          if (inptr < insize) {
# 4114 "gzip.c"
            tmp___51 = inptr;
# 4114 "gzip.c"
            inptr ++;
# 4114 "gzip.c"
            tmp___53 = (int )inbuf[tmp___51];
          } else {
# 4114 "gzip.c"
            tmp___52 = fill_inbuf(0);
# 4114 "gzip.c"
            tmp___53 = tmp___52;
          }
# 4114 "gzip.c"
          if (tmp___53 != 0) {

          } else {
# 4114 "gzip.c"
            goto while_break___2;
          }
        }
        while_break___2: ;
        }
      } else {

      }
# 4116 "gzip.c"
      if (part_nb == 1) {
# 4117 "gzip.c"
        header_bytes = (off_t )(inptr + 2U * sizeof(long ));
      } else {

      }
    } else {
# 4120 "gzip.c"
      tmp___58 = memcmp((void const *)(magic), (void const *)"PK\003\004", (size_t )2);
# 4120 "gzip.c"
      if (tmp___58 == 0) {
# 4120 "gzip.c"
        if (inptr == 2U) {
# 4120 "gzip.c"
          tmp___59 = memcmp((void const *)((char *)(inbuf)), (void const *)"PK\003\004",
                            (size_t )4);
# 4120 "gzip.c"
          if (tmp___59 == 0) {
# 4125 "gzip.c"
            inptr = 0U;
# 4126 "gzip.c"
            work = & unzip;
# 4127 "gzip.c"
            tmp___54 = check_zipfile(in);
# 4127 "gzip.c"
            if (tmp___54 != 0) {
# 4127 "gzip.c"
              __retres78 = -1;
# 4127 "gzip.c"
              goto return_label;
            } else {

            }
# 4129 "gzip.c"
            last_member = 1;
          } else {
# 4120 "gzip.c"
            goto _L___3;
          }
        } else {
# 4120 "gzip.c"
          goto _L___3;
        }
      } else {
        _L___3:
# 4131 "gzip.c"
        tmp___57 = memcmp((void const *)(magic), (void const *)"\037\036", (size_t )2);
# 4131 "gzip.c"
        if (tmp___57 == 0) {
# 4132 "gzip.c"
          work = & unpack;
# 4133 "gzip.c"
          method = 2;
        } else {
# 4135 "gzip.c"
          tmp___56 = memcmp((void const *)(magic), (void const *)"\037\235", (size_t )2);
# 4135 "gzip.c"
          if (tmp___56 == 0) {
# 4136 "gzip.c"
            work = & unlzw;
# 4137 "gzip.c"
            method = 1;
# 4138 "gzip.c"
            last_member = 1;
          } else {
# 4140 "gzip.c"
            tmp___55 = memcmp((void const *)(magic), (void const *)"\037\240",
                              (size_t )2);
# 4140 "gzip.c"
            if (tmp___55 == 0) {
# 4141 "gzip.c"
              work = & unlzh;
# 4142 "gzip.c"
              method = 3;
# 4143 "gzip.c"
              last_member = 1;
            } else
# 4145 "gzip.c"
            if (force != 0) {
# 4145 "gzip.c"
              if (to_stdout != 0) {
# 4145 "gzip.c"
                if (list == 0) {
# 4146 "gzip.c"
                  method = 0;
# 4147 "gzip.c"
                  work = & copy;
# 4148 "gzip.c"
                  inptr = 0U;
# 4149 "gzip.c"
                  last_member = 1;
                } else {

                }
              } else {

              }
            } else {

            }
          }
        }
      }
    }
  }
# 4151 "gzip.c"
  if (method >= 0) {
# 4151 "gzip.c"
    __retres78 = method;
# 4151 "gzip.c"
    goto return_label;
  } else {

  }
# 4153 "gzip.c"
  if (part_nb == 1) {
# 4154 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: not in gzip format\n",
            progname, ifname);
# 4155 "gzip.c"
    exit_code = 1;
# 4156 "gzip.c"
    __retres78 = -1;
# 4156 "gzip.c"
    goto return_label;
  } else {
# 4158 "gzip.c"
    if ((int )magic[0] == 0) {
# 4161 "gzip.c"
      inbyte = imagic1;
      {
# 4161 "gzip.c"
      while (1) {
        while_continue___3: ;
# 4161 "gzip.c"
        if (inbyte == 0) {

        } else {
# 4161 "gzip.c"
          goto while_break___3;
        }
# 4162 "gzip.c"
        goto __Cont;
        __Cont:
# 4161 "gzip.c"
        if (inptr < insize) {
# 4161 "gzip.c"
          tmp___62 = inptr;
# 4161 "gzip.c"
          inptr ++;
# 4161 "gzip.c"
          inbyte = (int )inbuf[tmp___62];
        } else {
# 4161 "gzip.c"
          tmp___63 = fill_inbuf(1);
# 4161 "gzip.c"
          inbyte = tmp___63;
        }
      }
      while_break___3: ;
      }
# 4163 "gzip.c"
      if (inbyte == -1) {
# 4165 "gzip.c"
        if (verbose != 0) {
# 4166 "gzip.c"
          if (quiet == 0) {
# 4166 "gzip.c"
            fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: decompression OK, trailing zero bytes ignored\n",
                    progname, ifname);
          } else {

          }
# 4166 "gzip.c"
          if (exit_code == 0) {
# 4166 "gzip.c"
            exit_code = 2;
          } else {

          }
        } else {

        }
# 4168 "gzip.c"
        __retres78 = -3;
# 4168 "gzip.c"
        goto return_label;
      } else {

      }
    } else {

    }
# 4172 "gzip.c"
    if (quiet == 0) {
# 4172 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: decompression OK, trailing garbage ignored\n",
              progname, ifname);
    } else {

    }
# 4172 "gzip.c"
    if (exit_code == 0) {
# 4172 "gzip.c"
      exit_code = 2;
    } else {

    }
# 4174 "gzip.c"
    __retres78 = -2;
# 4174 "gzip.c"
    goto return_label;
  }
  return_label:
# 3995 "gzip.c"
  return (__retres78);
}
}
# 4188 "gzip.c"
static void do_list(int ifd___0 , int method___0 ) ;
# 4188 "gzip.c"
static int first_time = 1;
# 4189 "gzip.c"
static void do_list(int ifd___0 , int method___0 ) ;
# 4189 "gzip.c"
static char *methods[9] =
# 4189 "gzip.c"
  { (char *)"store", (char *)"compr", (char *)"pack ", (char *)"lzh  ",
        (char *)"", (char *)"", (char *)"", (char *)"",
        (char *)"defla"};
# 4183 "gzip.c"
static void do_list(int ifd___0 , int method___0 )
{
  ulg crc ;
  char *date ;
  int positive_off_t_width ;
  off_t o ;
  uch buf[8] ;
  ssize_t tmp ;
  char *tmp___0 ;
  uch *mem_10 ;
  uch *mem_11 ;
  uch *mem_12 ;
  uch *mem_13 ;
  uch *mem_14 ;
  uch *mem_15 ;
  char *mem_16 ;

  {
# 4197 "gzip.c"
  positive_off_t_width = 1;
# 4200 "gzip.c"
  o = -1L - (-1L << (sizeof(off_t ) * 8U - 1U));
  {
# 4200 "gzip.c"
  while (1) {
    while_continue: ;
# 4200 "gzip.c"
    if (9L < o) {

    } else {
# 4200 "gzip.c"
      goto while_break;
    }
# 4201 "gzip.c"
    positive_off_t_width ++;
# 4200 "gzip.c"
    o /= 10L;
  }
  while_break: ;
  }
# 4204 "gzip.c"
  if (first_time != 0) {
# 4204 "gzip.c"
    if (method___0 >= 0) {
# 4205 "gzip.c"
      first_time = 0;
# 4206 "gzip.c"
      if (verbose != 0) {
# 4207 "gzip.c"
        printf((char const * __restrict )"method  crc     date  time  ");
      } else {

      }
# 4209 "gzip.c"
      if (quiet == 0) {
# 4210 "gzip.c"
        printf((char const * __restrict )"%*.*s %*.*s  ratio uncompressed_name\n",
               positive_off_t_width, positive_off_t_width, "compressed", positive_off_t_width,
               positive_off_t_width, "uncompressed");
      } else {

      }
    } else {
# 4204 "gzip.c"
      goto _L;
    }
  } else
  _L:
# 4214 "gzip.c"
  if (method___0 < 0) {
# 4215 "gzip.c"
    if (total_in <= 0L) {
# 4215 "gzip.c"
      goto return_label;
    } else
# 4215 "gzip.c"
    if (total_out <= 0L) {
# 4215 "gzip.c"
      goto return_label;
    } else {

    }
# 4216 "gzip.c"
    if (verbose != 0) {
# 4217 "gzip.c"
      printf((char const * __restrict )"                            ");
    } else {

    }
# 4219 "gzip.c"
    if (verbose != 0) {
# 4220 "gzip.c"
      fprint_off(stdout, total_in, positive_off_t_width);
# 4221 "gzip.c"
      printf((char const * __restrict )" ");
# 4222 "gzip.c"
      fprint_off(stdout, total_out, positive_off_t_width);
# 4223 "gzip.c"
      printf((char const * __restrict )" ");
    } else
# 4219 "gzip.c"
    if (quiet == 0) {
# 4220 "gzip.c"
      fprint_off(stdout, total_in, positive_off_t_width);
# 4221 "gzip.c"
      printf((char const * __restrict )" ");
# 4222 "gzip.c"
      fprint_off(stdout, total_out, positive_off_t_width);
# 4223 "gzip.c"
      printf((char const * __restrict )" ");
    } else {

    }
# 4225 "gzip.c"
    display_ratio(total_out - (total_in - header_bytes), total_out, stdout);
# 4229 "gzip.c"
    printf((char const * __restrict )" (totals)\n");
# 4230 "gzip.c"
    goto return_label;
  } else {

  }
# 4232 "gzip.c"
  crc = (ulg )(~ 0);
# 4233 "gzip.c"
  bytes_out = -1L;
# 4234 "gzip.c"
  bytes_in = ifile_size;
# 4237 "gzip.c"
  if (method___0 == 8) {
# 4237 "gzip.c"
    if (last_member == 0) {
# 4244 "gzip.c"
      bytes_in = lseek(ifd___0, (off_t )-8, 2);
# 4245 "gzip.c"
      if (bytes_in != -1L) {
# 4247 "gzip.c"
        bytes_in += 8L;
# 4248 "gzip.c"
        tmp = read(ifd___0, (void *)((char *)(buf)), sizeof(buf));
# 4248 "gzip.c"
        if ((unsigned int )tmp != sizeof(buf)) {
# 4249 "gzip.c"
          read_error();
        } else {

        }
# 4251 "gzip.c"
        mem_10 = (buf + 2) + 0;
# 4251 "gzip.c"
        mem_11 = (buf + 2) + 1;
# 4251 "gzip.c"
        crc = (ulg )((int )((ush )buf[0]) | ((int )((ush )buf[1]) << 8)) | ((ulg )((int )((ush )*mem_10) | ((int )((ush )*mem_11) << 8)) << 16);
# 4252 "gzip.c"
        mem_12 = (buf + 4) + 0;
# 4252 "gzip.c"
        mem_13 = (buf + 4) + 1;
# 4252 "gzip.c"
        mem_14 = ((buf + 4) + 2) + 0;
# 4252 "gzip.c"
        mem_15 = ((buf + 4) + 2) + 1;
# 4252 "gzip.c"
        bytes_out = (off_t )((ulg )((int )((ush )*mem_12) | ((int )((ush )*mem_13) << 8)) | ((ulg )((int )((ush )*mem_14) | ((int )((ush )*mem_15) << 8)) << 16));
      } else {

      }
    } else {

    }
  } else {

  }
# 4256 "gzip.c"
  tmp___0 = ctime((time_t const *)(& time_stamp));
# 4256 "gzip.c"
  date = tmp___0 + 4;
# 4257 "gzip.c"
  mem_16 = date + 12;
# 4257 "gzip.c"
  *mem_16 = (char )'\000';
# 4258 "gzip.c"
  if (verbose != 0) {
# 4259 "gzip.c"
    printf((char const * __restrict )"%5s %08lx %11s ", methods[method___0], crc,
           date);
  } else {

  }
# 4261 "gzip.c"
  fprint_off(stdout, bytes_in, positive_off_t_width);
# 4262 "gzip.c"
  printf((char const * __restrict )" ");
# 4263 "gzip.c"
  fprint_off(stdout, bytes_out, positive_off_t_width);
# 4264 "gzip.c"
  printf((char const * __restrict )" ");
# 4265 "gzip.c"
  if (bytes_in == -1L) {
# 4266 "gzip.c"
    total_in = -1L;
# 4267 "gzip.c"
    header_bytes = (off_t )0;
# 4267 "gzip.c"
    bytes_out = header_bytes;
# 4267 "gzip.c"
    bytes_in = bytes_out;
  } else
# 4268 "gzip.c"
  if (total_in >= 0L) {
# 4269 "gzip.c"
    total_in += bytes_in;
  } else {

  }
# 4271 "gzip.c"
  if (bytes_out == -1L) {
# 4272 "gzip.c"
    total_out = -1L;
# 4273 "gzip.c"
    header_bytes = (off_t )0;
# 4273 "gzip.c"
    bytes_out = header_bytes;
# 4273 "gzip.c"
    bytes_in = bytes_out;
  } else
# 4274 "gzip.c"
  if (total_out >= 0L) {
# 4275 "gzip.c"
    total_out += bytes_out;
  } else {

  }
# 4277 "gzip.c"
  display_ratio(bytes_out - (bytes_in - header_bytes), bytes_out, stdout);
# 4278 "gzip.c"
  printf((char const * __restrict )" %s\n", ofname);

  return_label:
# 4183 "gzip.c"
  return;
}
}
# 4284 "gzip.c"
static int same_file(struct stat *stat1 , struct stat *stat2 )
{
  int tmp ;

  {
# 4288 "gzip.c"
  if (stat1->st_ino == stat2->st_ino) {
# 4288 "gzip.c"
    if (stat1->st_dev == stat2->st_dev) {
# 4288 "gzip.c"
      tmp = 1;
    } else {
# 4288 "gzip.c"
      tmp = 0;
    }
  } else {
# 4288 "gzip.c"
    tmp = 0;
  }
# 4288 "gzip.c"
  return (tmp);
}
}
# 4307 "gzip.c"
static int name_too_long(char *name , struct stat *statb )
{
  int s ;
  size_t tmp ;
  char c ;
  struct stat tstat ;
  int res ;
  int tmp___0 ;
  int tmp___1 ;
  int tmp___2 ;
  char *mem_11 ;
  char *mem_12 ;
  char *mem_13 ;

  {
# 4311 "gzip.c"
  tmp = strlen((char const *)name);
# 4311 "gzip.c"
  s = (int )tmp;
# 4312 "gzip.c"
  mem_11 = name + (s - 1);
# 4312 "gzip.c"
  c = *mem_11;
# 4316 "gzip.c"
  tstat = *statb;
# 4317 "gzip.c"
  mem_12 = name + (s - 1);
# 4317 "gzip.c"
  *mem_12 = (char )'\000';
# 4318 "gzip.c"
  tmp___0 = lstat((char const * __restrict )name, (struct stat * __restrict )(& tstat));
# 4318 "gzip.c"
  if (tmp___0 == 0) {
# 4318 "gzip.c"
    tmp___1 = same_file(statb, & tstat);
# 4318 "gzip.c"
    if (tmp___1 != 0) {
# 4318 "gzip.c"
      tmp___2 = 1;
    } else {
# 4318 "gzip.c"
      tmp___2 = 0;
    }
  } else {
# 4318 "gzip.c"
    tmp___2 = 0;
  }
# 4318 "gzip.c"
  res = tmp___2;
# 4319 "gzip.c"
  mem_13 = name + (s - 1);
# 4319 "gzip.c"
  *mem_13 = c;
# 4321 "gzip.c"
  return (res);
}
}
# 4333 "gzip.c"
static void shorten_name(char *name )
{
  int len ;
  char *trunc ;
  int plen ;
  int min_part ;
  char *p ;
  size_t tmp ;
  int tmp___0 ;
  size_t tmp___1 ;
  char *tmp___2 ;
  char *mem_11 ;
  char *mem_12 ;
  char *mem_13 ;
  char const *mem_14 ;
  char *mem_15 ;

  {
# 4337 "gzip.c"
  trunc = (char *)((void *)0);
# 4339 "gzip.c"
  min_part = 3;
# 4342 "gzip.c"
  tmp = strlen((char const *)name);
# 4342 "gzip.c"
  len = (int )tmp;
# 4343 "gzip.c"
  if (decompress != 0) {
# 4344 "gzip.c"
    if (len <= 1) {
# 4344 "gzip.c"
      error((char *)"name too short");
    } else {

    }
# 4345 "gzip.c"
    mem_11 = name + (len - 1);
# 4345 "gzip.c"
    *mem_11 = (char )'\000';
# 4346 "gzip.c"
    goto return_label;
  } else {

  }
# 4348 "gzip.c"
  p = get_suffix(name);
# 4349 "gzip.c"
  if ((unsigned int )p == (unsigned int )((void *)0)) {
# 4349 "gzip.c"
    error((char *)"can\'t recover suffix\n");
  } else {

  }
# 4350 "gzip.c"
  *p = (char )'\000';
# 4351 "gzip.c"
  save_orig_name = 1;
# 4354 "gzip.c"
  if (len > 4) {
# 4354 "gzip.c"
    tmp___0 = strcmp((char const *)(p - 4), ".tar");
# 4354 "gzip.c"
    if (tmp___0 == 0) {
# 4355 "gzip.c"
      strcpy((char * __restrict )(p - 4), (char const * __restrict )".tgz");
# 4356 "gzip.c"
      goto return_label;
    } else {

    }
  } else {

  }
  {
# 4361 "gzip.c"
  while (1) {
    while_continue: ;
# 4362 "gzip.c"
    p = strrchr((char const *)name, '/');
# 4363 "gzip.c"
    if (p != 0) {
# 4363 "gzip.c"
      p ++;
    } else {
# 4363 "gzip.c"
      p = name;
    }
    {
# 4364 "gzip.c"
    while (1) {
      while_continue___0: ;
# 4364 "gzip.c"
      if (*p != 0) {

      } else {
# 4364 "gzip.c"
        goto while_break___0;
      }
# 4365 "gzip.c"
      tmp___1 = strcspn((char const *)p, ".");
# 4365 "gzip.c"
      plen = (int )tmp___1;
# 4366 "gzip.c"
      p += plen;
# 4367 "gzip.c"
      if (plen > min_part) {
# 4367 "gzip.c"
        trunc = p - 1;
      } else {

      }
# 4368 "gzip.c"
      if (*p != 0) {
# 4368 "gzip.c"
        p ++;
      } else {

      }
    }
    while_break___0: ;
    }
# 4361 "gzip.c"
    if ((unsigned int )trunc == (unsigned int )((void *)0)) {
# 4361 "gzip.c"
      min_part --;
# 4361 "gzip.c"
      if (min_part != 0) {

      } else {
# 4361 "gzip.c"
        goto while_break;
      }
    } else {
# 4361 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 4372 "gzip.c"
  if ((unsigned int )trunc != (unsigned int )((void *)0)) {
    {
# 4373 "gzip.c"
    while (1) {
      while_continue___1: ;
# 4374 "gzip.c"
      mem_12 = trunc + 0;
# 4374 "gzip.c"
      mem_13 = trunc + 1;
# 4374 "gzip.c"
      *mem_12 = *mem_13;
# 4373 "gzip.c"
      tmp___2 = trunc;
# 4373 "gzip.c"
      trunc ++;
# 4373 "gzip.c"
      if (*tmp___2 != 0) {

      } else {
# 4373 "gzip.c"
        goto while_break___1;
      }
    }
    while_break___1: ;
    }
# 4376 "gzip.c"
    trunc --;
  } else {
# 4378 "gzip.c"
    mem_14 = "." + 0;
# 4378 "gzip.c"
    trunc = strrchr((char const *)name, (int )*mem_14);
# 4379 "gzip.c"
    if ((unsigned int )trunc == (unsigned int )((void *)0)) {
# 4379 "gzip.c"
      error((char *)"internal error in shorten_name");
    } else {

    }
    {
# 4380 "gzip.c"
    mem_15 = trunc + 1;
# 4380 "gzip.c"
    if ((int )*mem_15 == 0) {
# 4380 "gzip.c"
      trunc --;
    } else {

    }
    }
  }
# 4382 "gzip.c"
  strcpy((char * __restrict )trunc, (char const * __restrict )z_suffix);

  return_label:
# 4333 "gzip.c"
  return;
}
}
# 4399 "gzip.c"
static int check_ofname(void)
{
  struct stat ostat ;
  int *tmp ;
  int *tmp___0 ;
  int tmp___1 ;
  int tmp___2 ;
  int tmp___3 ;
  char const *tmp___4 ;
  int tmp___5 ;
  int tmp___6 ;
  int ok ;
  int tmp___7 ;
  int tmp___8 ;
  int tmp___9 ;
  int __retres14 ;

  {
# 4407 "gzip.c"
  tmp = __errno_location();
# 4407 "gzip.c"
  *tmp = 0;
  {
# 4408 "gzip.c"
  while (1) {
    while_continue: ;
# 4408 "gzip.c"
    tmp___1 = lstat((char const * __restrict )(ofname), (struct stat * __restrict )(& ostat));
# 4408 "gzip.c"
    if (tmp___1 != 0) {

    } else {
# 4408 "gzip.c"
      goto while_break;
    }
# 4409 "gzip.c"
    tmp___0 = __errno_location();
# 4409 "gzip.c"
    if (*tmp___0 != 36) {
# 4409 "gzip.c"
      __retres14 = 0;
# 4409 "gzip.c"
      goto return_label;
    } else {

    }
# 4410 "gzip.c"
    shorten_name(ofname);
  }
  while_break: ;
  }
# 4419 "gzip.c"
  if (decompress == 0) {
# 4419 "gzip.c"
    tmp___3 = name_too_long(ofname, & ostat);
# 4419 "gzip.c"
    if (tmp___3 != 0) {
# 4420 "gzip.c"
      shorten_name(ofname);
# 4421 "gzip.c"
      tmp___2 = lstat((char const * __restrict )(ofname), (struct stat * __restrict )(& ostat));
# 4421 "gzip.c"
      if (tmp___2 != 0) {
# 4421 "gzip.c"
        __retres14 = 0;
# 4421 "gzip.c"
        goto return_label;
      } else {

      }
    } else {

    }
  } else {

  }
# 4427 "gzip.c"
  tmp___6 = same_file(& istat, & ostat);
# 4427 "gzip.c"
  if (tmp___6 != 0) {
# 4428 "gzip.c"
    tmp___5 = strcmp((char const *)(ifname), (char const *)(ofname));
# 4428 "gzip.c"
    if (tmp___5 == 0) {
# 4429 "gzip.c"
      if (decompress != 0) {
# 4429 "gzip.c"
        tmp___4 = "de";
      } else {
# 4429 "gzip.c"
        tmp___4 = "";
      }
# 4429 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: cannot %scompress onto itself\n",
              progname, ifname, tmp___4);
    } else {
# 4432 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s and %s are the same file\n",
              progname, ifname, ofname);
    }
# 4435 "gzip.c"
    exit_code = 1;
# 4436 "gzip.c"
    __retres14 = 1;
# 4436 "gzip.c"
    goto return_label;
  } else {

  }
# 4439 "gzip.c"
  if (force == 0) {
# 4440 "gzip.c"
    ok = 0;
# 4441 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s already exists;",
            progname, ofname);
# 4442 "gzip.c"
    if (foreground != 0) {
# 4442 "gzip.c"
      tmp___7 = fileno(stdin);
# 4442 "gzip.c"
      tmp___8 = isatty(tmp___7);
# 4442 "gzip.c"
      if (tmp___8 != 0) {
# 4443 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )" do you wish to overwrite (y or n)? ");
# 4444 "gzip.c"
        fflush(stderr);
# 4445 "gzip.c"
        ok = yesno();
      } else {

      }
    } else {

    }
# 4447 "gzip.c"
    if (ok == 0) {
# 4448 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"\tnot overwritten\n");
# 4449 "gzip.c"
      if (exit_code == 0) {
# 4449 "gzip.c"
        exit_code = 2;
      } else {

      }
# 4450 "gzip.c"
      __retres14 = 1;
# 4450 "gzip.c"
      goto return_label;
    } else {

    }
  } else {

  }
# 4453 "gzip.c"
  tmp___9 = xunlink(ofname);
# 4453 "gzip.c"
  if (tmp___9 != 0) {
# 4454 "gzip.c"
    progerror(ofname);
# 4455 "gzip.c"
    __retres14 = 1;
# 4455 "gzip.c"
    goto return_label;
  } else {

  }
# 4457 "gzip.c"
  __retres14 = 0;
  return_label:
# 4399 "gzip.c"
  return (__retres14);
}
}
# 4465 "gzip.c"
static void reset_times(char *name , struct stat *statb )
{
  struct utimbuf timep ;
  int e ;
  int *tmp ;
  int *tmp___0 ;
  int tmp___1 ;

  {
# 4472 "gzip.c"
  timep.actime = statb->st_atim.tv_sec;
# 4473 "gzip.c"
  timep.modtime = statb->st_mtim.tv_sec;
# 4476 "gzip.c"
  tmp___1 = utime((char const *)name, (struct utimbuf const *)(& timep));
# 4476 "gzip.c"
  if (tmp___1 != 0) {
# 4476 "gzip.c"
    if ((statb->st_mode & 61440U) != 16384U) {
# 4477 "gzip.c"
      tmp = __errno_location();
# 4477 "gzip.c"
      e = *tmp;
# 4478 "gzip.c"
      if (quiet == 0) {
# 4478 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: ",
                progname);
      } else {

      }
# 4478 "gzip.c"
      if (exit_code == 0) {
# 4478 "gzip.c"
        exit_code = 2;
      } else {

      }
# 4479 "gzip.c"
      if (quiet == 0) {
# 4480 "gzip.c"
        tmp___0 = __errno_location();
# 4480 "gzip.c"
        *tmp___0 = e;
# 4481 "gzip.c"
        perror((char const *)(ofname));
      } else {

      }
    } else {

    }
  } else {

  }
# 4465 "gzip.c"
  return;
}
}
# 4492 "gzip.c"
static void copy_stat(struct stat *ifstat )
{
  int e ;
  int *tmp ;
  int *tmp___0 ;
  int tmp___1 ;
  int e___0 ;
  int *tmp___2 ;
  int *tmp___3 ;
  int tmp___4 ;

  {
# 4496 "gzip.c"
  if (decompress != 0) {
# 4496 "gzip.c"
    if (time_stamp != 0L) {
# 4496 "gzip.c"
      if (ifstat->st_mtim.tv_sec != time_stamp) {
# 4497 "gzip.c"
        ifstat->st_mtim.tv_sec = time_stamp;
# 4498 "gzip.c"
        if (verbose > 1) {
# 4499 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: time stamp restored\n",
                  ofname);
        } else {

        }
      } else {

      }
    } else {

    }
  } else {

  }
# 4502 "gzip.c"
  reset_times(ofname, ifstat);
# 4505 "gzip.c"
  tmp___1 = fchmod(ofd, ifstat->st_mode & 4095U);
# 4505 "gzip.c"
  if (tmp___1 != 0) {
# 4506 "gzip.c"
    tmp = __errno_location();
# 4506 "gzip.c"
    e = *tmp;
# 4507 "gzip.c"
    if (quiet == 0) {
# 4507 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: ", progname);
    } else {

    }
# 4507 "gzip.c"
    if (exit_code == 0) {
# 4507 "gzip.c"
      exit_code = 2;
    } else {

    }
# 4508 "gzip.c"
    if (quiet == 0) {
# 4509 "gzip.c"
      tmp___0 = __errno_location();
# 4509 "gzip.c"
      *tmp___0 = e;
# 4510 "gzip.c"
      perror((char const *)(ofname));
    } else {

    }
  } else {

  }
# 4514 "gzip.c"
  fchown(ofd, ifstat->st_uid, ifstat->st_gid);
# 4516 "gzip.c"
  remove_ofname = 0;
# 4518 "gzip.c"
  tmp___4 = xunlink(ifname);
# 4518 "gzip.c"
  if (tmp___4 != 0) {
# 4519 "gzip.c"
    tmp___2 = __errno_location();
# 4519 "gzip.c"
    e___0 = *tmp___2;
# 4520 "gzip.c"
    if (quiet == 0) {
# 4520 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: ", progname);
    } else {

    }
# 4520 "gzip.c"
    if (exit_code == 0) {
# 4520 "gzip.c"
      exit_code = 2;
    } else {

    }
# 4521 "gzip.c"
    if (quiet == 0) {
# 4522 "gzip.c"
      tmp___3 = __errno_location();
# 4522 "gzip.c"
      *tmp___3 = e___0;
# 4523 "gzip.c"
      perror((char const *)(ifname));
    } else {

    }
  } else {

  }
# 4492 "gzip.c"
  return;
}
}
# 4533 "gzip.c"
static void treat_dir(char *dir )
{
  struct dirent *dp ;
  DIR *dirp ;
  char nbuf[1024] ;
  int len ;
  int tmp ;
  int tmp___0 ;
  size_t tmp___1 ;
  int tmp___2 ;
  size_t tmp___3 ;
  int *tmp___4 ;
  int *tmp___5 ;
  int tmp___6 ;

  {
# 4541 "gzip.c"
  dirp = opendir((char const *)dir);
# 4543 "gzip.c"
  if ((unsigned int )dirp == (unsigned int )((void *)0)) {
# 4544 "gzip.c"
    progerror(dir);
# 4545 "gzip.c"
    goto return_label;
  } else {

  }
  {
# 4563 "gzip.c"
  while (1) {
    while_continue: ;
# 4563 "gzip.c"
    tmp___4 = __errno_location();
# 4563 "gzip.c"
    *tmp___4 = 0;
# 4563 "gzip.c"
    dp = readdir(dirp);
# 4563 "gzip.c"
    if ((unsigned int )dp != (unsigned int )((void *)0)) {

    } else {
# 4563 "gzip.c"
      goto while_break;
    }
# 4565 "gzip.c"
    tmp = strcmp((char const *)(dp->d_name), ".");
# 4565 "gzip.c"
    if (tmp == 0) {
# 4566 "gzip.c"
      goto while_continue;
    } else {
# 4565 "gzip.c"
      tmp___0 = strcmp((char const *)(dp->d_name), "..");
# 4565 "gzip.c"
      if (tmp___0 == 0) {
# 4566 "gzip.c"
        goto while_continue;
      } else {

      }
    }
# 4568 "gzip.c"
    tmp___1 = strlen((char const *)dir);
# 4568 "gzip.c"
    len = (int )tmp___1;
# 4569 "gzip.c"
    tmp___3 = strlen((char const *)(dp->d_name));
# 4569 "gzip.c"
    if (((size_t )len + tmp___3) + 1U < 1023U) {
# 4570 "gzip.c"
      strcpy((char * __restrict )(nbuf), (char const * __restrict )dir);
# 4571 "gzip.c"
      if (len != 0) {
# 4579 "gzip.c"
        tmp___2 = len;
# 4579 "gzip.c"
        len ++;
# 4579 "gzip.c"
        nbuf[tmp___2] = (char )'/';
      } else {

      }
# 4581 "gzip.c"
      strcpy((char * __restrict )(nbuf + len), (char const * __restrict )(dp->d_name));
# 4582 "gzip.c"
      treat_file(nbuf);
    } else {
# 4584 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s/%s: pathname too long\n",
              progname, dir, dp->d_name);
# 4586 "gzip.c"
      exit_code = 1;
    }
  }
  while_break: ;
  }
# 4589 "gzip.c"
  tmp___5 = __errno_location();
# 4589 "gzip.c"
  if (*tmp___5 != 0) {
# 4590 "gzip.c"
    progerror(dir);
  } else {

  }
# 4591 "gzip.c"
  tmp___6 = closedir(dirp);
# 4591 "gzip.c"
  if (tmp___6 != 0) {
# 4592 "gzip.c"
    progerror(dir);
  } else {

  }

  return_label:
# 4533 "gzip.c"
  return;
}
}
# 4602 "gzip.c"
static void do_exit(int exitcode ) ;
# 4602 "gzip.c"
static int in_exit = 0;
# 4599 "gzip.c"
static void do_exit(int exitcode )
{


  {
# 4604 "gzip.c"
  if (in_exit != 0) {
# 4604 "gzip.c"
    exit(exitcode);
  } else {

  }
# 4605 "gzip.c"
  in_exit = 1;
# 4606 "gzip.c"
  if ((unsigned int )env != (unsigned int )((void *)0)) {
# 4606 "gzip.c"
    free((void *)env);
# 4606 "gzip.c"
    env = (char *)((void *)0);
  } else {

  }
# 4607 "gzip.c"
  if ((unsigned int )args != (unsigned int )((void *)0)) {
# 4607 "gzip.c"
    free((void *)((char *)args));
# 4607 "gzip.c"
    args = (char **)((void *)0);
  } else {

  }
# 4618 "gzip.c"
  exit(exitcode);
# 4599 "gzip.c"
  return;
}
}
# 4625 "gzip.c"
static void do_remove(void)
{


  {
# 4626 "gzip.c"
  if (remove_ofname != 0) {
# 4627 "gzip.c"
    close(ofd);
# 4628 "gzip.c"
    xunlink(ofname);
  } else {

  }
# 4625 "gzip.c"
  return;
}
}
# 4635 "gzip.c"
void abort_gzip(void)
{


  {
# 4637 "gzip.c"
  do_remove();
# 4638 "gzip.c"
  do_exit(1);
# 4635 "gzip.c"
  return;
}
}
# 4644 "gzip.c"
void abort_gzip_signal(void)
{


  {
# 4646 "gzip.c"
  do_remove();
# 4647 "gzip.c"
  _exit(1);
# 4644 "gzip.c"
  return;
}
}
# 4791 "gzip.c"
int huft_build(unsigned int *b , unsigned int n , unsigned int s , ush *d , ush *e ,
               struct huft **t , int *m ) ;
# 4793 "gzip.c"
int huft_free(struct huft *t ) ;
# 4794 "gzip.c"
int inflate_codes(struct huft *tl , struct huft *td , int bl , int bd ) ;
# 4795 "gzip.c"
int inflate_stored(void) ;
# 4796 "gzip.c"
int inflate_fixed(void) ;
# 4797 "gzip.c"
int inflate_dynamic(void) ;
# 4798 "gzip.c"
int inflate_block(int *e ) ;
# 4815 "gzip.c"
static unsigned int border[19] =
# 4815 "gzip.c"
  { 16U, 17U, 18U, 0U,
        8U, 7U, 9U, 6U,
        10U, 5U, 11U, 4U,
        12U, 3U, 13U, 2U,
        14U, 1U, 15U};
# 4817 "gzip.c"
static ush cplens[31] =
# 4817 "gzip.c"
  { (ush )3, (ush )4, (ush )5, (ush )6,
        (ush )7, (ush )8, (ush )9, (ush )10,
        (ush )11, (ush )13, (ush )15, (ush )17,
        (ush )19, (ush )23, (ush )27, (ush )31,
        (ush )35, (ush )43, (ush )51, (ush )59,
        (ush )67, (ush )83, (ush )99, (ush )115,
        (ush )131, (ush )163, (ush )195, (ush )227,
        (ush )258, (ush )0, (ush )0};
# 4821 "gzip.c"
static ush cplext[31] =
# 4821 "gzip.c"
  { (ush )0, (ush )0, (ush )0, (ush )0,
        (ush )0, (ush )0, (ush )0, (ush )0,
        (ush )1, (ush )1, (ush )1, (ush )1,
        (ush )2, (ush )2, (ush )2, (ush )2,
        (ush )3, (ush )3, (ush )3, (ush )3,
        (ush )4, (ush )4, (ush )4, (ush )4,
        (ush )5, (ush )5, (ush )5, (ush )5,
        (ush )0, (ush )99, (ush )99};
# 4824 "gzip.c"
static ush cpdist[30] =
# 4824 "gzip.c"
  { (ush )1, (ush )2, (ush )3, (ush )4,
        (ush )5, (ush )7, (ush )9, (ush )13,
        (ush )17, (ush )25, (ush )33, (ush )49,
        (ush )65, (ush )97, (ush )129, (ush )193,
        (ush )257, (ush )385, (ush )513, (ush )769,
        (ush )1025, (ush )1537, (ush )2049, (ush )3073,
        (ush )4097, (ush )6145, (ush )8193, (ush )12289,
        (ush )16385, (ush )24577};
# 4828 "gzip.c"
static ush cpdext[30] =
# 4828 "gzip.c"
  { (ush )0, (ush )0, (ush )0, (ush )0,
        (ush )1, (ush )1, (ush )2, (ush )2,
        (ush )3, (ush )3, (ush )4, (ush )4,
        (ush )5, (ush )5, (ush )6, (ush )6,
        (ush )7, (ush )7, (ush )8, (ush )8,
        (ush )9, (ush )9, (ush )10, (ush )10,
        (ush )11, (ush )11, (ush )12, (ush )12,
        (ush )13, (ush )13};
# 4866 "gzip.c"
ulg bb ;
# 4867 "gzip.c"
unsigned int bk ;
# 4869 "gzip.c"
ush mask_bits[17] =
# 4869 "gzip.c"
  { (ush )0, (ush )1, (ush )3, (ush )7,
        (ush )15, (ush )31, (ush )63, (ush )127,
        (ush )255, (ush )511, (ush )1023, (ush )2047,
        (ush )4095, (ush )8191, (ush )16383, (ush )32767,
        (ush )65535};
# 4921 "gzip.c"
int lbits = 9;
# 4922 "gzip.c"
int dbits = 6;
# 4930 "gzip.c"
unsigned int hufts ;
# 4933 "gzip.c"
int huft_build(unsigned int *b , unsigned int n , unsigned int s , ush *d , ush *e ,
               struct huft **t , int *m )
{
  unsigned int a ;
  unsigned int c[17] ;
  unsigned int f ;
  int g ;
  int h ;
  register unsigned int i ;
  register unsigned int j ;
  register int k ;
  int l ;
  register unsigned int *p ;
  register struct huft *q ;
  struct huft r ;
  struct huft *u[16] ;
  unsigned int v[288] ;
  register int w ;
  unsigned int x[17] ;
  unsigned int *xp ;
  int y ;
  unsigned int z ;
  unsigned int *tmp ;
  unsigned int *tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int *tmp___2 ;
  void *tmp___3 ;
  int tmp___4 ;
  unsigned int *tmp___5 ;
  unsigned int tmp___6 ;
  int tmp___7 ;
  struct huft *mem_36 ;
  ush *mem_37 ;
  ush *mem_38 ;
  struct huft *mem_39 ;
  int __retres40 ;

  {
# 4969 "gzip.c"
  memset((voidp )(c), 0, sizeof(c));
# 4970 "gzip.c"
  p = b;
# 4970 "gzip.c"
  i = n;
  {
# 4971 "gzip.c"
  while (1) {
    while_continue: ;
# 4974 "gzip.c"
    (c[*p]) ++;
# 4975 "gzip.c"
    p ++;
# 4971 "gzip.c"
    i --;
# 4971 "gzip.c"
    if (i != 0) {

    } else {
# 4971 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 4977 "gzip.c"
  if (c[0] == n) {
# 4979 "gzip.c"
    *t = (struct huft *)((void *)0);
# 4980 "gzip.c"
    *m = 0;
# 4981 "gzip.c"
    __retres40 = 0;
# 4981 "gzip.c"
    goto return_label;
  } else {

  }
# 4986 "gzip.c"
  l = *m;
# 4987 "gzip.c"
  j = 1U;
  {
# 4987 "gzip.c"
  while (1) {
    while_continue___0: ;
# 4987 "gzip.c"
    if (j <= 16U) {

    } else {
# 4987 "gzip.c"
      goto while_break___0;
    }
# 4988 "gzip.c"
    if (c[j] != 0) {
# 4989 "gzip.c"
      goto while_break___0;
    } else {

    }
# 4987 "gzip.c"
    j ++;
  }
  while_break___0: ;
  }
# 4990 "gzip.c"
  k = (int )j;
# 4991 "gzip.c"
  if ((unsigned int )l < j) {
# 4992 "gzip.c"
    l = (int )j;
  } else {

  }
# 4993 "gzip.c"
  i = 16U;
  {
# 4993 "gzip.c"
  while (1) {
    while_continue___1: ;
# 4993 "gzip.c"
    if (i != 0) {

    } else {
# 4993 "gzip.c"
      goto while_break___1;
    }
# 4994 "gzip.c"
    if (c[i] != 0) {
# 4995 "gzip.c"
      goto while_break___1;
    } else {

    }
# 4993 "gzip.c"
    i --;
  }
  while_break___1: ;
  }
# 4996 "gzip.c"
  g = (int )i;
# 4997 "gzip.c"
  if ((unsigned int )l > i) {
# 4998 "gzip.c"
    l = (int )i;
  } else {

  }
# 4999 "gzip.c"
  *m = l;
# 5003 "gzip.c"
  y = 1 << j;
  {
# 5003 "gzip.c"
  while (1) {
    while_continue___2: ;
# 5003 "gzip.c"
    if (j < i) {

    } else {
# 5003 "gzip.c"
      goto while_break___2;
    }
# 5004 "gzip.c"
    y = (int )((unsigned int )y - c[j]);
# 5004 "gzip.c"
    if (y < 0) {
# 5005 "gzip.c"
      __retres40 = 2;
# 5005 "gzip.c"
      goto return_label;
    } else {

    }
# 5003 "gzip.c"
    j ++;
# 5003 "gzip.c"
    y <<= 1;
  }
  while_break___2: ;
  }
# 5006 "gzip.c"
  y = (int )((unsigned int )y - c[i]);
# 5006 "gzip.c"
  if (y < 0) {
# 5007 "gzip.c"
    __retres40 = 2;
# 5007 "gzip.c"
    goto return_label;
  } else {

  }
# 5008 "gzip.c"
  c[i] += (unsigned int )y;
# 5012 "gzip.c"
  j = 0U;
# 5012 "gzip.c"
  x[1] = j;
# 5013 "gzip.c"
  p = c + 1;
# 5013 "gzip.c"
  xp = x + 2;
  {
# 5014 "gzip.c"
  while (1) {
    while_continue___3: ;
# 5014 "gzip.c"
    i --;
# 5014 "gzip.c"
    if (i != 0) {

    } else {
# 5014 "gzip.c"
      goto while_break___3;
    }
# 5015 "gzip.c"
    tmp = xp;
# 5015 "gzip.c"
    xp ++;
# 5015 "gzip.c"
    tmp___0 = p;
# 5015 "gzip.c"
    p ++;
# 5015 "gzip.c"
    j += *tmp___0;
# 5015 "gzip.c"
    *tmp = j;
  }
  while_break___3: ;
  }
# 5020 "gzip.c"
  p = b;
# 5020 "gzip.c"
  i = 0U;
  {
# 5021 "gzip.c"
  while (1) {
    while_continue___4: ;
# 5022 "gzip.c"
    tmp___2 = p;
# 5022 "gzip.c"
    p ++;
# 5022 "gzip.c"
    j = *tmp___2;
# 5022 "gzip.c"
    if (j != 0U) {
# 5023 "gzip.c"
      tmp___1 = x[j];
# 5023 "gzip.c"
      (x[j]) ++;
# 5023 "gzip.c"
      v[tmp___1] = i;
    } else {

    }
# 5021 "gzip.c"
    i ++;
# 5021 "gzip.c"
    if (i < n) {

    } else {
# 5021 "gzip.c"
      goto while_break___4;
    }
  }
  while_break___4: ;
  }
# 5025 "gzip.c"
  n = x[g];
# 5029 "gzip.c"
  i = 0U;
# 5029 "gzip.c"
  x[0] = i;
# 5030 "gzip.c"
  p = v;
# 5031 "gzip.c"
  h = -1;
# 5032 "gzip.c"
  w = - l;
# 5033 "gzip.c"
  u[0] = (struct huft *)((void *)0);
# 5034 "gzip.c"
  q = (struct huft *)((void *)0);
# 5035 "gzip.c"
  z = 0U;
  {
# 5038 "gzip.c"
  while (1) {
    while_continue___5: ;
# 5038 "gzip.c"
    if (k <= g) {

    } else {
# 5038 "gzip.c"
      goto while_break___5;
    }
# 5040 "gzip.c"
    a = c[k];
    {
# 5041 "gzip.c"
    while (1) {
      while_continue___6: ;
# 5041 "gzip.c"
      tmp___6 = a;
# 5041 "gzip.c"
      a --;
# 5041 "gzip.c"
      if (tmp___6 != 0) {

      } else {
# 5041 "gzip.c"
        goto while_break___6;
      }
      {
# 5045 "gzip.c"
      while (1) {
        while_continue___7: ;
# 5045 "gzip.c"
        if (k > w + l) {

        } else {
# 5045 "gzip.c"
          goto while_break___7;
        }
# 5047 "gzip.c"
        h ++;
# 5048 "gzip.c"
        w += l;
# 5051 "gzip.c"
        z = (unsigned int )(g - w);
# 5051 "gzip.c"
        if (z > (unsigned int )l) {
# 5051 "gzip.c"
          z = (unsigned int )l;
        } else {
# 5051 "gzip.c"
          z = z;
        }
# 5052 "gzip.c"
        j = (unsigned int )(k - w);
# 5052 "gzip.c"
        f = (unsigned int )(1 << j);
# 5052 "gzip.c"
        if (f > a + 1U) {
# 5054 "gzip.c"
          f -= a + 1U;
# 5055 "gzip.c"
          xp = c + k;
# 5056 "gzip.c"
          if (j < z) {
            {
# 5057 "gzip.c"
            while (1) {
              while_continue___8: ;
# 5057 "gzip.c"
              j ++;
# 5057 "gzip.c"
              if (j < z) {

              } else {
# 5057 "gzip.c"
                goto while_break___8;
              }
# 5059 "gzip.c"
              f <<= 1;
# 5059 "gzip.c"
              xp ++;
# 5059 "gzip.c"
              if (f <= *xp) {
# 5060 "gzip.c"
                goto while_break___8;
              } else {

              }
# 5061 "gzip.c"
              f -= *xp;
            }
            while_break___8: ;
            }
          } else {

          }
        } else {

        }
# 5064 "gzip.c"
        z = (unsigned int )(1 << j);
# 5067 "gzip.c"
        tmp___3 = malloc((z + 1U) * sizeof(struct huft ));
# 5067 "gzip.c"
        q = (struct huft *)tmp___3;
# 5067 "gzip.c"
        if ((unsigned int )q == (unsigned int )((struct huft *)((void *)0))) {
# 5070 "gzip.c"
          if (h != 0) {
# 5071 "gzip.c"
            huft_free(u[0]);
          } else {

          }
# 5072 "gzip.c"
          __retres40 = 3;
# 5072 "gzip.c"
          goto return_label;
        } else {

        }
# 5074 "gzip.c"
        hufts += z + 1U;
# 5075 "gzip.c"
        *t = q + 1;
# 5076 "gzip.c"
        t = & q->v.t;
# 5076 "gzip.c"
        *t = (struct huft *)((void *)0);
# 5077 "gzip.c"
        q ++;
# 5077 "gzip.c"
        u[h] = q;
# 5080 "gzip.c"
        if (h != 0) {
# 5082 "gzip.c"
          x[h] = i;
# 5083 "gzip.c"
          r.b = (uch )l;
# 5084 "gzip.c"
          r.e = (uch )(16U + j);
# 5085 "gzip.c"
          r.v.t = q;
# 5086 "gzip.c"
          j = i >> (w - l);
# 5087 "gzip.c"
          mem_36 = u[h - 1] + j;
# 5087 "gzip.c"
          *mem_36 = r;
        } else {

        }
      }
      while_break___7: ;
      }
# 5092 "gzip.c"
      r.b = (uch )(k - w);
# 5093 "gzip.c"
      if ((unsigned int )p >= (unsigned int )(v + n)) {
# 5094 "gzip.c"
        r.e = (uch )99;
      } else
# 5095 "gzip.c"
      if (*p < s) {
# 5097 "gzip.c"
        if (*p < 256U) {
# 5097 "gzip.c"
          tmp___4 = 16;
        } else {
# 5097 "gzip.c"
          tmp___4 = 15;
        }
# 5097 "gzip.c"
        r.e = (uch )tmp___4;
# 5098 "gzip.c"
        r.v.n = (ush )*p;
# 5099 "gzip.c"
        p ++;
      } else {
# 5103 "gzip.c"
        mem_37 = e + (*p - s);
# 5103 "gzip.c"
        r.e = (uch )*mem_37;
# 5104 "gzip.c"
        tmp___5 = p;
# 5104 "gzip.c"
        p ++;
# 5104 "gzip.c"
        mem_38 = d + (*tmp___5 - s);
# 5104 "gzip.c"
        r.v.n = *mem_38;
      }
# 5108 "gzip.c"
      f = (unsigned int )(1 << (k - w));
# 5109 "gzip.c"
      j = i >> w;
      {
# 5109 "gzip.c"
      while (1) {
        while_continue___9: ;
# 5109 "gzip.c"
        if (j < z) {

        } else {
# 5109 "gzip.c"
          goto while_break___9;
        }
# 5110 "gzip.c"
        mem_39 = q + j;
# 5110 "gzip.c"
        *mem_39 = r;
# 5109 "gzip.c"
        j += f;
      }
      while_break___9: ;
      }
# 5113 "gzip.c"
      j = (unsigned int )(1 << (k - 1));
      {
# 5113 "gzip.c"
      while (1) {
        while_continue___10: ;
# 5113 "gzip.c"
        if ((i & j) != 0) {

        } else {
# 5113 "gzip.c"
          goto while_break___10;
        }
# 5114 "gzip.c"
        i ^= j;
# 5113 "gzip.c"
        j >>= 1;
      }
      while_break___10: ;
      }
# 5115 "gzip.c"
      i ^= j;
      {
# 5118 "gzip.c"
      while (1) {
        while_continue___11: ;
# 5118 "gzip.c"
        if ((i & (unsigned int )((1 << w) - 1)) != x[h]) {

        } else {
# 5118 "gzip.c"
          goto while_break___11;
        }
# 5120 "gzip.c"
        h --;
# 5121 "gzip.c"
        w -= l;
      }
      while_break___11: ;
      }
    }
    while_break___6: ;
    }
# 5038 "gzip.c"
    k ++;
  }
  while_break___5: ;
  }
# 5128 "gzip.c"
  if (y != 0) {
# 5128 "gzip.c"
    if (g != 1) {
# 5128 "gzip.c"
      tmp___7 = 1;
    } else {
# 5128 "gzip.c"
      tmp___7 = 0;
    }
  } else {
# 5128 "gzip.c"
    tmp___7 = 0;
  }
# 5128 "gzip.c"
  __retres40 = tmp___7;
  return_label:
# 4933 "gzip.c"
  return (__retres40);
}
}
# 5133 "gzip.c"
int huft_free(struct huft *t )
{
  register struct huft *p ;
  register struct huft *q ;
  int __retres4 ;

  {
# 5143 "gzip.c"
  p = t;
  {
# 5144 "gzip.c"
  while (1) {
    while_continue: ;
# 5144 "gzip.c"
    if ((unsigned int )p != (unsigned int )((struct huft *)((void *)0))) {

    } else {
# 5144 "gzip.c"
      goto while_break;
    }
# 5146 "gzip.c"
    p --;
# 5146 "gzip.c"
    q = p->v.t;
# 5147 "gzip.c"
    free((void *)((char *)p));
# 5148 "gzip.c"
    p = q;
  }
  while_break: ;
  }
# 5150 "gzip.c"
  __retres4 = 0;
# 5133 "gzip.c"
  return (__retres4);
}
}
# 5154 "gzip.c"
int inflate_codes(struct huft *tl , struct huft *td , int bl , int bd )
{
  register unsigned int e ;
  unsigned int n ;
  unsigned int d ;
  unsigned int w ;
  struct huft *t ;
  unsigned int ml ;
  unsigned int md ;
  register ulg b ;
  register unsigned int k ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  unsigned int tmp___5 ;
  unsigned int tmp___6 ;
  int tmp___7 ;
  int tmp___8 ;
  unsigned int tmp___9 ;
  int tmp___10 ;
  int tmp___11 ;
  unsigned int tmp___12 ;
  int tmp___13 ;
  int tmp___14 ;
  unsigned int tmp___15 ;
  int tmp___16 ;
  int tmp___17 ;
  unsigned int tmp___19 ;
  unsigned int tmp___20 ;
  unsigned int tmp___21 ;
  int __retres37 ;

  {
# 5170 "gzip.c"
  b = bb;
# 5171 "gzip.c"
  k = bk;
# 5172 "gzip.c"
  w = outcnt;
# 5175 "gzip.c"
  ml = (unsigned int )mask_bits[bl];
# 5176 "gzip.c"
  md = (unsigned int )mask_bits[bd];
  {
# 5177 "gzip.c"
  while (1) {
    while_continue: ;
    {
# 5179 "gzip.c"
    while (1) {
      while_continue___0: ;
# 5179 "gzip.c"
      if (k < (unsigned int )bl) {

      } else {
# 5179 "gzip.c"
        goto while_break___0;
      }
# 5179 "gzip.c"
      if (inptr < insize) {
# 5179 "gzip.c"
        tmp = inptr;
# 5179 "gzip.c"
        inptr ++;
# 5179 "gzip.c"
        tmp___1 = (int )inbuf[tmp];
      } else {
# 5179 "gzip.c"
        outcnt = w;
# 5179 "gzip.c"
        tmp___0 = fill_inbuf(0);
# 5179 "gzip.c"
        tmp___1 = tmp___0;
      }
# 5179 "gzip.c"
      b |= (ulg )((uch )tmp___1) << k;
# 5179 "gzip.c"
      k += 8U;
    }
    while_break___0: ;
    }
# 5180 "gzip.c"
    t = tl + ((unsigned int )b & ml);
# 5180 "gzip.c"
    e = (unsigned int )t->e;
# 5180 "gzip.c"
    if (e > 16U) {
      {
# 5181 "gzip.c"
      while (1) {
        while_continue___1: ;
# 5182 "gzip.c"
        if (e == 99U) {
# 5183 "gzip.c"
          __retres37 = 1;
# 5183 "gzip.c"
          goto return_label;
        } else {

        }
# 5184 "gzip.c"
        b >>= (int )t->b;
# 5184 "gzip.c"
        k -= (unsigned int )t->b;
# 5185 "gzip.c"
        e -= 16U;
        {
# 5186 "gzip.c"
        while (1) {
          while_continue___2: ;
# 5186 "gzip.c"
          if (k < e) {

          } else {
# 5186 "gzip.c"
            goto while_break___2;
          }
# 5186 "gzip.c"
          if (inptr < insize) {
# 5186 "gzip.c"
            tmp___2 = inptr;
# 5186 "gzip.c"
            inptr ++;
# 5186 "gzip.c"
            tmp___4 = (int )inbuf[tmp___2];
          } else {
# 5186 "gzip.c"
            outcnt = w;
# 5186 "gzip.c"
            tmp___3 = fill_inbuf(0);
# 5186 "gzip.c"
            tmp___4 = tmp___3;
          }
# 5186 "gzip.c"
          b |= (ulg )((uch )tmp___4) << k;
# 5186 "gzip.c"
          k += 8U;
        }
        while_break___2: ;
        }
# 5181 "gzip.c"
        t = t->v.t + ((unsigned int )b & (unsigned int )mask_bits[e]);
# 5181 "gzip.c"
        e = (unsigned int )t->e;
# 5181 "gzip.c"
        if (e > 16U) {

        } else {
# 5181 "gzip.c"
          goto while_break___1;
        }
      }
      while_break___1: ;
      }
    } else {

    }
# 5188 "gzip.c"
    b >>= (int )t->b;
# 5188 "gzip.c"
    k -= (unsigned int )t->b;
# 5189 "gzip.c"
    if (e == 16U) {
# 5191 "gzip.c"
      tmp___5 = w;
# 5191 "gzip.c"
      w ++;
# 5191 "gzip.c"
      window[tmp___5] = (uch )t->v.n;
# 5193 "gzip.c"
      if (w == 32768U) {
# 5195 "gzip.c"
        outcnt = w;
# 5195 "gzip.c"
        flush_window();
# 5196 "gzip.c"
        w = 0U;
      } else {

      }
    } else {
# 5202 "gzip.c"
      if (e == 15U) {
# 5203 "gzip.c"
        goto while_break;
      } else {

      }
      {
# 5206 "gzip.c"
      while (1) {
        while_continue___3: ;
# 5206 "gzip.c"
        if (k < e) {

        } else {
# 5206 "gzip.c"
          goto while_break___3;
        }
# 5206 "gzip.c"
        if (inptr < insize) {
# 5206 "gzip.c"
          tmp___6 = inptr;
# 5206 "gzip.c"
          inptr ++;
# 5206 "gzip.c"
          tmp___8 = (int )inbuf[tmp___6];
        } else {
# 5206 "gzip.c"
          outcnt = w;
# 5206 "gzip.c"
          tmp___7 = fill_inbuf(0);
# 5206 "gzip.c"
          tmp___8 = tmp___7;
        }
# 5206 "gzip.c"
        b |= (ulg )((uch )tmp___8) << k;
# 5206 "gzip.c"
        k += 8U;
      }
      while_break___3: ;
      }
# 5207 "gzip.c"
      n = (unsigned int )t->v.n + ((unsigned int )b & (unsigned int )mask_bits[e]);
# 5208 "gzip.c"
      b >>= e;
# 5208 "gzip.c"
      k -= e;
      {
# 5211 "gzip.c"
      while (1) {
        while_continue___4: ;
# 5211 "gzip.c"
        if (k < (unsigned int )bd) {

        } else {
# 5211 "gzip.c"
          goto while_break___4;
        }
# 5211 "gzip.c"
        if (inptr < insize) {
# 5211 "gzip.c"
          tmp___9 = inptr;
# 5211 "gzip.c"
          inptr ++;
# 5211 "gzip.c"
          tmp___11 = (int )inbuf[tmp___9];
        } else {
# 5211 "gzip.c"
          outcnt = w;
# 5211 "gzip.c"
          tmp___10 = fill_inbuf(0);
# 5211 "gzip.c"
          tmp___11 = tmp___10;
        }
# 5211 "gzip.c"
        b |= (ulg )((uch )tmp___11) << k;
# 5211 "gzip.c"
        k += 8U;
      }
      while_break___4: ;
      }
# 5212 "gzip.c"
      t = td + ((unsigned int )b & md);
# 5212 "gzip.c"
      e = (unsigned int )t->e;
# 5212 "gzip.c"
      if (e > 16U) {
        {
# 5213 "gzip.c"
        while (1) {
          while_continue___5: ;
# 5214 "gzip.c"
          if (e == 99U) {
# 5215 "gzip.c"
            __retres37 = 1;
# 5215 "gzip.c"
            goto return_label;
          } else {

          }
# 5216 "gzip.c"
          b >>= (int )t->b;
# 5216 "gzip.c"
          k -= (unsigned int )t->b;
# 5217 "gzip.c"
          e -= 16U;
          {
# 5218 "gzip.c"
          while (1) {
            while_continue___6: ;
# 5218 "gzip.c"
            if (k < e) {

            } else {
# 5218 "gzip.c"
              goto while_break___6;
            }
# 5218 "gzip.c"
            if (inptr < insize) {
# 5218 "gzip.c"
              tmp___12 = inptr;
# 5218 "gzip.c"
              inptr ++;
# 5218 "gzip.c"
              tmp___14 = (int )inbuf[tmp___12];
            } else {
# 5218 "gzip.c"
              outcnt = w;
# 5218 "gzip.c"
              tmp___13 = fill_inbuf(0);
# 5218 "gzip.c"
              tmp___14 = tmp___13;
            }
# 5218 "gzip.c"
            b |= (ulg )((uch )tmp___14) << k;
# 5218 "gzip.c"
            k += 8U;
          }
          while_break___6: ;
          }
# 5213 "gzip.c"
          t = t->v.t + ((unsigned int )b & (unsigned int )mask_bits[e]);
# 5213 "gzip.c"
          e = (unsigned int )t->e;
# 5213 "gzip.c"
          if (e > 16U) {

          } else {
# 5213 "gzip.c"
            goto while_break___5;
          }
        }
        while_break___5: ;
        }
      } else {

      }
# 5220 "gzip.c"
      b >>= (int )t->b;
# 5220 "gzip.c"
      k -= (unsigned int )t->b;
      {
# 5221 "gzip.c"
      while (1) {
        while_continue___7: ;
# 5221 "gzip.c"
        if (k < e) {

        } else {
# 5221 "gzip.c"
          goto while_break___7;
        }
# 5221 "gzip.c"
        if (inptr < insize) {
# 5221 "gzip.c"
          tmp___15 = inptr;
# 5221 "gzip.c"
          inptr ++;
# 5221 "gzip.c"
          tmp___17 = (int )inbuf[tmp___15];
        } else {
# 5221 "gzip.c"
          outcnt = w;
# 5221 "gzip.c"
          tmp___16 = fill_inbuf(0);
# 5221 "gzip.c"
          tmp___17 = tmp___16;
        }
# 5221 "gzip.c"
        b |= (ulg )((uch )tmp___17) << k;
# 5221 "gzip.c"
        k += 8U;
      }
      while_break___7: ;
      }
# 5222 "gzip.c"
      d = (w - (unsigned int )t->v.n) - ((unsigned int )b & (unsigned int )mask_bits[e]);
# 5223 "gzip.c"
      b >>= e;
# 5223 "gzip.c"
      k -= e;
      {
# 5227 "gzip.c"
      while (1) {
        while_continue___8: ;
# 5228 "gzip.c"
        d &= 32767U;
# 5228 "gzip.c"
        if (d > w) {
# 5228 "gzip.c"
          tmp___19 = d;
        } else {
# 5228 "gzip.c"
          tmp___19 = w;
        }
# 5228 "gzip.c"
        e = 32768U - tmp___19;
# 5228 "gzip.c"
        if (e > n) {
# 5228 "gzip.c"
          e = n;
        } else {
# 5228 "gzip.c"
          e = e;
        }
# 5228 "gzip.c"
        n -= e;
# 5230 "gzip.c"
        if (w - d >= e) {
# 5232 "gzip.c"
          memcpy((void * __restrict )(window + w), (void const * __restrict )(window + d),
                 e);
# 5233 "gzip.c"
          w += e;
# 5234 "gzip.c"
          d += e;
        } else {
          {
# 5238 "gzip.c"
          while (1) {
            while_continue___9: ;
# 5239 "gzip.c"
            tmp___20 = w;
# 5239 "gzip.c"
            w ++;
# 5239 "gzip.c"
            tmp___21 = d;
# 5239 "gzip.c"
            d ++;
# 5239 "gzip.c"
            window[tmp___20] = window[tmp___21];
# 5238 "gzip.c"
            e --;
# 5238 "gzip.c"
            if (e != 0) {

            } else {
# 5238 "gzip.c"
              goto while_break___9;
            }
          }
          while_break___9: ;
          }
        }
# 5242 "gzip.c"
        if (w == 32768U) {
# 5244 "gzip.c"
          outcnt = w;
# 5244 "gzip.c"
          flush_window();
# 5245 "gzip.c"
          w = 0U;
        } else {

        }
# 5227 "gzip.c"
        if (n != 0) {

        } else {
# 5227 "gzip.c"
          goto while_break___8;
        }
      }
      while_break___8: ;
      }
    }
  }
  while_break: ;
  }
# 5253 "gzip.c"
  outcnt = w;
# 5254 "gzip.c"
  bb = b;
# 5255 "gzip.c"
  bk = k;
# 5258 "gzip.c"
  __retres37 = 0;
  return_label:
# 5154 "gzip.c"
  return (__retres37);
}
}
# 5263 "gzip.c"
int inflate_stored(void)
{
  unsigned int n ;
  unsigned int w ;
  register ulg b ;
  register unsigned int k ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  unsigned int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;
  unsigned int tmp___8 ;
  unsigned int tmp___9 ;
  int __retres16 ;

  {
# 5273 "gzip.c"
  b = bb;
# 5274 "gzip.c"
  k = bk;
# 5275 "gzip.c"
  w = outcnt;
# 5279 "gzip.c"
  n = k & 7U;
# 5280 "gzip.c"
  b >>= n;
# 5280 "gzip.c"
  k -= n;
  {
# 5284 "gzip.c"
  while (1) {
    while_continue: ;
# 5284 "gzip.c"
    if (k < 16U) {

    } else {
# 5284 "gzip.c"
      goto while_break;
    }
# 5284 "gzip.c"
    if (inptr < insize) {
# 5284 "gzip.c"
      tmp = inptr;
# 5284 "gzip.c"
      inptr ++;
# 5284 "gzip.c"
      tmp___1 = (int )inbuf[tmp];
    } else {
# 5284 "gzip.c"
      outcnt = w;
# 5284 "gzip.c"
      tmp___0 = fill_inbuf(0);
# 5284 "gzip.c"
      tmp___1 = tmp___0;
    }
# 5284 "gzip.c"
    b |= (ulg )((uch )tmp___1) << k;
# 5284 "gzip.c"
    k += 8U;
  }
  while_break: ;
  }
# 5285 "gzip.c"
  n = (unsigned int )b & 65535U;
# 5286 "gzip.c"
  b >>= 16;
# 5286 "gzip.c"
  k -= 16U;
  {
# 5287 "gzip.c"
  while (1) {
    while_continue___0: ;
# 5287 "gzip.c"
    if (k < 16U) {

    } else {
# 5287 "gzip.c"
      goto while_break___0;
    }
# 5287 "gzip.c"
    if (inptr < insize) {
# 5287 "gzip.c"
      tmp___2 = inptr;
# 5287 "gzip.c"
      inptr ++;
# 5287 "gzip.c"
      tmp___4 = (int )inbuf[tmp___2];
    } else {
# 5287 "gzip.c"
      outcnt = w;
# 5287 "gzip.c"
      tmp___3 = fill_inbuf(0);
# 5287 "gzip.c"
      tmp___4 = tmp___3;
    }
# 5287 "gzip.c"
    b |= (ulg )((uch )tmp___4) << k;
# 5287 "gzip.c"
    k += 8U;
  }
  while_break___0: ;
  }
# 5288 "gzip.c"
  if (n != (unsigned int )(~ b & 65535UL)) {
# 5289 "gzip.c"
    __retres16 = 1;
# 5289 "gzip.c"
    goto return_label;
  } else {

  }
# 5290 "gzip.c"
  b >>= 16;
# 5290 "gzip.c"
  k -= 16U;
  {
# 5294 "gzip.c"
  while (1) {
    while_continue___1: ;
# 5294 "gzip.c"
    tmp___9 = n;
# 5294 "gzip.c"
    n --;
# 5294 "gzip.c"
    if (tmp___9 != 0) {

    } else {
# 5294 "gzip.c"
      goto while_break___1;
    }
    {
# 5296 "gzip.c"
    while (1) {
      while_continue___2: ;
# 5296 "gzip.c"
      if (k < 8U) {

      } else {
# 5296 "gzip.c"
        goto while_break___2;
      }
# 5296 "gzip.c"
      if (inptr < insize) {
# 5296 "gzip.c"
        tmp___5 = inptr;
# 5296 "gzip.c"
        inptr ++;
# 5296 "gzip.c"
        tmp___7 = (int )inbuf[tmp___5];
      } else {
# 5296 "gzip.c"
        outcnt = w;
# 5296 "gzip.c"
        tmp___6 = fill_inbuf(0);
# 5296 "gzip.c"
        tmp___7 = tmp___6;
      }
# 5296 "gzip.c"
      b |= (ulg )((uch )tmp___7) << k;
# 5296 "gzip.c"
      k += 8U;
    }
    while_break___2: ;
    }
# 5297 "gzip.c"
    tmp___8 = w;
# 5297 "gzip.c"
    w ++;
# 5297 "gzip.c"
    window[tmp___8] = (uch )b;
# 5298 "gzip.c"
    if (w == 32768U) {
# 5300 "gzip.c"
      outcnt = w;
# 5300 "gzip.c"
      flush_window();
# 5301 "gzip.c"
      w = 0U;
    } else {

    }
# 5303 "gzip.c"
    b >>= 8;
# 5303 "gzip.c"
    k -= 8U;
  }
  while_break___1: ;
  }
# 5308 "gzip.c"
  outcnt = w;
# 5309 "gzip.c"
  bb = b;
# 5310 "gzip.c"
  bk = k;
# 5311 "gzip.c"
  __retres16 = 0;
  return_label:
# 5263 "gzip.c"
  return (__retres16);
}
}
# 5316 "gzip.c"
int inflate_fixed(void)
{
  int i ;
  struct huft *tl ;
  struct huft *td ;
  int bl ;
  int bd ;
  unsigned int l[288] ;
  int tmp ;
  int __retres8 ;

  {
# 5330 "gzip.c"
  i = 0;
  {
# 5330 "gzip.c"
  while (1) {
    while_continue: ;
# 5330 "gzip.c"
    if (i < 144) {

    } else {
# 5330 "gzip.c"
      goto while_break;
    }
# 5331 "gzip.c"
    l[i] = 8U;
# 5330 "gzip.c"
    i ++;
  }
  while_break: ;
  }
  {
# 5332 "gzip.c"
  while (1) {
    while_continue___0: ;
# 5332 "gzip.c"
    if (i < 256) {

    } else {
# 5332 "gzip.c"
      goto while_break___0;
    }
# 5333 "gzip.c"
    l[i] = 9U;
# 5332 "gzip.c"
    i ++;
  }
  while_break___0: ;
  }
  {
# 5334 "gzip.c"
  while (1) {
    while_continue___1: ;
# 5334 "gzip.c"
    if (i < 280) {

    } else {
# 5334 "gzip.c"
      goto while_break___1;
    }
# 5335 "gzip.c"
    l[i] = 7U;
# 5334 "gzip.c"
    i ++;
  }
  while_break___1: ;
  }
  {
# 5336 "gzip.c"
  while (1) {
    while_continue___2: ;
# 5336 "gzip.c"
    if (i < 288) {

    } else {
# 5336 "gzip.c"
      goto while_break___2;
    }
# 5337 "gzip.c"
    l[i] = 8U;
# 5336 "gzip.c"
    i ++;
  }
  while_break___2: ;
  }
# 5338 "gzip.c"
  bl = 7;
# 5339 "gzip.c"
  i = huft_build(l, 288U, 257U, cplens, cplext, & tl, & bl);
# 5339 "gzip.c"
  if (i != 0) {
# 5340 "gzip.c"
    __retres8 = i;
# 5340 "gzip.c"
    goto return_label;
  } else {

  }
# 5344 "gzip.c"
  i = 0;
  {
# 5344 "gzip.c"
  while (1) {
    while_continue___3: ;
# 5344 "gzip.c"
    if (i < 30) {

    } else {
# 5344 "gzip.c"
      goto while_break___3;
    }
# 5345 "gzip.c"
    l[i] = 5U;
# 5344 "gzip.c"
    i ++;
  }
  while_break___3: ;
  }
# 5346 "gzip.c"
  bd = 5;
# 5347 "gzip.c"
  i = huft_build(l, 30U, 0U, cpdist, cpdext, & td, & bd);
# 5347 "gzip.c"
  if (i > 1) {
# 5349 "gzip.c"
    huft_free(tl);
# 5350 "gzip.c"
    __retres8 = i;
# 5350 "gzip.c"
    goto return_label;
  } else {

  }
# 5355 "gzip.c"
  tmp = inflate_codes(tl, td, bl, bd);
# 5355 "gzip.c"
  if (tmp != 0) {
# 5356 "gzip.c"
    __retres8 = 1;
# 5356 "gzip.c"
    goto return_label;
  } else {

  }
# 5360 "gzip.c"
  huft_free(tl);
# 5361 "gzip.c"
  huft_free(td);
# 5362 "gzip.c"
  __retres8 = 0;
  return_label:
# 5316 "gzip.c"
  return (__retres8);
}
}
# 5367 "gzip.c"
int inflate_dynamic(void)
{
  int i ;
  unsigned int j ;
  unsigned int l ;
  unsigned int m ;
  unsigned int n ;
  unsigned int w ;
  struct huft *tl ;
  struct huft *td ;
  int bl ;
  int bd ;
  unsigned int nb ;
  unsigned int nl ;
  unsigned int nd ;
  unsigned int ll[316] ;
  register ulg b ;
  register unsigned int k ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  unsigned int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;
  unsigned int tmp___8 ;
  int tmp___9 ;
  int tmp___10 ;
  unsigned int tmp___11 ;
  int tmp___12 ;
  int tmp___13 ;
  int tmp___14 ;
  unsigned int tmp___15 ;
  int tmp___16 ;
  int tmp___17 ;
  int tmp___18 ;
  unsigned int tmp___19 ;
  unsigned int tmp___20 ;
  int tmp___21 ;
  int tmp___22 ;
  int tmp___23 ;
  unsigned int tmp___24 ;
  unsigned int tmp___25 ;
  int tmp___26 ;
  int tmp___27 ;
  int tmp___28 ;
  unsigned int tmp___29 ;
  int tmp___30 ;
  int __retres49 ;

  {
# 5393 "gzip.c"
  b = bb;
# 5394 "gzip.c"
  k = bk;
# 5395 "gzip.c"
  w = outcnt;
  {
# 5399 "gzip.c"
  while (1) {
    while_continue: ;
# 5399 "gzip.c"
    if (k < 5U) {

    } else {
# 5399 "gzip.c"
      goto while_break;
    }
# 5399 "gzip.c"
    if (inptr < insize) {
# 5399 "gzip.c"
      tmp = inptr;
# 5399 "gzip.c"
      inptr ++;
# 5399 "gzip.c"
      tmp___1 = (int )inbuf[tmp];
    } else {
# 5399 "gzip.c"
      outcnt = w;
# 5399 "gzip.c"
      tmp___0 = fill_inbuf(0);
# 5399 "gzip.c"
      tmp___1 = tmp___0;
    }
# 5399 "gzip.c"
    b |= (ulg )((uch )tmp___1) << k;
# 5399 "gzip.c"
    k += 8U;
  }
  while_break: ;
  }
# 5400 "gzip.c"
  nl = 257U + ((unsigned int )b & 31U);
# 5401 "gzip.c"
  b >>= 5;
# 5401 "gzip.c"
  k -= 5U;
  {
# 5402 "gzip.c"
  while (1) {
    while_continue___0: ;
# 5402 "gzip.c"
    if (k < 5U) {

    } else {
# 5402 "gzip.c"
      goto while_break___0;
    }
# 5402 "gzip.c"
    if (inptr < insize) {
# 5402 "gzip.c"
      tmp___2 = inptr;
# 5402 "gzip.c"
      inptr ++;
# 5402 "gzip.c"
      tmp___4 = (int )inbuf[tmp___2];
    } else {
# 5402 "gzip.c"
      outcnt = w;
# 5402 "gzip.c"
      tmp___3 = fill_inbuf(0);
# 5402 "gzip.c"
      tmp___4 = tmp___3;
    }
# 5402 "gzip.c"
    b |= (ulg )((uch )tmp___4) << k;
# 5402 "gzip.c"
    k += 8U;
  }
  while_break___0: ;
  }
# 5403 "gzip.c"
  nd = 1U + ((unsigned int )b & 31U);
# 5404 "gzip.c"
  b >>= 5;
# 5404 "gzip.c"
  k -= 5U;
  {
# 5405 "gzip.c"
  while (1) {
    while_continue___1: ;
# 5405 "gzip.c"
    if (k < 4U) {

    } else {
# 5405 "gzip.c"
      goto while_break___1;
    }
# 5405 "gzip.c"
    if (inptr < insize) {
# 5405 "gzip.c"
      tmp___5 = inptr;
# 5405 "gzip.c"
      inptr ++;
# 5405 "gzip.c"
      tmp___7 = (int )inbuf[tmp___5];
    } else {
# 5405 "gzip.c"
      outcnt = w;
# 5405 "gzip.c"
      tmp___6 = fill_inbuf(0);
# 5405 "gzip.c"
      tmp___7 = tmp___6;
    }
# 5405 "gzip.c"
    b |= (ulg )((uch )tmp___7) << k;
# 5405 "gzip.c"
    k += 8U;
  }
  while_break___1: ;
  }
# 5406 "gzip.c"
  nb = 4U + ((unsigned int )b & 15U);
# 5407 "gzip.c"
  b >>= 4;
# 5407 "gzip.c"
  k -= 4U;
# 5411 "gzip.c"
  if (nl > 286U) {
# 5413 "gzip.c"
    __retres49 = 1;
# 5413 "gzip.c"
    goto return_label;
  } else
# 5411 "gzip.c"
  if (nd > 30U) {
# 5413 "gzip.c"
    __retres49 = 1;
# 5413 "gzip.c"
    goto return_label;
  } else {

  }
# 5417 "gzip.c"
  j = 0U;
  {
# 5417 "gzip.c"
  while (1) {
    while_continue___2: ;
# 5417 "gzip.c"
    if (j < nb) {

    } else {
# 5417 "gzip.c"
      goto while_break___2;
    }
    {
# 5419 "gzip.c"
    while (1) {
      while_continue___3: ;
# 5419 "gzip.c"
      if (k < 3U) {

      } else {
# 5419 "gzip.c"
        goto while_break___3;
      }
# 5419 "gzip.c"
      if (inptr < insize) {
# 5419 "gzip.c"
        tmp___8 = inptr;
# 5419 "gzip.c"
        inptr ++;
# 5419 "gzip.c"
        tmp___10 = (int )inbuf[tmp___8];
      } else {
# 5419 "gzip.c"
        outcnt = w;
# 5419 "gzip.c"
        tmp___9 = fill_inbuf(0);
# 5419 "gzip.c"
        tmp___10 = tmp___9;
      }
# 5419 "gzip.c"
      b |= (ulg )((uch )tmp___10) << k;
# 5419 "gzip.c"
      k += 8U;
    }
    while_break___3: ;
    }
# 5420 "gzip.c"
    ll[border[j]] = (unsigned int )b & 7U;
# 5421 "gzip.c"
    b >>= 3;
# 5421 "gzip.c"
    k -= 3U;
# 5417 "gzip.c"
    j ++;
  }
  while_break___2: ;
  }
  {
# 5423 "gzip.c"
  while (1) {
    while_continue___4: ;
# 5423 "gzip.c"
    if (j < 19U) {

    } else {
# 5423 "gzip.c"
      goto while_break___4;
    }
# 5424 "gzip.c"
    ll[border[j]] = 0U;
# 5423 "gzip.c"
    j ++;
  }
  while_break___4: ;
  }
# 5428 "gzip.c"
  bl = 7;
# 5429 "gzip.c"
  i = huft_build(ll, 19U, 19U, (ush *)((void *)0), (ush *)((void *)0), & tl, & bl);
# 5429 "gzip.c"
  if (i != 0) {
# 5431 "gzip.c"
    if (i == 1) {
# 5432 "gzip.c"
      huft_free(tl);
    } else {

    }
# 5433 "gzip.c"
    __retres49 = i;
# 5433 "gzip.c"
    goto return_label;
  } else {

  }
# 5436 "gzip.c"
  if ((unsigned int )tl == (unsigned int )((void *)0)) {
# 5437 "gzip.c"
    __retres49 = 2;
# 5437 "gzip.c"
    goto return_label;
  } else {

  }
# 5440 "gzip.c"
  n = nl + nd;
# 5441 "gzip.c"
  m = (unsigned int )mask_bits[bl];
# 5442 "gzip.c"
  l = 0U;
# 5442 "gzip.c"
  i = (int )l;
  {
# 5443 "gzip.c"
  while (1) {
    while_continue___5: ;
# 5443 "gzip.c"
    if ((unsigned int )i < n) {

    } else {
# 5443 "gzip.c"
      goto while_break___5;
    }
    {
# 5445 "gzip.c"
    while (1) {
      while_continue___6: ;
# 5445 "gzip.c"
      if (k < (unsigned int )bl) {

      } else {
# 5445 "gzip.c"
        goto while_break___6;
      }
# 5445 "gzip.c"
      if (inptr < insize) {
# 5445 "gzip.c"
        tmp___11 = inptr;
# 5445 "gzip.c"
        inptr ++;
# 5445 "gzip.c"
        tmp___13 = (int )inbuf[tmp___11];
      } else {
# 5445 "gzip.c"
        outcnt = w;
# 5445 "gzip.c"
        tmp___12 = fill_inbuf(0);
# 5445 "gzip.c"
        tmp___13 = tmp___12;
      }
# 5445 "gzip.c"
      b |= (ulg )((uch )tmp___13) << k;
# 5445 "gzip.c"
      k += 8U;
    }
    while_break___6: ;
    }
# 5446 "gzip.c"
    td = tl + ((unsigned int )b & m);
# 5446 "gzip.c"
    j = (unsigned int )td->b;
# 5447 "gzip.c"
    b >>= j;
# 5447 "gzip.c"
    k -= j;
# 5448 "gzip.c"
    j = (unsigned int )td->v.n;
# 5449 "gzip.c"
    if (j < 16U) {
# 5450 "gzip.c"
      tmp___14 = i;
# 5450 "gzip.c"
      i ++;
# 5450 "gzip.c"
      l = j;
# 5450 "gzip.c"
      ll[tmp___14] = l;
    } else
# 5451 "gzip.c"
    if (j == 16U) {
      {
# 5453 "gzip.c"
      while (1) {
        while_continue___7: ;
# 5453 "gzip.c"
        if (k < 2U) {

        } else {
# 5453 "gzip.c"
          goto while_break___7;
        }
# 5453 "gzip.c"
        if (inptr < insize) {
# 5453 "gzip.c"
          tmp___15 = inptr;
# 5453 "gzip.c"
          inptr ++;
# 5453 "gzip.c"
          tmp___17 = (int )inbuf[tmp___15];
        } else {
# 5453 "gzip.c"
          outcnt = w;
# 5453 "gzip.c"
          tmp___16 = fill_inbuf(0);
# 5453 "gzip.c"
          tmp___17 = tmp___16;
        }
# 5453 "gzip.c"
        b |= (ulg )((uch )tmp___17) << k;
# 5453 "gzip.c"
        k += 8U;
      }
      while_break___7: ;
      }
# 5454 "gzip.c"
      j = 3U + ((unsigned int )b & 3U);
# 5455 "gzip.c"
      b >>= 2;
# 5455 "gzip.c"
      k -= 2U;
# 5456 "gzip.c"
      if ((unsigned int )i + j > n) {
# 5457 "gzip.c"
        __retres49 = 1;
# 5457 "gzip.c"
        goto return_label;
      } else {

      }
      {
# 5458 "gzip.c"
      while (1) {
        while_continue___8: ;
# 5458 "gzip.c"
        tmp___19 = j;
# 5458 "gzip.c"
        j --;
# 5458 "gzip.c"
        if (tmp___19 != 0) {

        } else {
# 5458 "gzip.c"
          goto while_break___8;
        }
# 5459 "gzip.c"
        tmp___18 = i;
# 5459 "gzip.c"
        i ++;
# 5459 "gzip.c"
        ll[tmp___18] = l;
      }
      while_break___8: ;
      }
    } else
# 5461 "gzip.c"
    if (j == 17U) {
      {
# 5463 "gzip.c"
      while (1) {
        while_continue___9: ;
# 5463 "gzip.c"
        if (k < 3U) {

        } else {
# 5463 "gzip.c"
          goto while_break___9;
        }
# 5463 "gzip.c"
        if (inptr < insize) {
# 5463 "gzip.c"
          tmp___20 = inptr;
# 5463 "gzip.c"
          inptr ++;
# 5463 "gzip.c"
          tmp___22 = (int )inbuf[tmp___20];
        } else {
# 5463 "gzip.c"
          outcnt = w;
# 5463 "gzip.c"
          tmp___21 = fill_inbuf(0);
# 5463 "gzip.c"
          tmp___22 = tmp___21;
        }
# 5463 "gzip.c"
        b |= (ulg )((uch )tmp___22) << k;
# 5463 "gzip.c"
        k += 8U;
      }
      while_break___9: ;
      }
# 5464 "gzip.c"
      j = 3U + ((unsigned int )b & 7U);
# 5465 "gzip.c"
      b >>= 3;
# 5465 "gzip.c"
      k -= 3U;
# 5466 "gzip.c"
      if ((unsigned int )i + j > n) {
# 5467 "gzip.c"
        __retres49 = 1;
# 5467 "gzip.c"
        goto return_label;
      } else {

      }
      {
# 5468 "gzip.c"
      while (1) {
        while_continue___10: ;
# 5468 "gzip.c"
        tmp___24 = j;
# 5468 "gzip.c"
        j --;
# 5468 "gzip.c"
        if (tmp___24 != 0) {

        } else {
# 5468 "gzip.c"
          goto while_break___10;
        }
# 5469 "gzip.c"
        tmp___23 = i;
# 5469 "gzip.c"
        i ++;
# 5469 "gzip.c"
        ll[tmp___23] = 0U;
      }
      while_break___10: ;
      }
# 5470 "gzip.c"
      l = 0U;
    } else {
      {
# 5474 "gzip.c"
      while (1) {
        while_continue___11: ;
# 5474 "gzip.c"
        if (k < 7U) {

        } else {
# 5474 "gzip.c"
          goto while_break___11;
        }
# 5474 "gzip.c"
        if (inptr < insize) {
# 5474 "gzip.c"
          tmp___25 = inptr;
# 5474 "gzip.c"
          inptr ++;
# 5474 "gzip.c"
          tmp___27 = (int )inbuf[tmp___25];
        } else {
# 5474 "gzip.c"
          outcnt = w;
# 5474 "gzip.c"
          tmp___26 = fill_inbuf(0);
# 5474 "gzip.c"
          tmp___27 = tmp___26;
        }
# 5474 "gzip.c"
        b |= (ulg )((uch )tmp___27) << k;
# 5474 "gzip.c"
        k += 8U;
      }
      while_break___11: ;
      }
# 5475 "gzip.c"
      j = 11U + ((unsigned int )b & 127U);
# 5476 "gzip.c"
      b >>= 7;
# 5476 "gzip.c"
      k -= 7U;
# 5477 "gzip.c"
      if ((unsigned int )i + j > n) {
# 5478 "gzip.c"
        __retres49 = 1;
# 5478 "gzip.c"
        goto return_label;
      } else {

      }
      {
# 5479 "gzip.c"
      while (1) {
        while_continue___12: ;
# 5479 "gzip.c"
        tmp___29 = j;
# 5479 "gzip.c"
        j --;
# 5479 "gzip.c"
        if (tmp___29 != 0) {

        } else {
# 5479 "gzip.c"
          goto while_break___12;
        }
# 5480 "gzip.c"
        tmp___28 = i;
# 5480 "gzip.c"
        i ++;
# 5480 "gzip.c"
        ll[tmp___28] = 0U;
      }
      while_break___12: ;
      }
# 5481 "gzip.c"
      l = 0U;
    }
  }
  while_break___5: ;
  }
# 5487 "gzip.c"
  huft_free(tl);
# 5491 "gzip.c"
  bb = b;
# 5492 "gzip.c"
  bk = k;
# 5496 "gzip.c"
  bl = lbits;
# 5497 "gzip.c"
  i = huft_build(ll, nl, 257U, cplens, cplext, & tl, & bl);
# 5497 "gzip.c"
  if (i != 0) {
# 5499 "gzip.c"
    if (i == 1) {
# 5500 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )" incomplete literal tree\n");
# 5501 "gzip.c"
      huft_free(tl);
    } else {

    }
# 5503 "gzip.c"
    __retres49 = i;
# 5503 "gzip.c"
    goto return_label;
  } else {

  }
# 5505 "gzip.c"
  bd = dbits;
# 5506 "gzip.c"
  i = huft_build(ll + nl, nd, 0U, cpdist, cpdext, & td, & bd);
# 5506 "gzip.c"
  if (i != 0) {
# 5508 "gzip.c"
    if (i == 1) {
# 5509 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )" incomplete distance tree\n");
# 5514 "gzip.c"
      huft_free(td);
    } else {

    }
# 5516 "gzip.c"
    huft_free(tl);
# 5517 "gzip.c"
    __retres49 = i;
# 5517 "gzip.c"
    goto return_label;
  } else {

  }
# 5523 "gzip.c"
  tmp___30 = inflate_codes(tl, td, bl, bd);
# 5523 "gzip.c"
  if (tmp___30 != 0) {
# 5524 "gzip.c"
    __retres49 = 1;
# 5524 "gzip.c"
    goto return_label;
  } else {

  }
# 5528 "gzip.c"
  huft_free(tl);
# 5529 "gzip.c"
  huft_free(td);
# 5530 "gzip.c"
  __retres49 = 0;
  return_label:
# 5367 "gzip.c"
  return (__retres49);
}
}
# 5535 "gzip.c"
int inflate_block(int *e )
{
  unsigned int t ;
  unsigned int w ;
  register ulg b ;
  register unsigned int k ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;
  int __retres15 ;

  {
# 5546 "gzip.c"
  b = bb;
# 5547 "gzip.c"
  k = bk;
# 5548 "gzip.c"
  w = outcnt;
  {
# 5552 "gzip.c"
  while (1) {
    while_continue: ;
# 5552 "gzip.c"
    if (k < 1U) {

    } else {
# 5552 "gzip.c"
      goto while_break;
    }
# 5552 "gzip.c"
    if (inptr < insize) {
# 5552 "gzip.c"
      tmp = inptr;
# 5552 "gzip.c"
      inptr ++;
# 5552 "gzip.c"
      tmp___1 = (int )inbuf[tmp];
    } else {
# 5552 "gzip.c"
      outcnt = w;
# 5552 "gzip.c"
      tmp___0 = fill_inbuf(0);
# 5552 "gzip.c"
      tmp___1 = tmp___0;
    }
# 5552 "gzip.c"
    b |= (ulg )((uch )tmp___1) << k;
# 5552 "gzip.c"
    k += 8U;
  }
  while_break: ;
  }
# 5553 "gzip.c"
  *e = (int )b & 1;
# 5554 "gzip.c"
  b >>= 1;
# 5554 "gzip.c"
  k --;
  {
# 5558 "gzip.c"
  while (1) {
    while_continue___0: ;
# 5558 "gzip.c"
    if (k < 2U) {

    } else {
# 5558 "gzip.c"
      goto while_break___0;
    }
# 5558 "gzip.c"
    if (inptr < insize) {
# 5558 "gzip.c"
      tmp___2 = inptr;
# 5558 "gzip.c"
      inptr ++;
# 5558 "gzip.c"
      tmp___4 = (int )inbuf[tmp___2];
    } else {
# 5558 "gzip.c"
      outcnt = w;
# 5558 "gzip.c"
      tmp___3 = fill_inbuf(0);
# 5558 "gzip.c"
      tmp___4 = tmp___3;
    }
# 5558 "gzip.c"
    b |= (ulg )((uch )tmp___4) << k;
# 5558 "gzip.c"
    k += 8U;
  }
  while_break___0: ;
  }
# 5559 "gzip.c"
  t = (unsigned int )b & 3U;
# 5560 "gzip.c"
  b >>= 2;
# 5560 "gzip.c"
  k -= 2U;
# 5564 "gzip.c"
  bb = b;
# 5565 "gzip.c"
  bk = k;
# 5569 "gzip.c"
  if (t == 2U) {
# 5570 "gzip.c"
    tmp___5 = inflate_dynamic();
# 5570 "gzip.c"
    __retres15 = tmp___5;
# 5570 "gzip.c"
    goto return_label;
  } else {

  }
# 5571 "gzip.c"
  if (t == 0U) {
# 5572 "gzip.c"
    tmp___6 = inflate_stored();
# 5572 "gzip.c"
    __retres15 = tmp___6;
# 5572 "gzip.c"
    goto return_label;
  } else {

  }
# 5573 "gzip.c"
  if (t == 1U) {
# 5574 "gzip.c"
    tmp___7 = inflate_fixed();
# 5574 "gzip.c"
    __retres15 = tmp___7;
# 5574 "gzip.c"
    goto return_label;
  } else {

  }
# 5578 "gzip.c"
  __retres15 = 2;
  return_label:
# 5535 "gzip.c"
  return (__retres15);
}
}
# 5583 "gzip.c"
int inflate(void)
{
  int e ;
  int r ;
  unsigned int h ;
  int __retres4 ;

  {
# 5592 "gzip.c"
  outcnt = 0U;
# 5593 "gzip.c"
  bk = 0U;
# 5594 "gzip.c"
  bb = (ulg )0;
# 5598 "gzip.c"
  h = 0U;
  {
# 5599 "gzip.c"
  while (1) {
    while_continue: ;
# 5600 "gzip.c"
    hufts = 0U;
# 5601 "gzip.c"
    r = inflate_block(& e);
# 5601 "gzip.c"
    if (r != 0) {
# 5602 "gzip.c"
      __retres4 = r;
# 5602 "gzip.c"
      goto return_label;
    } else {

    }
# 5603 "gzip.c"
    if (hufts > h) {
# 5604 "gzip.c"
      h = hufts;
    } else {

    }
# 5599 "gzip.c"
    if (e == 0) {

    } else {
# 5599 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
  {
# 5610 "gzip.c"
  while (1) {
    while_continue___0: ;
# 5610 "gzip.c"
    if (bk >= 8U) {

    } else {
# 5610 "gzip.c"
      goto while_break___0;
    }
# 5611 "gzip.c"
    bk -= 8U;
# 5612 "gzip.c"
    inptr --;
  }
  while_break___0: ;
  }
# 5616 "gzip.c"
  outcnt = outcnt;
# 5616 "gzip.c"
  flush_window();
# 5623 "gzip.c"
  __retres4 = 0;
  return_label:
# 5583 "gzip.c"
  return (__retres4);
}
}
# 5633 "gzip.c"
static int msg_done = 0;
# 5636 "gzip.c"
int lzw(int in , int out )
{
  int __retres3 ;

  {
# 5639 "gzip.c"
  if (msg_done != 0) {
# 5639 "gzip.c"
    __retres3 = 1;
# 5639 "gzip.c"
    goto return_label;
  } else {

  }
# 5640 "gzip.c"
  msg_done = 1;
# 5641 "gzip.c"
  fprintf((FILE * __restrict )stderr, (char const * __restrict )"output in compress .Z format not supported\n");
# 5642 "gzip.c"
  if (in != out) {
# 5643 "gzip.c"
    exit_code = 1;
  } else {

  }
# 5645 "gzip.c"
  __retres3 = 1;
  return_label:
# 5636 "gzip.c"
  return (__retres3);
}
}
# 5736 "gzip.c"
static int extra_lbits[29] =
# 5736 "gzip.c"
  { 0, 0, 0, 0,
        0, 0, 0, 0,
        1, 1, 1, 1,
        2, 2, 2, 2,
        3, 3, 3, 3,
        4, 4, 4, 4,
        5, 5, 5, 5,
        0};
# 5739 "gzip.c"
static int extra_dbits[30] =
# 5739 "gzip.c"
  { 0, 0, 0, 0,
        1, 1, 2, 2,
        3, 3, 4, 4,
        5, 5, 6, 6,
        7, 7, 8, 8,
        9, 9, 10, 10,
        11, 11, 12, 12,
        13, 13};
# 5742 "gzip.c"
static int extra_blbits[19] =
# 5742 "gzip.c"
  { 0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        0, 0, 0, 0,
        2, 3, 7};
# 5821 "gzip.c"
static ct_data dyn_ltree[573] ;
# 5822 "gzip.c"
static ct_data dyn_dtree[61] ;
# 5824 "gzip.c"
static ct_data static_ltree[288] ;
# 5831 "gzip.c"
static ct_data static_dtree[30] ;
# 5836 "gzip.c"
static ct_data bl_tree[39] ;
# 5849 "gzip.c"
static tree_desc l_desc = {dyn_ltree, static_ltree, extra_lbits, 257, 286, 15, 0};
# 5852 "gzip.c"
static tree_desc d_desc = {dyn_dtree, static_dtree, extra_dbits, 0, 30, 15, 0};
# 5855 "gzip.c"
static tree_desc bl_desc = {bl_tree, (ct_data *)0, extra_blbits, 0, 19, 7, 0};
# 5859 "gzip.c"
static ush bl_count[16] ;
# 5862 "gzip.c"
static uch bl_order[19] =
# 5862 "gzip.c"
  { (uch )16, (uch )17, (uch )18, (uch )0,
        (uch )8, (uch )7, (uch )9, (uch )6,
        (uch )10, (uch )5, (uch )11, (uch )4,
        (uch )12, (uch )3, (uch )13, (uch )2,
        (uch )14, (uch )1, (uch )15};
# 5868 "gzip.c"
static int heap[573] ;
# 5869 "gzip.c"
static int heap_len ;
# 5870 "gzip.c"
static int heap_max ;
# 5875 "gzip.c"
static uch depth[573] ;
# 5878 "gzip.c"
static uch length_code[256] ;
# 5881 "gzip.c"
static uch dist_code[512] ;
# 5887 "gzip.c"
static int base_length[29] ;
# 5890 "gzip.c"
static int base_dist[30] ;
# 5898 "gzip.c"
static uch flag_buf[4096] ;
# 5903 "gzip.c"
static unsigned int last_lit ;
# 5904 "gzip.c"
static unsigned int last_dist ;
# 5905 "gzip.c"
static unsigned int last_flags ;
# 5906 "gzip.c"
static uch flags ;
# 5907 "gzip.c"
static uch flag_bit ;
# 5913 "gzip.c"
static ulg opt_len ;
# 5914 "gzip.c"
static ulg static_len ;
# 5916 "gzip.c"
static off_t compressed_len ;
# 5918 "gzip.c"
static off_t input_len ;
# 5921 "gzip.c"
ush *file_type ;
# 5922 "gzip.c"
int *file_method ;
# 5935 "gzip.c"
static void init_block(void) ;
# 5936 "gzip.c"
static void pqdownheap(ct_data *tree , int k ) ;
# 5937 "gzip.c"
static void gen_bitlen(tree_desc *desc ) ;
# 5938 "gzip.c"
static void gen_codes(ct_data *tree , int max_code ) ;
# 5939 "gzip.c"
static void build_tree_1(tree_desc *desc ) ;
# 5940 "gzip.c"
static void scan_tree(ct_data *tree , int max_code ) ;
# 5941 "gzip.c"
static void send_tree(ct_data *tree , int max_code ) ;
# 5942 "gzip.c"
static int build_bl_tree(void) ;
# 5943 "gzip.c"
static void send_all_trees(int lcodes , int dcodes , int blcodes ) ;
# 5944 "gzip.c"
static void compress_block(ct_data *ltree , ct_data *dtree ) ;
# 5945 "gzip.c"
static void set_file_type(void) ;
# 5973 "gzip.c"
void ct_init(ush *attr , int *methodp )
{
  int n ;
  int bits ;
  int length ;
  int code ;
  int dist ;
  int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;
  unsigned int tmp___6 ;

  {
# 5983 "gzip.c"
  file_type = attr;
# 5984 "gzip.c"
  file_method = methodp;
# 5985 "gzip.c"
  input_len = 0L;
# 5985 "gzip.c"
  compressed_len = input_len;
# 5987 "gzip.c"
  if ((int )static_dtree[0].dl.len != 0) {
# 5987 "gzip.c"
    goto return_label;
  } else {

  }
# 5990 "gzip.c"
  length = 0;
# 5991 "gzip.c"
  code = 0;
  {
# 5991 "gzip.c"
  while (1) {
    while_continue: ;
# 5991 "gzip.c"
    if (code < 28) {

    } else {
# 5991 "gzip.c"
      goto while_break;
    }
# 5992 "gzip.c"
    base_length[code] = length;
# 5993 "gzip.c"
    n = 0;
    {
# 5993 "gzip.c"
    while (1) {
      while_continue___0: ;
# 5993 "gzip.c"
      if (n < 1 << extra_lbits[code]) {

      } else {
# 5993 "gzip.c"
        goto while_break___0;
      }
# 5994 "gzip.c"
      tmp = length;
# 5994 "gzip.c"
      length ++;
# 5994 "gzip.c"
      length_code[tmp] = (uch )code;
# 5993 "gzip.c"
      n ++;
    }
    while_break___0: ;
    }
# 5991 "gzip.c"
    code ++;
  }
  while_break: ;
  }
# 6002 "gzip.c"
  length_code[length - 1] = (uch )code;
# 6005 "gzip.c"
  dist = 0;
# 6006 "gzip.c"
  code = 0;
  {
# 6006 "gzip.c"
  while (1) {
    while_continue___1: ;
# 6006 "gzip.c"
    if (code < 16) {

    } else {
# 6006 "gzip.c"
      goto while_break___1;
    }
# 6007 "gzip.c"
    base_dist[code] = dist;
# 6008 "gzip.c"
    n = 0;
    {
# 6008 "gzip.c"
    while (1) {
      while_continue___2: ;
# 6008 "gzip.c"
      if (n < 1 << extra_dbits[code]) {

      } else {
# 6008 "gzip.c"
        goto while_break___2;
      }
# 6009 "gzip.c"
      tmp___0 = dist;
# 6009 "gzip.c"
      dist ++;
# 6009 "gzip.c"
      dist_code[tmp___0] = (uch )code;
# 6008 "gzip.c"
      n ++;
    }
    while_break___2: ;
    }
# 6006 "gzip.c"
    code ++;
  }
  while_break___1: ;
  }
# 6013 "gzip.c"
  dist >>= 7;
  {
# 6014 "gzip.c"
  while (1) {
    while_continue___3: ;
# 6014 "gzip.c"
    if (code < 30) {

    } else {
# 6014 "gzip.c"
      goto while_break___3;
    }
# 6015 "gzip.c"
    base_dist[code] = dist << 7;
# 6016 "gzip.c"
    n = 0;
    {
# 6016 "gzip.c"
    while (1) {
      while_continue___4: ;
# 6016 "gzip.c"
      if (n < 1 << (extra_dbits[code] - 7)) {

      } else {
# 6016 "gzip.c"
        goto while_break___4;
      }
# 6017 "gzip.c"
      tmp___1 = dist;
# 6017 "gzip.c"
      dist ++;
# 6017 "gzip.c"
      dist_code[256 + tmp___1] = (uch )code;
# 6016 "gzip.c"
      n ++;
    }
    while_break___4: ;
    }
# 6014 "gzip.c"
    code ++;
  }
  while_break___3: ;
  }
# 6023 "gzip.c"
  bits = 0;
  {
# 6023 "gzip.c"
  while (1) {
    while_continue___5: ;
# 6023 "gzip.c"
    if (bits <= 15) {

    } else {
# 6023 "gzip.c"
      goto while_break___5;
    }
# 6023 "gzip.c"
    bl_count[bits] = (ush )0;
# 6023 "gzip.c"
    bits ++;
  }
  while_break___5: ;
  }
# 6024 "gzip.c"
  n = 0;
  {
# 6025 "gzip.c"
  while (1) {
    while_continue___6: ;
# 6025 "gzip.c"
    if (n <= 143) {

    } else {
# 6025 "gzip.c"
      goto while_break___6;
    }
# 6025 "gzip.c"
    tmp___2 = n;
# 6025 "gzip.c"
    n ++;
# 6025 "gzip.c"
    static_ltree[tmp___2].dl.len = (ush )8;
# 6025 "gzip.c"
    bl_count[8] = (ush )((int )bl_count[8] + 1);
  }
  while_break___6: ;
  }
  {
# 6026 "gzip.c"
  while (1) {
    while_continue___7: ;
# 6026 "gzip.c"
    if (n <= 255) {

    } else {
# 6026 "gzip.c"
      goto while_break___7;
    }
# 6026 "gzip.c"
    tmp___3 = n;
# 6026 "gzip.c"
    n ++;
# 6026 "gzip.c"
    static_ltree[tmp___3].dl.len = (ush )9;
# 6026 "gzip.c"
    bl_count[9] = (ush )((int )bl_count[9] + 1);
  }
  while_break___7: ;
  }
  {
# 6027 "gzip.c"
  while (1) {
    while_continue___8: ;
# 6027 "gzip.c"
    if (n <= 279) {

    } else {
# 6027 "gzip.c"
      goto while_break___8;
    }
# 6027 "gzip.c"
    tmp___4 = n;
# 6027 "gzip.c"
    n ++;
# 6027 "gzip.c"
    static_ltree[tmp___4].dl.len = (ush )7;
# 6027 "gzip.c"
    bl_count[7] = (ush )((int )bl_count[7] + 1);
  }
  while_break___8: ;
  }
  {
# 6028 "gzip.c"
  while (1) {
    while_continue___9: ;
# 6028 "gzip.c"
    if (n <= 287) {

    } else {
# 6028 "gzip.c"
      goto while_break___9;
    }
# 6028 "gzip.c"
    tmp___5 = n;
# 6028 "gzip.c"
    n ++;
# 6028 "gzip.c"
    static_ltree[tmp___5].dl.len = (ush )8;
# 6028 "gzip.c"
    bl_count[8] = (ush )((int )bl_count[8] + 1);
  }
  while_break___9: ;
  }
# 6033 "gzip.c"
  gen_codes(static_ltree, 287);
# 6036 "gzip.c"
  n = 0;
  {
# 6036 "gzip.c"
  while (1) {
    while_continue___10: ;
# 6036 "gzip.c"
    if (n < 30) {

    } else {
# 6036 "gzip.c"
      goto while_break___10;
    }
# 6037 "gzip.c"
    static_dtree[n].dl.len = (ush )5;
# 6038 "gzip.c"
    tmp___6 = bi_reverse((unsigned int )n, 5);
# 6038 "gzip.c"
    static_dtree[n].fc.code = (ush )tmp___6;
# 6036 "gzip.c"
    n ++;
  }
  while_break___10: ;
  }
# 6042 "gzip.c"
  init_block();

  return_label:
# 5973 "gzip.c"
  return;
}
}
# 6048 "gzip.c"
static void init_block(void)
{
  int n ;

  {
# 6053 "gzip.c"
  n = 0;
  {
# 6053 "gzip.c"
  while (1) {
    while_continue: ;
# 6053 "gzip.c"
    if (n < 286) {

    } else {
# 6053 "gzip.c"
      goto while_break;
    }
# 6053 "gzip.c"
    dyn_ltree[n].fc.freq = (ush )0;
# 6053 "gzip.c"
    n ++;
  }
  while_break: ;
  }
# 6054 "gzip.c"
  n = 0;
  {
# 6054 "gzip.c"
  while (1) {
    while_continue___0: ;
# 6054 "gzip.c"
    if (n < 30) {

    } else {
# 6054 "gzip.c"
      goto while_break___0;
    }
# 6054 "gzip.c"
    dyn_dtree[n].fc.freq = (ush )0;
# 6054 "gzip.c"
    n ++;
  }
  while_break___0: ;
  }
# 6055 "gzip.c"
  n = 0;
  {
# 6055 "gzip.c"
  while (1) {
    while_continue___1: ;
# 6055 "gzip.c"
    if (n < 19) {

    } else {
# 6055 "gzip.c"
      goto while_break___1;
    }
# 6055 "gzip.c"
    bl_tree[n].fc.freq = (ush )0;
# 6055 "gzip.c"
    n ++;
  }
  while_break___1: ;
  }
# 6057 "gzip.c"
  dyn_ltree[256].fc.freq = (ush )1;
# 6058 "gzip.c"
  static_len = (ulg )0L;
# 6058 "gzip.c"
  opt_len = static_len;
# 6059 "gzip.c"
  last_flags = 0U;
# 6059 "gzip.c"
  last_dist = last_flags;
# 6059 "gzip.c"
  last_lit = last_dist;
# 6060 "gzip.c"
  flags = (uch )0;
# 6060 "gzip.c"
  flag_bit = (uch )1;
# 6048 "gzip.c"
  return;
}
}
# 6092 "gzip.c"
static void pqdownheap(ct_data *tree , int k )
{
  int v ;
  int j ;
  ct_data *mem_5 ;
  ct_data *mem_6 ;
  ct_data *mem_7 ;
  ct_data *mem_8 ;
  ct_data *mem_9 ;
  ct_data *mem_10 ;
  ct_data *mem_11 ;
  ct_data *mem_12 ;

  {
# 6096 "gzip.c"
  v = heap[k];
# 6097 "gzip.c"
  j = k << 1;
  {
# 6098 "gzip.c"
  while (1) {
    while_continue: ;
# 6098 "gzip.c"
    if (j <= heap_len) {

    } else {
# 6098 "gzip.c"
      goto while_break;
    }
# 6100 "gzip.c"
    if (j < heap_len) {
      {
# 6100 "gzip.c"
      mem_5 = tree + heap[j + 1];
# 6100 "gzip.c"
      mem_6 = tree + heap[j];
# 6100 "gzip.c"
      if ((int )mem_5->fc.freq < (int )mem_6->fc.freq) {
# 6100 "gzip.c"
        j ++;
      } else {
        {
# 6100 "gzip.c"
        mem_7 = tree + heap[j + 1];
# 6100 "gzip.c"
        mem_8 = tree + heap[j];
# 6100 "gzip.c"
        if ((int )mem_7->fc.freq == (int )mem_8->fc.freq) {
# 6100 "gzip.c"
          if ((int )depth[heap[j + 1]] <= (int )depth[heap[j]]) {
# 6100 "gzip.c"
            j ++;
          } else {

          }
        } else {

        }
        }
      }
      }
    } else {

    }
    {
# 6103 "gzip.c"
    mem_9 = tree + v;
# 6103 "gzip.c"
    mem_10 = tree + heap[j];
# 6103 "gzip.c"
    if ((int )mem_9->fc.freq < (int )mem_10->fc.freq) {
# 6103 "gzip.c"
      goto while_break;
    } else {
      {
# 6103 "gzip.c"
      mem_11 = tree + v;
# 6103 "gzip.c"
      mem_12 = tree + heap[j];
# 6103 "gzip.c"
      if ((int )mem_11->fc.freq == (int )mem_12->fc.freq) {
# 6103 "gzip.c"
        if ((int )depth[v] <= (int )depth[heap[j]]) {
# 6103 "gzip.c"
          goto while_break;
        } else {

        }
      } else {

      }
      }
    }
    }
# 6106 "gzip.c"
    heap[k] = heap[j];
# 6106 "gzip.c"
    k = j;
# 6109 "gzip.c"
    j <<= 1;
  }
  while_break: ;
  }
# 6111 "gzip.c"
  heap[k] = v;
# 6092 "gzip.c"
  return;
}
}
# 6124 "gzip.c"
static void gen_bitlen(tree_desc *desc )
{
  ct_data *tree ;
  int *extra ;
  int base ;
  int max_code ;
  int max_length ;
  ct_data *stree ;
  int h ;
  int n ;
  int m ;
  int bits ;
  int xbits ;
  ush f ;
  int overflow ;
  ct_data *mem_15 ;
  ct_data *mem_16 ;
  ct_data *mem_17 ;
  ct_data *mem_18 ;
  int *mem_19 ;
  ct_data *mem_20 ;
  ct_data *mem_21 ;
  ct_data *mem_22 ;
  ct_data *mem_23 ;
  ct_data *mem_24 ;
  ct_data *mem_25 ;

  {
# 6127 "gzip.c"
  tree = desc->dyn_tree;
# 6128 "gzip.c"
  extra = desc->extra_bits;
# 6129 "gzip.c"
  base = desc->extra_base;
# 6130 "gzip.c"
  max_code = desc->max_code;
# 6131 "gzip.c"
  max_length = desc->max_length;
# 6132 "gzip.c"
  stree = desc->static_tree;
# 6138 "gzip.c"
  overflow = 0;
# 6140 "gzip.c"
  bits = 0;
  {
# 6140 "gzip.c"
  while (1) {
    while_continue: ;
# 6140 "gzip.c"
    if (bits <= 15) {

    } else {
# 6140 "gzip.c"
      goto while_break;
    }
# 6140 "gzip.c"
    bl_count[bits] = (ush )0;
# 6140 "gzip.c"
    bits ++;
  }
  while_break: ;
  }
# 6145 "gzip.c"
  mem_15 = tree + heap[heap_max];
# 6145 "gzip.c"
  mem_15->dl.len = (ush )0;
# 6147 "gzip.c"
  h = heap_max + 1;
  {
# 6147 "gzip.c"
  while (1) {
    while_continue___0: ;
# 6147 "gzip.c"
    if (h < 573) {

    } else {
# 6147 "gzip.c"
      goto while_break___0;
    }
# 6148 "gzip.c"
    n = heap[h];
# 6149 "gzip.c"
    mem_16 = tree + n;
# 6149 "gzip.c"
    mem_17 = tree + mem_16->dl.dad;
# 6149 "gzip.c"
    bits = (int )mem_17->dl.len + 1;
# 6150 "gzip.c"
    if (bits > max_length) {
# 6150 "gzip.c"
      bits = max_length;
# 6150 "gzip.c"
      overflow ++;
    } else {

    }
# 6151 "gzip.c"
    mem_18 = tree + n;
# 6151 "gzip.c"
    mem_18->dl.len = (ush )bits;
# 6154 "gzip.c"
    if (n > max_code) {
# 6154 "gzip.c"
      goto __Cont;
    } else {

    }
# 6156 "gzip.c"
    bl_count[bits] = (ush )((int )bl_count[bits] + 1);
# 6157 "gzip.c"
    xbits = 0;
# 6158 "gzip.c"
    if (n >= base) {
# 6158 "gzip.c"
      mem_19 = extra + (n - base);
# 6158 "gzip.c"
      xbits = *mem_19;
    } else {

    }
# 6159 "gzip.c"
    mem_20 = tree + n;
# 6159 "gzip.c"
    f = mem_20->fc.freq;
# 6160 "gzip.c"
    opt_len += (ulg )f * (ulg )(bits + xbits);
# 6161 "gzip.c"
    if (stree != 0) {
# 6161 "gzip.c"
      mem_21 = stree + n;
# 6161 "gzip.c"
      static_len += (ulg )f * (ulg )((int )mem_21->dl.len + xbits);
    } else {

    }
    __Cont:
# 6147 "gzip.c"
    h ++;
  }
  while_break___0: ;
  }
# 6163 "gzip.c"
  if (overflow == 0) {
# 6163 "gzip.c"
    goto return_label;
  } else {

  }
  {
# 6169 "gzip.c"
  while (1) {
    while_continue___1: ;
# 6170 "gzip.c"
    bits = max_length - 1;
    {
# 6171 "gzip.c"
    while (1) {
      while_continue___2: ;
# 6171 "gzip.c"
      if ((int )bl_count[bits] == 0) {

      } else {
# 6171 "gzip.c"
        goto while_break___2;
      }
# 6171 "gzip.c"
      bits --;
    }
    while_break___2: ;
    }
# 6172 "gzip.c"
    bl_count[bits] = (ush )((int )bl_count[bits] - 1);
# 6173 "gzip.c"
    bl_count[bits + 1] = (ush )((int )bl_count[bits + 1] + 2);
# 6174 "gzip.c"
    bl_count[max_length] = (ush )((int )bl_count[max_length] - 1);
# 6178 "gzip.c"
    overflow -= 2;
# 6169 "gzip.c"
    if (overflow > 0) {

    } else {
# 6169 "gzip.c"
      goto while_break___1;
    }
  }
  while_break___1: ;
  }
# 6186 "gzip.c"
  bits = max_length;
  {
# 6186 "gzip.c"
  while (1) {
    while_continue___3: ;
# 6186 "gzip.c"
    if (bits != 0) {

    } else {
# 6186 "gzip.c"
      goto while_break___3;
    }
# 6187 "gzip.c"
    n = (int )bl_count[bits];
    {
# 6188 "gzip.c"
    while (1) {
      while_continue___4: ;
# 6188 "gzip.c"
      if (n != 0) {

      } else {
# 6188 "gzip.c"
        goto while_break___4;
      }
# 6189 "gzip.c"
      h --;
# 6189 "gzip.c"
      m = heap[h];
# 6190 "gzip.c"
      if (m > max_code) {
# 6190 "gzip.c"
        goto while_continue___4;
      } else {

      }
      {
# 6191 "gzip.c"
      mem_22 = tree + m;
# 6191 "gzip.c"
      if ((unsigned int )mem_22->dl.len != (unsigned int )bits) {
# 6193 "gzip.c"
        mem_23 = tree + m;
# 6193 "gzip.c"
        mem_24 = tree + m;
# 6193 "gzip.c"
        opt_len += (ulg )(((long )bits - (long )mem_23->dl.len) * (long )mem_24->fc.freq);
# 6194 "gzip.c"
        mem_25 = tree + m;
# 6194 "gzip.c"
        mem_25->dl.len = (ush )bits;
      } else {

      }
      }
# 6196 "gzip.c"
      n --;
    }
    while_break___4: ;
    }
# 6186 "gzip.c"
    bits --;
  }
  while_break___3: ;
  }

  return_label:
# 6124 "gzip.c"
  return;
}
}
# 6209 "gzip.c"
static void gen_codes(ct_data *tree , int max_code )
{
  ush next_code[16] ;
  ush code ;
  int bits ;
  int n ;
  int len ;
  ush tmp ;
  unsigned int tmp___0 ;
  ct_data *mem_10 ;
  ct_data *mem_11 ;

  {
# 6214 "gzip.c"
  code = (ush )0;
# 6221 "gzip.c"
  bits = 1;
  {
# 6221 "gzip.c"
  while (1) {
    while_continue: ;
# 6221 "gzip.c"
    if (bits <= 15) {

    } else {
# 6221 "gzip.c"
      goto while_break;
    }
# 6222 "gzip.c"
    code = (ush )(((int )code + (int )bl_count[bits - 1]) << 1);
# 6222 "gzip.c"
    next_code[bits] = code;
# 6221 "gzip.c"
    bits ++;
  }
  while_break: ;
  }
# 6231 "gzip.c"
  n = 0;
  {
# 6231 "gzip.c"
  while (1) {
    while_continue___0: ;
# 6231 "gzip.c"
    if (n <= max_code) {

    } else {
# 6231 "gzip.c"
      goto while_break___0;
    }
# 6232 "gzip.c"
    mem_10 = tree + n;
# 6232 "gzip.c"
    len = (int )mem_10->dl.len;
# 6233 "gzip.c"
    if (len == 0) {
# 6233 "gzip.c"
      goto __Cont;
    } else {

    }
# 6235 "gzip.c"
    tmp = next_code[len];
# 6235 "gzip.c"
    next_code[len] = (ush )((int )next_code[len] + 1);
# 6235 "gzip.c"
    tmp___0 = bi_reverse((unsigned int )tmp, len);
# 6235 "gzip.c"
    mem_11 = tree + n;
# 6235 "gzip.c"
    mem_11->fc.code = (ush )tmp___0;
    __Cont:
# 6231 "gzip.c"
    n ++;
  }
  while_break___0: ;
  }
# 6209 "gzip.c"
  return;
}
}
# 6250 "gzip.c"
static void build_tree_1(tree_desc *desc )
{
  ct_data *tree ;
  ct_data *stree ;
  int elems ;
  int n ;
  int m ;
  int max_code ;
  int node ;
  int new ;
  int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  ush tmp___2 ;
  int tmp___3 ;
  ct_data *mem_15 ;
  ct_data *mem_16 ;
  ct_data *mem_17 ;
  ct_data *mem_18 ;
  ct_data *mem_19 ;
  ct_data *mem_20 ;
  ct_data *mem_21 ;
  ct_data *mem_22 ;
  ct_data *mem_23 ;

  {
# 6253 "gzip.c"
  tree = desc->dyn_tree;
# 6254 "gzip.c"
  stree = desc->static_tree;
# 6255 "gzip.c"
  elems = desc->elems;
# 6257 "gzip.c"
  max_code = -1;
# 6258 "gzip.c"
  node = elems;
# 6264 "gzip.c"
  heap_len = 0;
# 6264 "gzip.c"
  heap_max = 573;
# 6266 "gzip.c"
  n = 0;
  {
# 6266 "gzip.c"
  while (1) {
    while_continue: ;
# 6266 "gzip.c"
    if (n < elems) {

    } else {
# 6266 "gzip.c"
      goto while_break;
    }
    {
# 6267 "gzip.c"
    mem_15 = tree + n;
# 6267 "gzip.c"
    if ((int )mem_15->fc.freq != 0) {
# 6268 "gzip.c"
      heap_len ++;
# 6268 "gzip.c"
      max_code = n;
# 6268 "gzip.c"
      heap[heap_len] = max_code;
# 6269 "gzip.c"
      depth[n] = (uch )0;
    } else {
# 6271 "gzip.c"
      mem_16 = tree + n;
# 6271 "gzip.c"
      mem_16->dl.len = (ush )0;
    }
    }
# 6266 "gzip.c"
    n ++;
  }
  while_break: ;
  }
  {
# 6280 "gzip.c"
  while (1) {
    while_continue___0: ;
# 6280 "gzip.c"
    if (heap_len < 2) {

    } else {
# 6280 "gzip.c"
      goto while_break___0;
    }
# 6281 "gzip.c"
    heap_len ++;
# 6281 "gzip.c"
    if (max_code < 2) {
# 6281 "gzip.c"
      max_code ++;
# 6281 "gzip.c"
      tmp = max_code;
    } else {
# 6281 "gzip.c"
      tmp = 0;
    }
# 6281 "gzip.c"
    heap[heap_len] = tmp;
# 6281 "gzip.c"
    new = tmp;
# 6282 "gzip.c"
    mem_17 = tree + new;
# 6282 "gzip.c"
    mem_17->fc.freq = (ush )1;
# 6283 "gzip.c"
    depth[new] = (uch )0;
# 6284 "gzip.c"
    opt_len --;
# 6284 "gzip.c"
    if (stree != 0) {
# 6284 "gzip.c"
      mem_18 = stree + new;
# 6284 "gzip.c"
      static_len -= (ulg )mem_18->dl.len;
    } else {

    }
  }
  while_break___0: ;
  }
# 6287 "gzip.c"
  desc->max_code = max_code;
# 6292 "gzip.c"
  n = heap_len / 2;
  {
# 6292 "gzip.c"
  while (1) {
    while_continue___1: ;
# 6292 "gzip.c"
    if (n >= 1) {

    } else {
# 6292 "gzip.c"
      goto while_break___1;
    }
# 6292 "gzip.c"
    pqdownheap(tree, n);
# 6292 "gzip.c"
    n --;
  }
  while_break___1: ;
  }
  {
# 6297 "gzip.c"
  while (1) {
    while_continue___2: ;
# 6298 "gzip.c"
    n = heap[1];
# 6298 "gzip.c"
    tmp___0 = heap_len;
# 6298 "gzip.c"
    heap_len --;
# 6298 "gzip.c"
    heap[1] = heap[tmp___0];
# 6298 "gzip.c"
    pqdownheap(tree, 1);
# 6299 "gzip.c"
    m = heap[1];
# 6301 "gzip.c"
    heap_max --;
# 6301 "gzip.c"
    heap[heap_max] = n;
# 6302 "gzip.c"
    heap_max --;
# 6302 "gzip.c"
    heap[heap_max] = m;
# 6305 "gzip.c"
    mem_19 = tree + node;
# 6305 "gzip.c"
    mem_20 = tree + n;
# 6305 "gzip.c"
    mem_21 = tree + m;
# 6305 "gzip.c"
    mem_19->fc.freq = (ush )((int )mem_20->fc.freq + (int )mem_21->fc.freq);
# 6306 "gzip.c"
    if ((int )depth[n] >= (int )depth[m]) {
# 6306 "gzip.c"
      tmp___1 = (int )depth[n];
    } else {
# 6306 "gzip.c"
      tmp___1 = (int )depth[m];
    }
# 6306 "gzip.c"
    depth[node] = (uch )(tmp___1 + 1);
# 6307 "gzip.c"
    tmp___2 = (ush )node;
# 6307 "gzip.c"
    mem_22 = tree + m;
# 6307 "gzip.c"
    mem_22->dl.dad = tmp___2;
# 6307 "gzip.c"
    mem_23 = tree + n;
# 6307 "gzip.c"
    mem_23->dl.dad = tmp___2;
# 6315 "gzip.c"
    tmp___3 = node;
# 6315 "gzip.c"
    node ++;
# 6315 "gzip.c"
    heap[1] = tmp___3;
# 6316 "gzip.c"
    pqdownheap(tree, 1);
# 6297 "gzip.c"
    if (heap_len >= 2) {

    } else {
# 6297 "gzip.c"
      goto while_break___2;
    }
  }
  while_break___2: ;
  }
# 6320 "gzip.c"
  heap_max --;
# 6320 "gzip.c"
  heap[heap_max] = heap[1];
# 6325 "gzip.c"
  gen_bitlen(desc);
# 6328 "gzip.c"
  gen_codes(tree, max_code);
# 6250 "gzip.c"
  return;
}
}
# 6337 "gzip.c"
static void scan_tree(ct_data *tree , int max_code )
{
  int n ;
  int prevlen ;
  int curlen ;
  int nextlen ;
  int count ;
  int max_count ;
  int min_count ;
  ct_data *mem_10 ;
  ct_data *mem_11 ;
  ct_data *mem_12 ;

  {
# 6342 "gzip.c"
  prevlen = -1;
# 6344 "gzip.c"
  mem_10 = tree + 0;
# 6344 "gzip.c"
  nextlen = (int )mem_10->dl.len;
# 6345 "gzip.c"
  count = 0;
# 6346 "gzip.c"
  max_count = 7;
# 6347 "gzip.c"
  min_count = 4;
# 6349 "gzip.c"
  if (nextlen == 0) {
# 6349 "gzip.c"
    max_count = 138;
# 6349 "gzip.c"
    min_count = 3;
  } else {

  }
# 6350 "gzip.c"
  mem_11 = tree + (max_code + 1);
# 6350 "gzip.c"
  mem_11->dl.len = (ush )65535;
# 6352 "gzip.c"
  n = 0;
  {
# 6352 "gzip.c"
  while (1) {
    while_continue: ;
# 6352 "gzip.c"
    if (n <= max_code) {

    } else {
# 6352 "gzip.c"
      goto while_break;
    }
# 6353 "gzip.c"
    curlen = nextlen;
# 6353 "gzip.c"
    mem_12 = tree + (n + 1);
# 6353 "gzip.c"
    nextlen = (int )mem_12->dl.len;
# 6354 "gzip.c"
    count ++;
# 6354 "gzip.c"
    if (count < max_count) {
# 6354 "gzip.c"
      if (curlen == nextlen) {
# 6355 "gzip.c"
        goto __Cont;
      } else {
# 6354 "gzip.c"
        goto _L;
      }
    } else
    _L:
# 6356 "gzip.c"
    if (count < min_count) {
# 6357 "gzip.c"
      bl_tree[curlen].fc.freq = (ush )((int )bl_tree[curlen].fc.freq + count);
    } else
# 6358 "gzip.c"
    if (curlen != 0) {
# 6359 "gzip.c"
      if (curlen != prevlen) {
# 6359 "gzip.c"
        bl_tree[curlen].fc.freq = (ush )((int )bl_tree[curlen].fc.freq + 1);
      } else {

      }
# 6360 "gzip.c"
      bl_tree[16].fc.freq = (ush )((int )bl_tree[16].fc.freq + 1);
    } else
# 6361 "gzip.c"
    if (count <= 10) {
# 6362 "gzip.c"
      bl_tree[17].fc.freq = (ush )((int )bl_tree[17].fc.freq + 1);
    } else {
# 6364 "gzip.c"
      bl_tree[18].fc.freq = (ush )((int )bl_tree[18].fc.freq + 1);
    }
# 6366 "gzip.c"
    count = 0;
# 6366 "gzip.c"
    prevlen = curlen;
# 6367 "gzip.c"
    if (nextlen == 0) {
# 6368 "gzip.c"
      max_count = 138;
# 6368 "gzip.c"
      min_count = 3;
    } else
# 6369 "gzip.c"
    if (curlen == nextlen) {
# 6370 "gzip.c"
      max_count = 6;
# 6370 "gzip.c"
      min_count = 3;
    } else {
# 6372 "gzip.c"
      max_count = 7;
# 6372 "gzip.c"
      min_count = 4;
    }
    __Cont:
# 6352 "gzip.c"
    n ++;
  }
  while_break: ;
  }
# 6337 "gzip.c"
  return;
}
}
# 6381 "gzip.c"
static void send_tree(ct_data *tree , int max_code )
{
  int n ;
  int prevlen ;
  int curlen ;
  int nextlen ;
  int count ;
  int max_count ;
  int min_count ;
  ct_data *mem_10 ;
  ct_data *mem_11 ;

  {
# 6386 "gzip.c"
  prevlen = -1;
# 6388 "gzip.c"
  mem_10 = tree + 0;
# 6388 "gzip.c"
  nextlen = (int )mem_10->dl.len;
# 6389 "gzip.c"
  count = 0;
# 6390 "gzip.c"
  max_count = 7;
# 6391 "gzip.c"
  min_count = 4;
# 6394 "gzip.c"
  if (nextlen == 0) {
# 6394 "gzip.c"
    max_count = 138;
# 6394 "gzip.c"
    min_count = 3;
  } else {

  }
# 6396 "gzip.c"
  n = 0;
  {
# 6396 "gzip.c"
  while (1) {
    while_continue: ;
# 6396 "gzip.c"
    if (n <= max_code) {

    } else {
# 6396 "gzip.c"
      goto while_break;
    }
# 6397 "gzip.c"
    curlen = nextlen;
# 6397 "gzip.c"
    mem_11 = tree + (n + 1);
# 6397 "gzip.c"
    nextlen = (int )mem_11->dl.len;
# 6398 "gzip.c"
    count ++;
# 6398 "gzip.c"
    if (count < max_count) {
# 6398 "gzip.c"
      if (curlen == nextlen) {
# 6399 "gzip.c"
        goto __Cont;
      } else {
# 6398 "gzip.c"
        goto _L;
      }
    } else
    _L:
# 6400 "gzip.c"
    if (count < min_count) {
      {
# 6401 "gzip.c"
      while (1) {
        while_continue___0: ;
# 6401 "gzip.c"
        send_bits((int )bl_tree[curlen].fc.code, (int )bl_tree[curlen].dl.len);
# 6401 "gzip.c"
        count --;
# 6401 "gzip.c"
        if (count != 0) {

        } else {
# 6401 "gzip.c"
          goto while_break___0;
        }
      }
      while_break___0: ;
      }
    } else
# 6403 "gzip.c"
    if (curlen != 0) {
# 6404 "gzip.c"
      if (curlen != prevlen) {
# 6405 "gzip.c"
        send_bits((int )bl_tree[curlen].fc.code, (int )bl_tree[curlen].dl.len);
# 6405 "gzip.c"
        count --;
      } else {

      }
# 6408 "gzip.c"
      send_bits((int )bl_tree[16].fc.code, (int )bl_tree[16].dl.len);
# 6408 "gzip.c"
      send_bits(count - 3, 2);
    } else
# 6410 "gzip.c"
    if (count <= 10) {
# 6411 "gzip.c"
      send_bits((int )bl_tree[17].fc.code, (int )bl_tree[17].dl.len);
# 6411 "gzip.c"
      send_bits(count - 3, 3);
    } else {
# 6414 "gzip.c"
      send_bits((int )bl_tree[18].fc.code, (int )bl_tree[18].dl.len);
# 6414 "gzip.c"
      send_bits(count - 11, 7);
    }
# 6416 "gzip.c"
    count = 0;
# 6416 "gzip.c"
    prevlen = curlen;
# 6417 "gzip.c"
    if (nextlen == 0) {
# 6418 "gzip.c"
      max_count = 138;
# 6418 "gzip.c"
      min_count = 3;
    } else
# 6419 "gzip.c"
    if (curlen == nextlen) {
# 6420 "gzip.c"
      max_count = 6;
# 6420 "gzip.c"
      min_count = 3;
    } else {
# 6422 "gzip.c"
      max_count = 7;
# 6422 "gzip.c"
      min_count = 4;
    }
    __Cont:
# 6396 "gzip.c"
    n ++;
  }
  while_break: ;
  }
# 6381 "gzip.c"
  return;
}
}
# 6431 "gzip.c"
static int build_bl_tree(void)
{
  int max_blindex ;

  {
# 6436 "gzip.c"
  scan_tree(dyn_ltree, l_desc.max_code);
# 6437 "gzip.c"
  scan_tree(dyn_dtree, d_desc.max_code);
# 6440 "gzip.c"
  build_tree_1(& bl_desc);
# 6449 "gzip.c"
  max_blindex = 18;
  {
# 6449 "gzip.c"
  while (1) {
    while_continue: ;
# 6449 "gzip.c"
    if (max_blindex >= 3) {

    } else {
# 6449 "gzip.c"
      goto while_break;
    }
# 6450 "gzip.c"
    if ((int )bl_tree[bl_order[max_blindex]].dl.len != 0) {
# 6450 "gzip.c"
      goto while_break;
    } else {

    }
# 6449 "gzip.c"
    max_blindex --;
  }
  while_break: ;
  }
# 6453 "gzip.c"
  opt_len += (ulg )(((3 * (max_blindex + 1) + 5) + 5) + 4);
# 6456 "gzip.c"
  return (max_blindex);
}
}
# 6464 "gzip.c"
static void send_all_trees(int lcodes , int dcodes , int blcodes )
{
  int rank ;

  {
# 6473 "gzip.c"
  send_bits(lcodes - 257, 5);
# 6474 "gzip.c"
  send_bits(dcodes - 1, 5);
# 6475 "gzip.c"
  send_bits(blcodes - 4, 4);
# 6476 "gzip.c"
  rank = 0;
  {
# 6476 "gzip.c"
  while (1) {
    while_continue: ;
# 6476 "gzip.c"
    if (rank < blcodes) {

    } else {
# 6476 "gzip.c"
      goto while_break;
    }
# 6478 "gzip.c"
    send_bits((int )bl_tree[bl_order[rank]].dl.len, 3);
# 6476 "gzip.c"
    rank ++;
  }
  while_break: ;
  }
# 6481 "gzip.c"
  send_tree(dyn_ltree, lcodes - 1);
# 6483 "gzip.c"
  send_tree(dyn_dtree, dcodes - 1);
# 6464 "gzip.c"
  return;
}
}
# 6491 "gzip.c"
off_t flush_block(char *buf , ulg stored_len , int pad , int eof )
{
  ulg opt_lenb ;
  ulg static_lenb ;
  int max_blindex ;
  off_t __retres8 ;

  {
# 6500 "gzip.c"
  flag_buf[last_flags] = flags;
# 6503 "gzip.c"
  if ((int )*file_type == 65535) {
# 6503 "gzip.c"
    set_file_type();
  } else {

  }
# 6506 "gzip.c"
  build_tree_1(& l_desc);
# 6509 "gzip.c"
  build_tree_1(& d_desc);
# 6518 "gzip.c"
  max_blindex = build_bl_tree();
# 6521 "gzip.c"
  opt_lenb = ((opt_len + 3UL) + 7UL) >> 3;
# 6522 "gzip.c"
  static_lenb = ((static_len + 3UL) + 7UL) >> 3;
# 6523 "gzip.c"
  input_len = (off_t )((ulg )input_len + stored_len);
# 6529 "gzip.c"
  if (static_lenb <= opt_lenb) {
# 6529 "gzip.c"
    opt_lenb = static_lenb;
  } else {

  }
# 6538 "gzip.c"
  if (stored_len <= opt_lenb) {
# 6538 "gzip.c"
    if (eof != 0) {
# 6538 "gzip.c"
      if (compressed_len == 0L) {
# 6538 "gzip.c"
        goto _L___2;
      } else {
# 6538 "gzip.c"
        goto _L___2;
      }
    } else {
# 6538 "gzip.c"
      goto _L___2;
    }
  } else
  _L___2:
# 6550 "gzip.c"
  if (stored_len + 4UL <= opt_lenb) {
# 6550 "gzip.c"
    if ((unsigned int )buf != (unsigned int )((char *)0)) {
# 6559 "gzip.c"
      send_bits(eof, 3);
# 6560 "gzip.c"
      compressed_len = ((compressed_len + 3L) + 7L) & -8L;
# 6561 "gzip.c"
      compressed_len = (off_t )((ulg )compressed_len + ((stored_len + 4UL) << 3));
# 6563 "gzip.c"
      copy_block(buf, (unsigned int )stored_len, 1);
    } else {
# 6550 "gzip.c"
      goto _L;
    }
  } else
  _L:
# 6568 "gzip.c"
  if (static_lenb == opt_lenb) {
# 6570 "gzip.c"
    send_bits((1 << 1) + eof, 3);
# 6571 "gzip.c"
    compress_block(static_ltree, static_dtree);
# 6572 "gzip.c"
    compressed_len = (off_t )((ulg )compressed_len + (3UL + static_len));
  } else {
# 6574 "gzip.c"
    send_bits((2 << 1) + eof, 3);
# 6575 "gzip.c"
    send_all_trees(l_desc.max_code + 1, d_desc.max_code + 1, max_blindex + 1);
# 6576 "gzip.c"
    compress_block(dyn_ltree, dyn_dtree);
# 6577 "gzip.c"
    compressed_len = (off_t )((ulg )compressed_len + (3UL + opt_len));
  }
# 6580 "gzip.c"
  init_block();
# 6582 "gzip.c"
  if (eof != 0) {
# 6584 "gzip.c"
    bi_windup();
# 6585 "gzip.c"
    compressed_len += 7L;
  } else
# 6586 "gzip.c"
  if (pad != 0) {
# 6586 "gzip.c"
    if (compressed_len % 8L != 0L) {
# 6587 "gzip.c"
      send_bits(eof, 3);
# 6588 "gzip.c"
      compressed_len = ((compressed_len + 3L) + 7L) & -8L;
# 6589 "gzip.c"
      copy_block(buf, 0U, 1);
    } else {

    }
  } else {

  }
# 6592 "gzip.c"
  __retres8 = compressed_len >> 3;
# 6491 "gzip.c"
  return (__retres8);
}
}
# 6599 "gzip.c"
int ct_tally(int dist , int lc )
{
  unsigned int tmp ;
  int tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int tmp___2 ;
  ulg out_length ;
  ulg in_length ;
  int dcode ;
  int tmp___3 ;
  int __retres11 ;

  {
# 6603 "gzip.c"
  tmp = last_lit;
# 6603 "gzip.c"
  last_lit ++;
# 6603 "gzip.c"
  inbuf[tmp] = (uch )lc;
# 6604 "gzip.c"
  if (dist == 0) {
# 6606 "gzip.c"
    dyn_ltree[lc].fc.freq = (ush )((int )dyn_ltree[lc].fc.freq + 1);
  } else {
# 6609 "gzip.c"
    dist --;
# 6614 "gzip.c"
    dyn_ltree[((int )length_code[lc] + 256) + 1].fc.freq = (ush )((int )dyn_ltree[((int )length_code[lc] + 256) + 1].fc.freq + 1);
# 6615 "gzip.c"
    if (dist < 256) {
# 6615 "gzip.c"
      tmp___0 = (int )dist_code[dist];
    } else {
# 6615 "gzip.c"
      tmp___0 = (int )dist_code[256 + (dist >> 7)];
    }
# 6615 "gzip.c"
    dyn_dtree[tmp___0].fc.freq = (ush )((int )dyn_dtree[tmp___0].fc.freq + 1);
# 6617 "gzip.c"
    tmp___1 = last_dist;
# 6617 "gzip.c"
    last_dist ++;
# 6617 "gzip.c"
    d_buf[tmp___1] = (ush )dist;
# 6618 "gzip.c"
    flags = (uch )((int )flags | (int )flag_bit);
  }
# 6620 "gzip.c"
  flag_bit = (uch )((int )flag_bit << 1);
# 6623 "gzip.c"
  if ((last_lit & 7U) == 0U) {
# 6624 "gzip.c"
    tmp___2 = last_flags;
# 6624 "gzip.c"
    last_flags ++;
# 6624 "gzip.c"
    flag_buf[tmp___2] = flags;
# 6625 "gzip.c"
    flags = (uch )0;
# 6625 "gzip.c"
    flag_bit = (uch )1;
  } else {

  }
# 6628 "gzip.c"
  if (level > 2) {
# 6628 "gzip.c"
    if ((last_lit & 4095U) == 0U) {
# 6630 "gzip.c"
      out_length = (ulg )last_lit * 8UL;
# 6631 "gzip.c"
      in_length = (ulg )strstart - (ulg )block_start;
# 6633 "gzip.c"
      dcode = 0;
      {
# 6633 "gzip.c"
      while (1) {
        while_continue: ;
# 6633 "gzip.c"
        if (dcode < 30) {

        } else {
# 6633 "gzip.c"
          goto while_break;
        }
# 6634 "gzip.c"
        out_length += (ulg )dyn_dtree[dcode].fc.freq * (ulg )(5L + (long )extra_dbits[dcode]);
# 6633 "gzip.c"
        dcode ++;
      }
      while_break: ;
      }
# 6636 "gzip.c"
      out_length >>= 3;
# 6640 "gzip.c"
      if (last_dist < last_lit / 2U) {
# 6640 "gzip.c"
        if (out_length < in_length / 2UL) {
# 6640 "gzip.c"
          __retres11 = 1;
# 6640 "gzip.c"
          goto return_label;
        } else {

        }
      } else {

      }
    } else {

    }
  } else {

  }
# 6642 "gzip.c"
  if (last_lit == 32767U) {
# 6642 "gzip.c"
    tmp___3 = 1;
  } else
# 6642 "gzip.c"
  if (last_dist == 32768U) {
# 6642 "gzip.c"
    tmp___3 = 1;
  } else {
# 6642 "gzip.c"
    tmp___3 = 0;
  }
# 6642 "gzip.c"
  __retres11 = tmp___3;
  return_label:
# 6599 "gzip.c"
  return (__retres11);
}
}
# 6652 "gzip.c"
static void compress_block(ct_data *ltree , ct_data *dtree )
{
  unsigned int dist ;
  int lc ;
  unsigned int lx ;
  unsigned int dx ;
  unsigned int fx ;
  uch flag ;
  unsigned int code ;
  int extra ;
  unsigned int tmp ;
  unsigned int tmp___0 ;
  unsigned int tmp___1 ;
  ct_data *mem_14 ;
  ct_data *mem_15 ;
  ct_data *mem_16 ;
  ct_data *mem_17 ;
  ct_data *mem_18 ;
  ct_data *mem_19 ;
  ct_data *mem_20 ;
  ct_data *mem_21 ;

  {
# 6658 "gzip.c"
  lx = 0U;
# 6659 "gzip.c"
  dx = 0U;
# 6660 "gzip.c"
  fx = 0U;
# 6661 "gzip.c"
  flag = (uch )0;
# 6665 "gzip.c"
  if (last_lit != 0U) {
    {
# 6665 "gzip.c"
    while (1) {
      while_continue: ;
# 6666 "gzip.c"
      if ((lx & 7U) == 0U) {
# 6666 "gzip.c"
        tmp = fx;
# 6666 "gzip.c"
        fx ++;
# 6666 "gzip.c"
        flag = flag_buf[tmp];
      } else {

      }
# 6667 "gzip.c"
      tmp___0 = lx;
# 6667 "gzip.c"
      lx ++;
# 6667 "gzip.c"
      lc = (int )inbuf[tmp___0];
# 6668 "gzip.c"
      if (((int )flag & 1) == 0) {
# 6669 "gzip.c"
        mem_14 = ltree + lc;
# 6669 "gzip.c"
        mem_15 = ltree + lc;
# 6669 "gzip.c"
        send_bits((int )mem_14->fc.code, (int )mem_15->dl.len);
      } else {
# 6673 "gzip.c"
        code = (unsigned int )length_code[lc];
# 6674 "gzip.c"
        mem_16 = ltree + ((code + 256U) + 1U);
# 6674 "gzip.c"
        mem_17 = ltree + ((code + 256U) + 1U);
# 6674 "gzip.c"
        send_bits((int )mem_16->fc.code, (int )mem_17->dl.len);
# 6675 "gzip.c"
        extra = extra_lbits[code];
# 6676 "gzip.c"
        if (extra != 0) {
# 6677 "gzip.c"
          lc -= base_length[code];
# 6678 "gzip.c"
          send_bits(lc, extra);
        } else {

        }
# 6680 "gzip.c"
        tmp___1 = dx;
# 6680 "gzip.c"
        dx ++;
# 6680 "gzip.c"
        dist = (unsigned int )d_buf[tmp___1];
# 6682 "gzip.c"
        if (dist < 256U) {
# 6682 "gzip.c"
          code = (unsigned int )dist_code[dist];
        } else {
# 6682 "gzip.c"
          code = (unsigned int )dist_code[256U + (dist >> 7)];
        }
# 6685 "gzip.c"
        mem_18 = dtree + code;
# 6685 "gzip.c"
        mem_19 = dtree + code;
# 6685 "gzip.c"
        send_bits((int )mem_18->fc.code, (int )mem_19->dl.len);
# 6686 "gzip.c"
        extra = extra_dbits[code];
# 6687 "gzip.c"
        if (extra != 0) {
# 6688 "gzip.c"
          dist -= (unsigned int )base_dist[code];
# 6689 "gzip.c"
          send_bits((int )dist, extra);
        } else {

        }
      }
# 6692 "gzip.c"
      flag = (uch )((int )flag >> 1);
# 6665 "gzip.c"
      if (lx < last_lit) {

      } else {
# 6665 "gzip.c"
        goto while_break;
      }
    }
    while_break: ;
    }
  } else {

  }
# 6695 "gzip.c"
  mem_20 = ltree + 256;
# 6695 "gzip.c"
  mem_21 = ltree + 256;
# 6695 "gzip.c"
  send_bits((int )mem_20->fc.code, (int )mem_21->dl.len);
# 6652 "gzip.c"
  return;
}
}
# 6704 "gzip.c"
static void set_file_type(void)
{
  int n ;
  unsigned int ascii_freq ;
  unsigned int bin_freq ;
  int tmp ;
  int tmp___0 ;
  int tmp___1 ;

  {
# 6706 "gzip.c"
  n = 0;
# 6707 "gzip.c"
  ascii_freq = 0U;
# 6708 "gzip.c"
  bin_freq = 0U;
  {
# 6709 "gzip.c"
  while (1) {
    while_continue: ;
# 6709 "gzip.c"
    if (n < 7) {

    } else {
# 6709 "gzip.c"
      goto while_break;
    }
# 6709 "gzip.c"
    tmp = n;
# 6709 "gzip.c"
    n ++;
# 6709 "gzip.c"
    bin_freq += (unsigned int )dyn_ltree[tmp].fc.freq;
  }
  while_break: ;
  }
  {
# 6710 "gzip.c"
  while (1) {
    while_continue___0: ;
# 6710 "gzip.c"
    if (n < 128) {

    } else {
# 6710 "gzip.c"
      goto while_break___0;
    }
# 6710 "gzip.c"
    tmp___0 = n;
# 6710 "gzip.c"
    n ++;
# 6710 "gzip.c"
    ascii_freq += (unsigned int )dyn_ltree[tmp___0].fc.freq;
  }
  while_break___0: ;
  }
  {
# 6711 "gzip.c"
  while (1) {
    while_continue___1: ;
# 6711 "gzip.c"
    if (n < 256) {

    } else {
# 6711 "gzip.c"
      goto while_break___1;
    }
# 6711 "gzip.c"
    tmp___1 = n;
# 6711 "gzip.c"
    n ++;
# 6711 "gzip.c"
    bin_freq += (unsigned int )dyn_ltree[tmp___1].fc.freq;
  }
  while_break___1: ;
  }
# 6712 "gzip.c"
  if (bin_freq > ascii_freq >> 2) {
# 6712 "gzip.c"
    *file_type = (ush )0;
  } else {
# 6712 "gzip.c"
    *file_type = (ush )1;
  }
# 6713 "gzip.c"
  if ((int )*file_type == 0) {

  } else {

  }
# 6704 "gzip.c"
  return;
}
}
# 6728 "gzip.c"
static unsigned int decode(unsigned int count , uch *buffer ) ;
# 6729 "gzip.c"
static void decode_start(void) ;
# 6732 "gzip.c"
static void huf_decode_start(void) ;
# 6733 "gzip.c"
static unsigned int decode_c(void) ;
# 6734 "gzip.c"
static unsigned int decode_p(void) ;
# 6735 "gzip.c"
static void read_pt_len(int nn , int nbit , int i_special ) ;
# 6736 "gzip.c"
static void read_c_len(void) ;
# 6739 "gzip.c"
static void fillbuf(int n ) ;
# 6740 "gzip.c"
static unsigned int getbits(int n ) ;
# 6741 "gzip.c"
static void init_getbits(void) ;
# 6745 "gzip.c"
static void make_table(int nchar , uch *bitlen , int tablebits , ush *table ) ;
# 6801 "gzip.c"
static uch pt_len[19] ;
# 6802 "gzip.c"
static unsigned int blocksize ;
# 6803 "gzip.c"
static ush pt_table[256] ;
# 6815 "gzip.c"
static ush io_bitbuf ;
# 6816 "gzip.c"
static unsigned int subbitbuf ;
# 6817 "gzip.c"
static int bitcount ;
# 6819 "gzip.c"
static void fillbuf(int n )
{
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;

  {
# 6822 "gzip.c"
  io_bitbuf = (ush )((int )io_bitbuf << n);
  {
# 6823 "gzip.c"
  while (1) {
    while_continue: ;
# 6823 "gzip.c"
    if (n > bitcount) {

    } else {
# 6823 "gzip.c"
      goto while_break;
    }
# 6824 "gzip.c"
    n -= bitcount;
# 6824 "gzip.c"
    io_bitbuf = (ush )((unsigned int )io_bitbuf | (subbitbuf << n));
# 6825 "gzip.c"
    if (inptr < insize) {
# 6825 "gzip.c"
      tmp = inptr;
# 6825 "gzip.c"
      inptr ++;
# 6825 "gzip.c"
      tmp___1 = (int )inbuf[tmp];
    } else {
# 6825 "gzip.c"
      tmp___0 = fill_inbuf(1);
# 6825 "gzip.c"
      tmp___1 = tmp___0;
    }
# 6825 "gzip.c"
    subbitbuf = (unsigned int )tmp___1;
# 6826 "gzip.c"
    if ((int )subbitbuf == -1) {
# 6826 "gzip.c"
      subbitbuf = 0U;
    } else {

    }
# 6827 "gzip.c"
    bitcount = 8;
  }
  while_break: ;
  }
# 6829 "gzip.c"
  bitcount -= n;
# 6829 "gzip.c"
  io_bitbuf = (ush )((unsigned int )io_bitbuf | (subbitbuf >> bitcount));
# 6819 "gzip.c"
  return;
}
}
# 6832 "gzip.c"
static unsigned int getbits(int n )
{
  unsigned int x ;

  {
# 6837 "gzip.c"
  x = (unsigned int )((int )io_bitbuf >> (16U * sizeof(char ) - (unsigned int )n));
# 6837 "gzip.c"
  fillbuf(n);
# 6838 "gzip.c"
  return (x);
}
}
# 6841 "gzip.c"
static void init_getbits(void)
{


  {
# 6843 "gzip.c"
  io_bitbuf = (ush )0;
# 6843 "gzip.c"
  subbitbuf = 0U;
# 6843 "gzip.c"
  bitcount = 0;
# 6844 "gzip.c"
  fillbuf((int )(16U * sizeof(char )));
# 6841 "gzip.c"
  return;
}
}
# 6851 "gzip.c"
static void make_table(int nchar , uch *bitlen , int tablebits , ush *table )
{
  ush count[17] ;
  ush weight[17] ;
  ush start[18] ;
  ush *p ;
  unsigned int i ;
  unsigned int k ;
  unsigned int len ;
  unsigned int ch ;
  unsigned int jutbits ;
  unsigned int avail ;
  unsigned int nextcode ;
  unsigned int mask ;
  unsigned int tmp ;
  ush tmp___0 ;
  unsigned int tmp___1 ;
  uch *mem_20 ;
  uch *mem_21 ;
  ush *mem_22 ;
  uch *mem_23 ;
  ush *mem_24 ;
  ush *mem_25 ;

  {
# 6860 "gzip.c"
  i = 1U;
  {
# 6860 "gzip.c"
  while (1) {
    while_continue: ;
# 6860 "gzip.c"
    if (i <= 16U) {

    } else {
# 6860 "gzip.c"
      goto while_break;
    }
# 6860 "gzip.c"
    count[i] = (ush )0;
# 6860 "gzip.c"
    i ++;
  }
  while_break: ;
  }
# 6861 "gzip.c"
  i = 0U;
  {
# 6861 "gzip.c"
  while (1) {
    while_continue___0: ;
# 6861 "gzip.c"
    if (i < (unsigned int )nchar) {

    } else {
# 6861 "gzip.c"
      goto while_break___0;
    }
# 6861 "gzip.c"
    mem_20 = bitlen + i;
# 6861 "gzip.c"
    mem_21 = bitlen + i;
# 6861 "gzip.c"
    count[*mem_20] = (ush )((int )count[*mem_21] + 1);
# 6861 "gzip.c"
    i ++;
  }
  while_break___0: ;
  }
# 6863 "gzip.c"
  start[1] = (ush )0;
# 6864 "gzip.c"
  i = 1U;
  {
# 6864 "gzip.c"
  while (1) {
    while_continue___1: ;
# 6864 "gzip.c"
    if (i <= 16U) {

    } else {
# 6864 "gzip.c"
      goto while_break___1;
    }
# 6865 "gzip.c"
    start[i + 1U] = (ush )((int )start[i] + ((int )count[i] << (16U - i)));
# 6864 "gzip.c"
    i ++;
  }
  while_break___1: ;
  }
# 6866 "gzip.c"
  if (((int )start[17] & 65535) != 0) {
# 6867 "gzip.c"
    error((char *)"Bad table\n");
  } else {

  }
# 6869 "gzip.c"
  jutbits = (unsigned int )(16 - tablebits);
# 6870 "gzip.c"
  i = 1U;
  {
# 6870 "gzip.c"
  while (1) {
    while_continue___2: ;
# 6870 "gzip.c"
    if (i <= (unsigned int )tablebits) {

    } else {
# 6870 "gzip.c"
      goto while_break___2;
    }
# 6871 "gzip.c"
    start[i] = (ush )((int )start[i] >> jutbits);
# 6872 "gzip.c"
    weight[i] = (ush )(1U << ((unsigned int )tablebits - i));
# 6870 "gzip.c"
    i ++;
  }
  while_break___2: ;
  }
  {
# 6874 "gzip.c"
  while (1) {
    while_continue___3: ;
# 6874 "gzip.c"
    if (i <= 16U) {

    } else {
# 6874 "gzip.c"
      goto while_break___3;
    }
# 6875 "gzip.c"
    weight[i] = (ush )(1U << (16U - i));
# 6876 "gzip.c"
    i ++;
  }
  while_break___3: ;
  }
# 6879 "gzip.c"
  i = (unsigned int )((int )start[tablebits + 1] >> jutbits);
# 6880 "gzip.c"
  if (i != 0U) {
# 6881 "gzip.c"
    k = (unsigned int )(1 << tablebits);
    {
# 6882 "gzip.c"
    while (1) {
      while_continue___4: ;
# 6882 "gzip.c"
      if (i != k) {

      } else {
# 6882 "gzip.c"
        goto while_break___4;
      }
# 6882 "gzip.c"
      tmp = i;
# 6882 "gzip.c"
      i ++;
# 6882 "gzip.c"
      mem_22 = table + tmp;
# 6882 "gzip.c"
      *mem_22 = (ush )0;
    }
    while_break___4: ;
    }
  } else {

  }
# 6885 "gzip.c"
  avail = (unsigned int )nchar;
# 6886 "gzip.c"
  mask = 1U << (15 - tablebits);
# 6887 "gzip.c"
  ch = 0U;
  {
# 6887 "gzip.c"
  while (1) {
    while_continue___5: ;
# 6887 "gzip.c"
    if (ch < (unsigned int )nchar) {

    } else {
# 6887 "gzip.c"
      goto while_break___5;
    }
# 6888 "gzip.c"
    mem_23 = bitlen + ch;
# 6888 "gzip.c"
    len = (unsigned int )*mem_23;
# 6888 "gzip.c"
    if (len == 0U) {
# 6888 "gzip.c"
      goto __Cont;
    } else {

    }
# 6889 "gzip.c"
    nextcode = (unsigned int )((int )start[len] + (int )weight[len]);
# 6890 "gzip.c"
    if (len <= (unsigned int )tablebits) {
# 6891 "gzip.c"
      i = (unsigned int )start[len];
      {
# 6891 "gzip.c"
      while (1) {
        while_continue___6: ;
# 6891 "gzip.c"
        if (i < nextcode) {

        } else {
# 6891 "gzip.c"
          goto while_break___6;
        }
# 6891 "gzip.c"
        mem_24 = table + i;
# 6891 "gzip.c"
        *mem_24 = (ush )ch;
# 6891 "gzip.c"
        i ++;
      }
      while_break___6: ;
      }
    } else {
# 6893 "gzip.c"
      k = (unsigned int )start[len];
# 6894 "gzip.c"
      p = table + (k >> jutbits);
# 6895 "gzip.c"
      i = len - (unsigned int )tablebits;
      {
# 6896 "gzip.c"
      while (1) {
        while_continue___7: ;
# 6896 "gzip.c"
        if (i != 0U) {

        } else {
# 6896 "gzip.c"
          goto while_break___7;
        }
# 6897 "gzip.c"
        if ((int )*p == 0) {
# 6898 "gzip.c"
          tmp___0 = (ush )0;
# 6898 "gzip.c"
          prev[avail] = tmp___0;
# 6898 "gzip.c"
          mem_25 = (prev + 32768) + avail;
# 6898 "gzip.c"
          *mem_25 = tmp___0;
# 6899 "gzip.c"
          tmp___1 = avail;
# 6899 "gzip.c"
          avail ++;
# 6899 "gzip.c"
          *p = (ush )tmp___1;
        } else {

        }
# 6901 "gzip.c"
        if ((k & mask) != 0) {
# 6901 "gzip.c"
          p = (prev + 32768) + *p;
        } else {
# 6902 "gzip.c"
          p = & prev[*p];
        }
# 6903 "gzip.c"
        k <<= 1;
# 6903 "gzip.c"
        i --;
      }
      while_break___7: ;
      }
# 6905 "gzip.c"
      *p = (ush )ch;
    }
# 6907 "gzip.c"
    start[len] = (ush )nextcode;
    __Cont:
# 6887 "gzip.c"
    ch ++;
  }
  while_break___5: ;
  }
# 6851 "gzip.c"
  return;
}
}
# 6915 "gzip.c"
static void read_pt_len(int nn , int nbit , int i_special )
{
  int i ;
  int c ;
  int n ;
  unsigned int mask ;
  unsigned int tmp ;
  unsigned int tmp___0 ;
  int tmp___1 ;
  int tmp___2 ;
  unsigned int tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;

  {
# 6923 "gzip.c"
  tmp = getbits(nbit);
# 6923 "gzip.c"
  n = (int )tmp;
# 6924 "gzip.c"
  if (n == 0) {
# 6925 "gzip.c"
    tmp___0 = getbits(nbit);
# 6925 "gzip.c"
    c = (int )tmp___0;
# 6926 "gzip.c"
    i = 0;
    {
# 6926 "gzip.c"
    while (1) {
      while_continue: ;
# 6926 "gzip.c"
      if (i < nn) {

      } else {
# 6926 "gzip.c"
        goto while_break;
      }
# 6926 "gzip.c"
      pt_len[i] = (uch )0;
# 6926 "gzip.c"
      i ++;
    }
    while_break: ;
    }
# 6927 "gzip.c"
    i = 0;
    {
# 6927 "gzip.c"
    while (1) {
      while_continue___0: ;
# 6927 "gzip.c"
      if (i < 256) {

      } else {
# 6927 "gzip.c"
        goto while_break___0;
      }
# 6927 "gzip.c"
      pt_table[i] = (ush )c;
# 6927 "gzip.c"
      i ++;
    }
    while_break___0: ;
    }
  } else {
# 6929 "gzip.c"
    i = 0;
    {
# 6930 "gzip.c"
    while (1) {
      while_continue___1: ;
# 6930 "gzip.c"
      if (i < n) {

      } else {
# 6930 "gzip.c"
        goto while_break___1;
      }
# 6931 "gzip.c"
      c = (int )io_bitbuf >> (16U * sizeof(char ) - 3U);
# 6932 "gzip.c"
      if (c == 7) {
# 6933 "gzip.c"
        mask = 1U << ((16U * sizeof(char ) - 1U) - 3U);
        {
# 6934 "gzip.c"
        while (1) {
          while_continue___2: ;
# 6934 "gzip.c"
          if ((mask & (unsigned int )io_bitbuf) != 0) {

          } else {
# 6934 "gzip.c"
            goto while_break___2;
          }
# 6934 "gzip.c"
          mask >>= 1;
# 6934 "gzip.c"
          c ++;
        }
        while_break___2: ;
        }
      } else {

      }
# 6936 "gzip.c"
      if (c < 7) {
# 6936 "gzip.c"
        tmp___1 = 3;
      } else {
# 6936 "gzip.c"
        tmp___1 = c - 3;
      }
# 6936 "gzip.c"
      fillbuf(tmp___1);
# 6937 "gzip.c"
      tmp___2 = i;
# 6937 "gzip.c"
      i ++;
# 6937 "gzip.c"
      pt_len[tmp___2] = (uch )c;
# 6938 "gzip.c"
      if (i == i_special) {
# 6939 "gzip.c"
        tmp___3 = getbits(2);
# 6939 "gzip.c"
        c = (int )tmp___3;
        {
# 6940 "gzip.c"
        while (1) {
          while_continue___3: ;
# 6940 "gzip.c"
          c --;
# 6940 "gzip.c"
          if (c >= 0) {

          } else {
# 6940 "gzip.c"
            goto while_break___3;
          }
# 6940 "gzip.c"
          tmp___4 = i;
# 6940 "gzip.c"
          i ++;
# 6940 "gzip.c"
          pt_len[tmp___4] = (uch )0;
        }
        while_break___3: ;
        }
      } else {

      }
    }
    while_break___1: ;
    }
    {
# 6943 "gzip.c"
    while (1) {
      while_continue___4: ;
# 6943 "gzip.c"
      if (i < nn) {

      } else {
# 6943 "gzip.c"
        goto while_break___4;
      }
# 6943 "gzip.c"
      tmp___5 = i;
# 6943 "gzip.c"
      i ++;
# 6943 "gzip.c"
      pt_len[tmp___5] = (uch )0;
    }
    while_break___4: ;
    }
# 6944 "gzip.c"
    make_table(nn, pt_len, 8, pt_table);
  }
# 6915 "gzip.c"
  return;
}
}
# 6948 "gzip.c"
static void read_c_len(void)
{
  int i ;
  int c ;
  int n ;
  unsigned int mask ;
  unsigned int tmp ;
  unsigned int tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  int tmp___5 ;
  ush *mem_12 ;

  {
# 6953 "gzip.c"
  tmp = getbits(9);
# 6953 "gzip.c"
  n = (int )tmp;
# 6954 "gzip.c"
  if (n == 0) {
# 6955 "gzip.c"
    tmp___0 = getbits(9);
# 6955 "gzip.c"
    c = (int )tmp___0;
# 6956 "gzip.c"
    i = 0;
    {
# 6956 "gzip.c"
    while (1) {
      while_continue: ;
# 6956 "gzip.c"
      if (i < 510) {

      } else {
# 6956 "gzip.c"
        goto while_break;
      }
# 6956 "gzip.c"
      outbuf[i] = (uch )0;
# 6956 "gzip.c"
      i ++;
    }
    while_break: ;
    }
# 6957 "gzip.c"
    i = 0;
    {
# 6957 "gzip.c"
    while (1) {
      while_continue___0: ;
# 6957 "gzip.c"
      if (i < 4096) {

      } else {
# 6957 "gzip.c"
        goto while_break___0;
      }
# 6957 "gzip.c"
      d_buf[i] = (ush )c;
# 6957 "gzip.c"
      i ++;
    }
    while_break___0: ;
    }
  } else {
# 6959 "gzip.c"
    i = 0;
    {
# 6960 "gzip.c"
    while (1) {
      while_continue___1: ;
# 6960 "gzip.c"
      if (i < n) {

      } else {
# 6960 "gzip.c"
        goto while_break___1;
      }
# 6961 "gzip.c"
      c = (int )pt_table[(int )io_bitbuf >> (16U * sizeof(char ) - 8U)];
# 6962 "gzip.c"
      if (c >= 19) {
# 6963 "gzip.c"
        mask = 1U << ((16U * sizeof(char ) - 1U) - 8U);
        {
# 6964 "gzip.c"
        while (1) {
          while_continue___2: ;
# 6965 "gzip.c"
          if (((unsigned int )io_bitbuf & mask) != 0) {
# 6965 "gzip.c"
            mem_12 = (prev + 32768) + c;
# 6965 "gzip.c"
            c = (int )*mem_12;
          } else {
# 6966 "gzip.c"
            c = (int )prev[c];
          }
# 6967 "gzip.c"
          mask >>= 1;
# 6964 "gzip.c"
          if (c >= 19) {

          } else {
# 6964 "gzip.c"
            goto while_break___2;
          }
        }
        while_break___2: ;
        }
      } else {

      }
# 6970 "gzip.c"
      fillbuf((int )pt_len[c]);
# 6971 "gzip.c"
      if (c <= 2) {
# 6972 "gzip.c"
        if (c == 0) {
# 6972 "gzip.c"
          c = 1;
        } else
# 6973 "gzip.c"
        if (c == 1) {
# 6973 "gzip.c"
          tmp___1 = getbits(4);
# 6973 "gzip.c"
          c = (int )(tmp___1 + 3U);
        } else {
# 6974 "gzip.c"
          tmp___2 = getbits(9);
# 6974 "gzip.c"
          c = (int )(tmp___2 + 20U);
        }
        {
# 6975 "gzip.c"
        while (1) {
          while_continue___3: ;
# 6975 "gzip.c"
          c --;
# 6975 "gzip.c"
          if (c >= 0) {

          } else {
# 6975 "gzip.c"
            goto while_break___3;
          }
# 6975 "gzip.c"
          tmp___3 = i;
# 6975 "gzip.c"
          i ++;
# 6975 "gzip.c"
          outbuf[tmp___3] = (uch )0;
        }
        while_break___3: ;
        }
      } else {
# 6976 "gzip.c"
        tmp___4 = i;
# 6976 "gzip.c"
        i ++;
# 6976 "gzip.c"
        outbuf[tmp___4] = (uch )(c - 2);
      }
    }
    while_break___1: ;
    }
    {
# 6978 "gzip.c"
    while (1) {
      while_continue___4: ;
# 6978 "gzip.c"
      if (i < 510) {

      } else {
# 6978 "gzip.c"
        goto while_break___4;
      }
# 6978 "gzip.c"
      tmp___5 = i;
# 6978 "gzip.c"
      i ++;
# 6978 "gzip.c"
      outbuf[tmp___5] = (uch )0;
    }
    while_break___4: ;
    }
# 6979 "gzip.c"
    make_table(510, outbuf, 12, d_buf);
  }
# 6948 "gzip.c"
  return;
}
}
# 6983 "gzip.c"
static unsigned int decode_c(void)
{
  unsigned int j ;
  unsigned int mask ;
  ush *mem_3 ;
  unsigned int __retres4 ;

  {
# 6987 "gzip.c"
  if (blocksize == 0U) {
# 6988 "gzip.c"
    blocksize = getbits(16);
# 6989 "gzip.c"
    if (blocksize == 0U) {
# 6990 "gzip.c"
      __retres4 = 510U;
# 6990 "gzip.c"
      goto return_label;
    } else {

    }
# 6992 "gzip.c"
    read_pt_len(19, 5, 3);
# 6993 "gzip.c"
    read_c_len();
# 6994 "gzip.c"
    read_pt_len(14, 4, -1);
  } else {

  }
# 6996 "gzip.c"
  blocksize --;
# 6997 "gzip.c"
  j = (unsigned int )d_buf[(int )io_bitbuf >> (16U * sizeof(char ) - 12U)];
# 6998 "gzip.c"
  if (j >= 510U) {
# 6999 "gzip.c"
    mask = 1U << ((16U * sizeof(char ) - 1U) - 12U);
    {
# 7000 "gzip.c"
    while (1) {
      while_continue: ;
# 7001 "gzip.c"
      if (((unsigned int )io_bitbuf & mask) != 0) {
# 7001 "gzip.c"
        mem_3 = (prev + 32768) + j;
# 7001 "gzip.c"
        j = (unsigned int )*mem_3;
      } else {
# 7002 "gzip.c"
        j = (unsigned int )prev[j];
      }
# 7003 "gzip.c"
      mask >>= 1;
# 7000 "gzip.c"
      if (j >= 510U) {

      } else {
# 7000 "gzip.c"
        goto while_break;
      }
    }
    while_break: ;
    }
  } else {

  }
# 7006 "gzip.c"
  fillbuf((int )outbuf[j]);
# 7007 "gzip.c"
  __retres4 = j;
  return_label:
# 6983 "gzip.c"
  return (__retres4);
}
}
# 7010 "gzip.c"
static unsigned int decode_p(void)
{
  unsigned int j ;
  unsigned int mask ;
  unsigned int tmp ;
  ush *mem_4 ;

  {
# 7014 "gzip.c"
  j = (unsigned int )pt_table[(int )io_bitbuf >> (16U * sizeof(char ) - 8U)];
# 7015 "gzip.c"
  if (j >= 14U) {
# 7016 "gzip.c"
    mask = 1U << ((16U * sizeof(char ) - 1U) - 8U);
    {
# 7017 "gzip.c"
    while (1) {
      while_continue: ;
# 7018 "gzip.c"
      if (((unsigned int )io_bitbuf & mask) != 0) {
# 7018 "gzip.c"
        mem_4 = (prev + 32768) + j;
# 7018 "gzip.c"
        j = (unsigned int )*mem_4;
      } else {
# 7019 "gzip.c"
        j = (unsigned int )prev[j];
      }
# 7020 "gzip.c"
      mask >>= 1;
# 7017 "gzip.c"
      if (j >= 14U) {

      } else {
# 7017 "gzip.c"
        goto while_break;
      }
    }
    while_break: ;
    }
  } else {

  }
# 7023 "gzip.c"
  fillbuf((int )pt_len[j]);
# 7024 "gzip.c"
  if (j != 0U) {
# 7024 "gzip.c"
    tmp = getbits((int )(j - 1U));
# 7024 "gzip.c"
    j = (1U << (j - 1U)) + tmp;
  } else {

  }
# 7025 "gzip.c"
  return (j);
}
}
# 7028 "gzip.c"
static void huf_decode_start(void)
{


  {
# 7030 "gzip.c"
  init_getbits();
# 7030 "gzip.c"
  blocksize = 0U;
# 7028 "gzip.c"
  return;
}
}
# 7037 "gzip.c"
static int j ;
# 7038 "gzip.c"
static int done ;
# 7040 "gzip.c"
static void decode_start(void)
{


  {
# 7042 "gzip.c"
  huf_decode_start();
# 7043 "gzip.c"
  j = 0;
# 7044 "gzip.c"
  done = 0;
# 7040 "gzip.c"
  return;
}
}
# 7061 "gzip.c"
static unsigned int i ;
# 7049 "gzip.c"
static unsigned int decode(unsigned int count , uch *buffer )
{
  unsigned int r ;
  unsigned int c ;
  unsigned int tmp ;
  uch *mem_6 ;
  uch *mem_7 ;
  uch *mem_8 ;
  uch *mem_9 ;
  uch *mem_10 ;
  unsigned int __retres11 ;

  {
# 7064 "gzip.c"
  r = 0U;
  {
# 7065 "gzip.c"
  while (1) {
    while_continue: ;
# 7065 "gzip.c"
    j --;
# 7065 "gzip.c"
    if (j >= 0) {

    } else {
# 7065 "gzip.c"
      goto while_break;
    }
# 7066 "gzip.c"
    mem_6 = buffer + r;
# 7066 "gzip.c"
    mem_7 = buffer + i;
# 7066 "gzip.c"
    *mem_6 = *mem_7;
# 7067 "gzip.c"
    i = (i + 1U) & ((1U << 13) - 1U);
# 7068 "gzip.c"
    r ++;
# 7068 "gzip.c"
    if (r == count) {
# 7068 "gzip.c"
      __retres11 = r;
# 7068 "gzip.c"
      goto return_label;
    } else {

    }
  }
  while_break: ;
  }
  {
# 7070 "gzip.c"
  while (1) {
    while_continue___0: ;
# 7071 "gzip.c"
    c = decode_c();
# 7072 "gzip.c"
    if (c == 510U) {
# 7073 "gzip.c"
      done = 1;
# 7074 "gzip.c"
      __retres11 = r;
# 7074 "gzip.c"
      goto return_label;
    } else {

    }
# 7076 "gzip.c"
    if (c <= 255U) {
# 7077 "gzip.c"
      mem_8 = buffer + r;
# 7077 "gzip.c"
      *mem_8 = (uch )c;
# 7078 "gzip.c"
      r ++;
# 7078 "gzip.c"
      if (r == count) {
# 7078 "gzip.c"
        __retres11 = r;
# 7078 "gzip.c"
        goto return_label;
      } else {

      }
    } else {
# 7080 "gzip.c"
      j = (int )(c - 253U);
# 7081 "gzip.c"
      tmp = decode_p();
# 7081 "gzip.c"
      i = ((r - tmp) - 1U) & ((1U << 13) - 1U);
      {
# 7082 "gzip.c"
      while (1) {
        while_continue___1: ;
# 7082 "gzip.c"
        j --;
# 7082 "gzip.c"
        if (j >= 0) {

        } else {
# 7082 "gzip.c"
          goto while_break___1;
        }
# 7083 "gzip.c"
        mem_9 = buffer + r;
# 7083 "gzip.c"
        mem_10 = buffer + i;
# 7083 "gzip.c"
        *mem_9 = *mem_10;
# 7084 "gzip.c"
        i = (i + 1U) & ((1U << 13) - 1U);
# 7085 "gzip.c"
        r ++;
# 7085 "gzip.c"
        if (r == count) {
# 7085 "gzip.c"
          __retres11 = r;
# 7085 "gzip.c"
          goto return_label;
        } else {

        }
      }
      while_break___1: ;
      }
    }
  }
  while_break___0: ;
  }
  return_label:
# 7049 "gzip.c"
  return (__retres11);
}
}
# 7095 "gzip.c"
int unlzh(int in , int out )
{
  unsigned int n ;
  int __retres4 ;

  {
# 7100 "gzip.c"
  ifd = in;
# 7101 "gzip.c"
  ofd = out;
# 7103 "gzip.c"
  decode_start();
  {
# 7104 "gzip.c"
  while (1) {
    while_continue: ;
# 7104 "gzip.c"
    if (done == 0) {

    } else {
# 7104 "gzip.c"
      goto while_break;
    }
# 7105 "gzip.c"
    n = decode(1U << 13, window);
# 7106 "gzip.c"
    if (test == 0) {
# 7106 "gzip.c"
      if (n > 0U) {
# 7107 "gzip.c"
        write_buf(out, (voidp )((char *)(window)), n);
      } else {

      }
    } else {

    }
  }
  while_break: ;
  }
# 7110 "gzip.c"
  __retres4 = 0;
# 7095 "gzip.c"
  return (__retres4);
}
}
# 7278 "gzip.c"
int block_mode = 128;
# 7289 "gzip.c"
int unlzw(int in , int out )
{
  register char_type *stackp ;
  code_int code ;
  int finchar ;
  code_int oldcode ;
  code_int incode ;
  long inbits ;
  long posbits ;
  int outpos ;
  unsigned int bitmask ;
  code_int free_ent ;
  code_int maxcode ;
  code_int maxmaxcode ;
  int n_bits ;
  int rsize ;
  unsigned int tmp ;
  int tmp___0 ;
  register int i___0 ;
  int e ;
  int o ;
  register char_type *p ;
  int tmp___1 ;
  char const *tmp___2 ;
  register int i___1 ;
  char_type *mem_26 ;
  char_type *mem_27 ;
  char_type *mem_28 ;
  int __retres29 ;

  {
# 7312 "gzip.c"
  if (inptr < insize) {
# 7312 "gzip.c"
    tmp = inptr;
# 7312 "gzip.c"
    inptr ++;
# 7312 "gzip.c"
    maxbits = (int )inbuf[tmp];
  } else {
# 7312 "gzip.c"
    tmp___0 = fill_inbuf(0);
# 7312 "gzip.c"
    maxbits = tmp___0;
  }
# 7313 "gzip.c"
  block_mode = maxbits & 128;
# 7314 "gzip.c"
  if ((maxbits & 96) != 0) {
# 7315 "gzip.c"
    if (quiet == 0) {
# 7315 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: warning, unknown flags 0x%x\n",
              progname, ifname, maxbits & 96);
    } else {

    }
# 7315 "gzip.c"
    if (exit_code == 0) {
# 7315 "gzip.c"
      exit_code = 2;
    } else {

    }
  } else {

  }
# 7318 "gzip.c"
  maxbits &= 31;
# 7319 "gzip.c"
  maxmaxcode = 1L << maxbits;
# 7321 "gzip.c"
  if (maxbits > 16) {
# 7322 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: compressed with %d bits, can only handle %d bits\n",
            progname, ifname, maxbits, 16);
# 7325 "gzip.c"
    exit_code = 1;
# 7326 "gzip.c"
    __retres29 = 1;
# 7326 "gzip.c"
    goto return_label;
  } else {

  }
# 7328 "gzip.c"
  rsize = (int )insize;
# 7329 "gzip.c"
  n_bits = 9;
# 7329 "gzip.c"
  maxcode = (1L << n_bits) - 1L;
# 7330 "gzip.c"
  bitmask = (unsigned int )((1 << n_bits) - 1);
# 7331 "gzip.c"
  oldcode = (code_int )-1;
# 7332 "gzip.c"
  finchar = 0;
# 7333 "gzip.c"
  outpos = 0;
# 7334 "gzip.c"
  posbits = (long )(inptr << 3);
# 7336 "gzip.c"
  if (block_mode != 0) {
# 7336 "gzip.c"
    free_ent = (code_int )257;
  } else {
# 7336 "gzip.c"
    free_ent = (code_int )256;
  }
# 7338 "gzip.c"
  memset((voidp )(prev), 0, (size_t )256);
# 7340 "gzip.c"
  code = (code_int )255;
  {
# 7340 "gzip.c"
  while (1) {
    while_continue: ;
# 7340 "gzip.c"
    if (code >= 0L) {

    } else {
# 7340 "gzip.c"
      goto while_break;
    }
# 7341 "gzip.c"
    window[code] = (char_type )code;
# 7340 "gzip.c"
    code --;
  }
  while_break: ;
  }
  {
# 7343 "gzip.c"
  while (1) {
    while_continue___0: ;
    resetbuf:
# 7349 "gzip.c"
    o = (int )(posbits >> 3);
# 7349 "gzip.c"
    e = (int )(insize - (unsigned int )o);
# 7351 "gzip.c"
    i___0 = 0;
    {
# 7351 "gzip.c"
    while (1) {
      while_continue___1: ;
# 7351 "gzip.c"
      if (i___0 < e) {

      } else {
# 7351 "gzip.c"
        goto while_break___1;
      }
# 7352 "gzip.c"
      inbuf[i___0] = inbuf[i___0 + o];
# 7351 "gzip.c"
      i___0 ++;
    }
    while_break___1: ;
    }
# 7354 "gzip.c"
    insize = (unsigned int )e;
# 7355 "gzip.c"
    posbits = 0L;
# 7357 "gzip.c"
    if (insize < 64U) {
# 7358 "gzip.c"
      rsize = read(in, (void *)((char *)(inbuf) + insize), (size_t )32768);
# 7358 "gzip.c"
      if (rsize == -1) {
# 7359 "gzip.c"
        read_error();
      } else {

      }
# 7361 "gzip.c"
      insize += (unsigned int )rsize;
# 7362 "gzip.c"
      bytes_in += (off_t )rsize;
    } else {

    }
# 7364 "gzip.c"
    if (rsize != 0) {
# 7364 "gzip.c"
      inbits = (long )(((unsigned long )((long )insize) - (unsigned long )(insize % (unsigned int )n_bits)) << 3);
    } else {
# 7364 "gzip.c"
      inbits = ((long )insize << 3) - (long )(n_bits - 1);
    }
    {
# 7367 "gzip.c"
    while (1) {
      while_continue___2: ;
# 7367 "gzip.c"
      if (inbits > posbits) {

      } else {
# 7367 "gzip.c"
        goto while_break___2;
      }
# 7368 "gzip.c"
      if (free_ent > maxcode) {
# 7369 "gzip.c"
        posbits = (posbits - 1L) + ((long )(n_bits << 3) - ((posbits - 1L) + (long )(n_bits << 3)) % (long )(n_bits << 3));
# 7371 "gzip.c"
        n_bits ++;
# 7372 "gzip.c"
        if (n_bits == maxbits) {
# 7373 "gzip.c"
          maxcode = maxmaxcode;
        } else {
# 7375 "gzip.c"
          maxcode = (1L << n_bits) - 1L;
        }
# 7377 "gzip.c"
        bitmask = (unsigned int )((1 << n_bits) - 1);
# 7378 "gzip.c"
        goto resetbuf;
      } else {

      }
# 7380 "gzip.c"
      p = & inbuf[posbits >> 3];
# 7380 "gzip.c"
      mem_26 = p + 0;
# 7380 "gzip.c"
      mem_27 = p + 1;
# 7380 "gzip.c"
      mem_28 = p + 2;
# 7380 "gzip.c"
      code = (code_int )((unsigned long )((((long )*mem_26 | ((long )*mem_27 << 8)) | ((long )*mem_28 << 16)) >> (posbits & 7L)) & (unsigned long )bitmask);
# 7380 "gzip.c"
      posbits += (long )n_bits;
# 7383 "gzip.c"
      if (oldcode == -1L) {
# 7384 "gzip.c"
        if (code >= 256L) {
# 7384 "gzip.c"
          error((char *)"corrupt input.");
        } else {

        }
# 7385 "gzip.c"
        tmp___1 = outpos;
# 7385 "gzip.c"
        outpos ++;
# 7385 "gzip.c"
        oldcode = code;
# 7385 "gzip.c"
        finchar = (int )oldcode;
# 7385 "gzip.c"
        outbuf[tmp___1] = (char_type )finchar;
# 7386 "gzip.c"
        goto while_continue___2;
      } else {

      }
# 7388 "gzip.c"
      if (code == 256L) {
# 7388 "gzip.c"
        if (block_mode != 0) {
# 7389 "gzip.c"
          memset((voidp )(prev), 0, (size_t )256);
# 7390 "gzip.c"
          free_ent = (code_int )256;
# 7391 "gzip.c"
          posbits = (posbits - 1L) + ((long )(n_bits << 3) - ((posbits - 1L) + (long )(n_bits << 3)) % (long )(n_bits << 3));
# 7393 "gzip.c"
          n_bits = 9;
# 7393 "gzip.c"
          maxcode = (1L << n_bits) - 1L;
# 7394 "gzip.c"
          bitmask = (unsigned int )((1 << n_bits) - 1);
# 7395 "gzip.c"
          goto resetbuf;
        } else {

        }
      } else {

      }
# 7397 "gzip.c"
      incode = code;
# 7398 "gzip.c"
      stackp = (char_type *)(& d_buf[32767]);
# 7400 "gzip.c"
      if (code >= free_ent) {
# 7401 "gzip.c"
        if (code > free_ent) {
# 7414 "gzip.c"
          if (test == 0) {
# 7414 "gzip.c"
            if (outpos > 0) {
# 7415 "gzip.c"
              write_buf(out, (voidp )((char *)(outbuf)), (unsigned int )outpos);
# 7416 "gzip.c"
              bytes_out += (off_t )outpos;
            } else {

            }
          } else {

          }
# 7418 "gzip.c"
          if (to_stdout != 0) {
# 7418 "gzip.c"
            tmp___2 = "corrupt input.";
          } else {
# 7418 "gzip.c"
            tmp___2 = "corrupt input. Use zcat to recover some data.";
          }
# 7418 "gzip.c"
          error((char *)tmp___2);
        } else {

        }
# 7421 "gzip.c"
        stackp --;
# 7421 "gzip.c"
        *stackp = (char_type )finchar;
# 7422 "gzip.c"
        code = oldcode;
      } else {

      }
      {
# 7425 "gzip.c"
      while (1) {
        while_continue___3: ;
# 7425 "gzip.c"
        if ((cmp_code_int )code >= 256UL) {

        } else {
# 7425 "gzip.c"
          goto while_break___3;
        }
# 7427 "gzip.c"
        stackp --;
# 7427 "gzip.c"
        *stackp = window[code];
# 7428 "gzip.c"
        code = (code_int )prev[code];
      }
      while_break___3: ;
      }
# 7430 "gzip.c"
      stackp --;
# 7430 "gzip.c"
      finchar = (int )window[code];
# 7430 "gzip.c"
      *stackp = (char_type )finchar;
# 7436 "gzip.c"
      i___1 = (char_type *)(& d_buf[32767]) - stackp;
# 7436 "gzip.c"
      if (outpos + i___1 >= 16384) {
        {
# 7437 "gzip.c"
        while (1) {
          while_continue___4: ;
# 7438 "gzip.c"
          if (i___1 > 16384 - outpos) {
# 7438 "gzip.c"
            i___1 = 16384 - outpos;
          } else {

          }
# 7440 "gzip.c"
          if (i___1 > 0) {
# 7441 "gzip.c"
            memcpy((void * __restrict )(outbuf + outpos), (void const * __restrict )stackp,
                   (size_t )i___1);
# 7442 "gzip.c"
            outpos += i___1;
          } else {

          }
# 7444 "gzip.c"
          if (outpos >= 16384) {
# 7445 "gzip.c"
            if (test == 0) {
# 7446 "gzip.c"
              write_buf(out, (voidp )((char *)(outbuf)), (unsigned int )outpos);
# 7447 "gzip.c"
              bytes_out += (off_t )outpos;
            } else {

            }
# 7449 "gzip.c"
            outpos = 0;
          } else {

          }
# 7451 "gzip.c"
          stackp += i___1;
# 7437 "gzip.c"
          i___1 = (char_type *)(& d_buf[32767]) - stackp;
# 7437 "gzip.c"
          if (i___1 > 0) {

          } else {
# 7437 "gzip.c"
            goto while_break___4;
          }
        }
        while_break___4: ;
        }
      } else {
# 7454 "gzip.c"
        memcpy((void * __restrict )(outbuf + outpos), (void const * __restrict )stackp,
               (size_t )i___1);
# 7455 "gzip.c"
        outpos += i___1;
      }
# 7459 "gzip.c"
      code = free_ent;
# 7459 "gzip.c"
      if (code < maxmaxcode) {
# 7461 "gzip.c"
        prev[code] = (unsigned short )oldcode;
# 7462 "gzip.c"
        window[code] = (char_type )finchar;
# 7463 "gzip.c"
        free_ent = code + 1L;
      } else {

      }
# 7465 "gzip.c"
      oldcode = incode;
    }
    while_break___2: ;
    }
# 7343 "gzip.c"
    if (rsize != 0) {

    } else {
# 7343 "gzip.c"
      goto while_break___0;
    }
  }
  while_break___0: ;
  }
# 7469 "gzip.c"
  if (test == 0) {
# 7469 "gzip.c"
    if (outpos > 0) {
# 7470 "gzip.c"
      write_buf(out, (voidp )((char *)(outbuf)), (unsigned int )outpos);
# 7471 "gzip.c"
      bytes_out += (off_t )outpos;
    } else {

    }
  } else {

  }
# 7473 "gzip.c"
  __retres29 = 0;
  return_label:
# 7289 "gzip.c"
  return (__retres29);
}
}
# 7502 "gzip.c"
static ulg orig_len ;
# 7503 "gzip.c"
static int max_len ;
# 7505 "gzip.c"
static uch literal[256] ;
# 7510 "gzip.c"
static int lit_base[26] ;
# 7516 "gzip.c"
static int leaves[26] ;
# 7517 "gzip.c"
static int parents[26] ;
# 7519 "gzip.c"
static int peek_bits ;
# 7534 "gzip.c"
static ulg bitbuf ;
# 7537 "gzip.c"
static int valid ;
# 7558 "gzip.c"
static void read_tree(void) ;
# 7559 "gzip.c"
static void build_tree(void) ;
# 7564 "gzip.c"
static void read_tree(void)
{
  int len ;
  int base ;
  int n ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  unsigned int tmp___5 ;
  int tmp___6 ;
  int tmp___7 ;
  int tmp___8 ;
  unsigned int tmp___9 ;
  int tmp___10 ;
  int tmp___11 ;

  {
# 7571 "gzip.c"
  orig_len = (ulg )0;
# 7572 "gzip.c"
  n = 1;
  {
# 7572 "gzip.c"
  while (1) {
    while_continue: ;
# 7572 "gzip.c"
    if (n <= 4) {

    } else {
# 7572 "gzip.c"
      goto while_break;
    }
# 7572 "gzip.c"
    if (inptr < insize) {
# 7572 "gzip.c"
      tmp = inptr;
# 7572 "gzip.c"
      inptr ++;
# 7572 "gzip.c"
      tmp___1 = (int )inbuf[tmp];
    } else {
# 7572 "gzip.c"
      tmp___0 = fill_inbuf(0);
# 7572 "gzip.c"
      tmp___1 = tmp___0;
    }
# 7572 "gzip.c"
    orig_len = (orig_len << 8) | (ulg )tmp___1;
# 7572 "gzip.c"
    n ++;
  }
  while_break: ;
  }
# 7574 "gzip.c"
  if (inptr < insize) {
# 7574 "gzip.c"
    tmp___2 = inptr;
# 7574 "gzip.c"
    inptr ++;
# 7574 "gzip.c"
    tmp___4 = (int )inbuf[tmp___2];
  } else {
# 7574 "gzip.c"
    tmp___3 = fill_inbuf(0);
# 7574 "gzip.c"
    tmp___4 = tmp___3;
  }
# 7574 "gzip.c"
  max_len = tmp___4;
# 7575 "gzip.c"
  if (max_len > 25) {
# 7576 "gzip.c"
    error((char *)"invalid compressed data -- Huffman code > 32 bits");
  } else {

  }
# 7580 "gzip.c"
  n = 0;
# 7581 "gzip.c"
  len = 1;
  {
# 7581 "gzip.c"
  while (1) {
    while_continue___0: ;
# 7581 "gzip.c"
    if (len <= max_len) {

    } else {
# 7581 "gzip.c"
      goto while_break___0;
    }
# 7582 "gzip.c"
    if (inptr < insize) {
# 7582 "gzip.c"
      tmp___5 = inptr;
# 7582 "gzip.c"
      inptr ++;
# 7582 "gzip.c"
      tmp___7 = (int )inbuf[tmp___5];
    } else {
# 7582 "gzip.c"
      tmp___6 = fill_inbuf(0);
# 7582 "gzip.c"
      tmp___7 = tmp___6;
    }
# 7582 "gzip.c"
    leaves[len] = tmp___7;
# 7583 "gzip.c"
    n += leaves[len];
# 7581 "gzip.c"
    len ++;
  }
  while_break___0: ;
  }
# 7585 "gzip.c"
  if (n > 256) {
# 7586 "gzip.c"
    error((char *)"too many leaves in Huffman tree");
  } else {

  }
# 7597 "gzip.c"
  (leaves[max_len]) ++;
# 7600 "gzip.c"
  base = 0;
# 7601 "gzip.c"
  len = 1;
  {
# 7601 "gzip.c"
  while (1) {
    while_continue___1: ;
# 7601 "gzip.c"
    if (len <= max_len) {

    } else {
# 7601 "gzip.c"
      goto while_break___1;
    }
# 7603 "gzip.c"
    lit_base[len] = base;
# 7605 "gzip.c"
    n = leaves[len];
    {
# 7605 "gzip.c"
    while (1) {
      while_continue___2: ;
# 7605 "gzip.c"
      if (n > 0) {

      } else {
# 7605 "gzip.c"
        goto while_break___2;
      }
# 7606 "gzip.c"
      tmp___8 = base;
# 7606 "gzip.c"
      base ++;
# 7606 "gzip.c"
      if (inptr < insize) {
# 7606 "gzip.c"
        tmp___9 = inptr;
# 7606 "gzip.c"
        inptr ++;
# 7606 "gzip.c"
        tmp___11 = (int )inbuf[tmp___9];
      } else {
# 7606 "gzip.c"
        tmp___10 = fill_inbuf(0);
# 7606 "gzip.c"
        tmp___11 = tmp___10;
      }
# 7606 "gzip.c"
      literal[tmp___8] = (uch )tmp___11;
# 7605 "gzip.c"
      n --;
    }
    while_break___2: ;
    }
# 7601 "gzip.c"
    len ++;
  }
  while_break___1: ;
  }
# 7609 "gzip.c"
  (leaves[max_len]) ++;
# 7564 "gzip.c"
  return;
}
}
# 7615 "gzip.c"
static void build_tree(void)
{
  int nodes ;
  int len ;
  uch *prefixp ;
  int prefixes ;
  int tmp ;

  {
# 7617 "gzip.c"
  nodes = 0;
# 7621 "gzip.c"
  len = max_len;
  {
# 7621 "gzip.c"
  while (1) {
    while_continue: ;
# 7621 "gzip.c"
    if (len >= 1) {

    } else {
# 7621 "gzip.c"
      goto while_break;
    }
# 7625 "gzip.c"
    nodes >>= 1;
# 7626 "gzip.c"
    parents[len] = nodes;
# 7630 "gzip.c"
    lit_base[len] -= nodes;
# 7632 "gzip.c"
    nodes += leaves[len];
# 7621 "gzip.c"
    len --;
  }
  while_break: ;
  }
# 7637 "gzip.c"
  if (max_len <= 12) {
# 7637 "gzip.c"
    peek_bits = max_len;
  } else {
# 7637 "gzip.c"
    peek_bits = 12;
  }
# 7638 "gzip.c"
  prefixp = & outbuf[1 << peek_bits];
# 7639 "gzip.c"
  len = 1;
  {
# 7639 "gzip.c"
  while (1) {
    while_continue___0: ;
# 7639 "gzip.c"
    if (len <= peek_bits) {

    } else {
# 7639 "gzip.c"
      goto while_break___0;
    }
# 7640 "gzip.c"
    prefixes = leaves[len] << (peek_bits - len);
    {
# 7641 "gzip.c"
    while (1) {
      while_continue___1: ;
# 7641 "gzip.c"
      tmp = prefixes;
# 7641 "gzip.c"
      prefixes --;
# 7641 "gzip.c"
      if (tmp != 0) {

      } else {
# 7641 "gzip.c"
        goto while_break___1;
      }
# 7641 "gzip.c"
      prefixp --;
# 7641 "gzip.c"
      *prefixp = (uch )len;
    }
    while_break___1: ;
    }
# 7639 "gzip.c"
    len ++;
  }
  while_break___0: ;
  }
  {
# 7644 "gzip.c"
  while (1) {
    while_continue___2: ;
# 7644 "gzip.c"
    if ((unsigned int )prefixp > (unsigned int )(outbuf)) {

    } else {
# 7644 "gzip.c"
      goto while_break___2;
    }
# 7644 "gzip.c"
    prefixp --;
# 7644 "gzip.c"
    *prefixp = (uch )0;
  }
  while_break___2: ;
  }
# 7615 "gzip.c"
  return;
}
}
# 7655 "gzip.c"
int unpack(int in , int out )
{
  int len ;
  unsigned int eob ;
  register unsigned int peek ;
  unsigned int peek_mask ;
  unsigned int tmp ;
  int tmp___0 ;
  int tmp___1 ;
  ulg mask ;
  unsigned int tmp___2 ;
  int tmp___3 ;
  int tmp___4 ;
  unsigned int tmp___5 ;
  int __retres15 ;

  {
# 7663 "gzip.c"
  ifd = in;
# 7664 "gzip.c"
  ofd = out;
# 7666 "gzip.c"
  read_tree();
# 7667 "gzip.c"
  build_tree();
# 7668 "gzip.c"
  valid = 0;
# 7668 "gzip.c"
  bitbuf = (ulg )0;
# 7669 "gzip.c"
  peek_mask = (unsigned int )((1 << peek_bits) - 1);
# 7672 "gzip.c"
  eob = (unsigned int )(leaves[max_len] - 1);
  {
# 7676 "gzip.c"
  while (1) {
    while_continue: ;
    {
# 7681 "gzip.c"
    while (1) {
      while_continue___0: ;
# 7681 "gzip.c"
      if (valid < peek_bits) {

      } else {
# 7681 "gzip.c"
        goto while_break___0;
      }
# 7681 "gzip.c"
      if (inptr < insize) {
# 7681 "gzip.c"
        tmp = inptr;
# 7681 "gzip.c"
        inptr ++;
# 7681 "gzip.c"
        tmp___1 = (int )inbuf[tmp];
      } else {
# 7681 "gzip.c"
        tmp___0 = fill_inbuf(0);
# 7681 "gzip.c"
        tmp___1 = tmp___0;
      }
# 7681 "gzip.c"
      bitbuf = (bitbuf << 8) | (ulg )tmp___1;
# 7681 "gzip.c"
      valid += 8;
    }
    while_break___0: ;
    }
# 7681 "gzip.c"
    peek = (unsigned int )((bitbuf >> (valid - peek_bits)) & (unsigned long )peek_mask);
# 7682 "gzip.c"
    len = (int )outbuf[peek];
# 7683 "gzip.c"
    if (len > 0) {
# 7684 "gzip.c"
      peek >>= peek_bits - len;
    } else {
# 7687 "gzip.c"
      mask = (ulg )peek_mask;
# 7688 "gzip.c"
      len = peek_bits;
      {
# 7689 "gzip.c"
      while (1) {
        while_continue___1: ;
# 7690 "gzip.c"
        len ++;
# 7690 "gzip.c"
        mask = (mask << 1) + 1UL;
        {
# 7691 "gzip.c"
        while (1) {
          while_continue___2: ;
# 7691 "gzip.c"
          if (valid < len) {

          } else {
# 7691 "gzip.c"
            goto while_break___2;
          }
# 7691 "gzip.c"
          if (inptr < insize) {
# 7691 "gzip.c"
            tmp___2 = inptr;
# 7691 "gzip.c"
            inptr ++;
# 7691 "gzip.c"
            tmp___4 = (int )inbuf[tmp___2];
          } else {
# 7691 "gzip.c"
            tmp___3 = fill_inbuf(0);
# 7691 "gzip.c"
            tmp___4 = tmp___3;
          }
# 7691 "gzip.c"
          bitbuf = (bitbuf << 8) | (ulg )tmp___4;
# 7691 "gzip.c"
          valid += 8;
        }
        while_break___2: ;
        }
# 7691 "gzip.c"
        peek = (unsigned int )((bitbuf >> (valid - len)) & mask);
# 7689 "gzip.c"
        if (peek < (unsigned int )parents[len]) {

        } else {
# 7689 "gzip.c"
          goto while_break___1;
        }
      }
      while_break___1: ;
      }
    }
# 7696 "gzip.c"
    if (peek == eob) {
# 7696 "gzip.c"
      if (len == max_len) {
# 7696 "gzip.c"
        goto while_break;
      } else {

      }
    } else {

    }
# 7697 "gzip.c"
    tmp___5 = outcnt;
# 7697 "gzip.c"
    outcnt ++;
# 7697 "gzip.c"
    window[tmp___5] = literal[peek + (unsigned int )lit_base[len]];
# 7697 "gzip.c"
    if (outcnt == 32768U) {
# 7697 "gzip.c"
      flush_window();
    } else {

    }
# 7700 "gzip.c"
    valid -= len;
  }
  while_break: ;
  }
# 7703 "gzip.c"
  flush_window();
# 7704 "gzip.c"
  if (orig_len != ((unsigned long )bytes_out & 4294967295UL)) {
# 7705 "gzip.c"
    error((char *)"invalid compressed data--length error");
  } else {

  }
# 7707 "gzip.c"
  __retres15 = 0;
# 7655 "gzip.c"
  return (__retres15);
}
}
# 7748 "gzip.c"
char *key ;
# 7749 "gzip.c"
int pkzip = 0;
# 7750 "gzip.c"
int ext_header = 0;
# 7756 "gzip.c"
int check_zipfile(int in )
{
  uch *h ;
  uch *mem_3 ;
  uch *mem_4 ;
  uch *mem_5 ;
  uch *mem_6 ;
  uch *mem_7 ;
  uch *mem_8 ;
  uch *mem_9 ;
  uch *mem_10 ;
  uch *mem_11 ;
  uch *mem_12 ;
  uch *mem_13 ;
  int __retres14 ;

  {
# 7759 "gzip.c"
  h = inbuf + inptr;
# 7761 "gzip.c"
  ifd = in;
# 7764 "gzip.c"
  mem_3 = (h + 26) + 0;
# 7764 "gzip.c"
  mem_4 = (h + 26) + 1;
# 7764 "gzip.c"
  mem_5 = (h + 28) + 0;
# 7764 "gzip.c"
  mem_6 = (h + 28) + 1;
# 7764 "gzip.c"
  inptr += (unsigned int )((30 + ((int )((ush )*mem_3) | ((int )((ush )*mem_4) << 8))) + ((int )((ush )*mem_5) | ((int )((ush )*mem_6) << 8)));
# 7766 "gzip.c"
  if (inptr > insize) {
# 7767 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: not a valid zip file\n",
            progname, ifname);
# 7769 "gzip.c"
    exit_code = 1;
# 7770 "gzip.c"
    __retres14 = 1;
# 7770 "gzip.c"
    goto return_label;
  } else {
    {
# 7766 "gzip.c"
    mem_7 = h + 0;
# 7766 "gzip.c"
    mem_8 = h + 1;
# 7766 "gzip.c"
    mem_9 = (h + 2) + 0;
# 7766 "gzip.c"
    mem_10 = (h + 2) + 1;
# 7766 "gzip.c"
    if (((ulg )((int )((ush )*mem_7) | ((int )((ush )*mem_8) << 8)) | ((ulg )((int )((ush )*mem_9) | ((int )((ush )*mem_10) << 8)) << 16)) != 67324752UL) {
# 7767 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: not a valid zip file\n",
              progname, ifname);
# 7769 "gzip.c"
      exit_code = 1;
# 7770 "gzip.c"
      __retres14 = 1;
# 7770 "gzip.c"
      goto return_label;
    } else {

    }
    }
  }
# 7772 "gzip.c"
  mem_11 = h + 8;
# 7772 "gzip.c"
  method = (int )*mem_11;
# 7773 "gzip.c"
  if (method != 0) {
# 7773 "gzip.c"
    if (method != 8) {
# 7774 "gzip.c"
      fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: first entry not deflated or stored -- use unzip\n",
              progname, ifname);
# 7777 "gzip.c"
      exit_code = 1;
# 7778 "gzip.c"
      __retres14 = 1;
# 7778 "gzip.c"
      goto return_label;
    } else {

    }
  } else {

  }
# 7782 "gzip.c"
  mem_12 = h + 6;
# 7782 "gzip.c"
  decrypt = (int )*mem_12 & 1;
# 7782 "gzip.c"
  if (decrypt != 0) {
# 7783 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: encrypted file -- use unzip\n",
            progname, ifname);
# 7785 "gzip.c"
    exit_code = 1;
# 7786 "gzip.c"
    __retres14 = 1;
# 7786 "gzip.c"
    goto return_label;
  } else {

  }
# 7790 "gzip.c"
  mem_13 = h + 6;
# 7790 "gzip.c"
  ext_header = ((int )*mem_13 & 8) != 0;
# 7791 "gzip.c"
  pkzip = 1;
# 7794 "gzip.c"
  __retres14 = 0;
  return_label:
# 7756 "gzip.c"
  return (__retres14);
}
}
# 7804 "gzip.c"
int unzip(int in , int out )
{
  ulg orig_crc ;
  ulg orig_len___0 ;
  int n ;
  uch buf[16] ;
  int err ;
  int res ;
  int tmp ;
  register ulg n___0 ;
  int tmp___0 ;
  uch c ;
  unsigned int tmp___1 ;
  int tmp___2 ;
  int tmp___3 ;
  unsigned int tmp___4 ;
  ulg tmp___5 ;
  unsigned int tmp___6 ;
  int tmp___7 ;
  int tmp___8 ;
  unsigned int tmp___9 ;
  int tmp___10 ;
  int tmp___11 ;
  ulg tmp___12 ;
  uch *mem_25 ;
  uch *mem_26 ;
  uch *mem_27 ;
  uch *mem_28 ;
  uch *mem_29 ;
  uch *mem_30 ;
  uch *mem_31 ;
  uch *mem_32 ;
  uch *mem_33 ;
  uch *mem_34 ;
  uch *mem_35 ;
  uch *mem_36 ;
  uch *mem_37 ;
  uch *mem_38 ;
  uch *mem_39 ;
  uch *mem_40 ;
  uch *mem_41 ;
  uch *mem_42 ;
  uch *mem_43 ;
  uch *mem_44 ;
  uch *mem_45 ;
  uch *mem_46 ;
  uch *mem_47 ;
  uch *mem_48 ;
  uch *mem_49 ;
  uch *mem_50 ;
  uch *mem_51 ;
  uch *mem_52 ;
  uch *mem_53 ;
  uch *mem_54 ;
  uch *mem_55 ;
  uch *mem_56 ;
  uch *mem_57 ;
  uch *mem_58 ;
  uch *mem_59 ;
  uch *mem_60 ;
  uch *mem_61 ;
  uch *mem_62 ;
  int __retres63 ;

  {
# 7807 "gzip.c"
  orig_crc = (ulg )0;
# 7808 "gzip.c"
  orig_len___0 = (ulg )0;
# 7811 "gzip.c"
  err = 0;
# 7813 "gzip.c"
  ifd = in;
# 7814 "gzip.c"
  ofd = out;
# 7816 "gzip.c"
  updcrc((uch *)((void *)0), 0U);
# 7818 "gzip.c"
  if (pkzip != 0) {
# 7818 "gzip.c"
    if (ext_header == 0) {
# 7819 "gzip.c"
      mem_25 = (inbuf + 14) + 0;
# 7819 "gzip.c"
      mem_26 = (inbuf + 14) + 1;
# 7819 "gzip.c"
      mem_27 = ((inbuf + 14) + 2) + 0;
# 7819 "gzip.c"
      mem_28 = ((inbuf + 14) + 2) + 1;
# 7819 "gzip.c"
      orig_crc = (ulg )((int )((ush )*mem_25) | ((int )((ush )*mem_26) << 8)) | ((ulg )((int )((ush )*mem_27) | ((int )((ush )*mem_28) << 8)) << 16);
# 7820 "gzip.c"
      mem_29 = (inbuf + 22) + 0;
# 7820 "gzip.c"
      mem_30 = (inbuf + 22) + 1;
# 7820 "gzip.c"
      mem_31 = ((inbuf + 22) + 2) + 0;
# 7820 "gzip.c"
      mem_32 = ((inbuf + 22) + 2) + 1;
# 7820 "gzip.c"
      orig_len___0 = (ulg )((int )((ush )*mem_29) | ((int )((ush )*mem_30) << 8)) | ((ulg )((int )((ush )*mem_31) | ((int )((ush )*mem_32) << 8)) << 16);
    } else {

    }
  } else {

  }
# 7824 "gzip.c"
  if (method == 8) {
# 7826 "gzip.c"
    tmp = inflate();
# 7826 "gzip.c"
    res = tmp;
# 7828 "gzip.c"
    if (res == 3) {
# 7829 "gzip.c"
      error((char *)"out of memory");
    } else
# 7830 "gzip.c"
    if (res != 0) {
# 7831 "gzip.c"
      error((char *)"invalid compressed data--format violated");
    } else {

    }
  } else
# 7834 "gzip.c"
  if (pkzip != 0) {
# 7834 "gzip.c"
    if (method == 0) {
# 7836 "gzip.c"
      mem_33 = (inbuf + 22) + 0;
# 7836 "gzip.c"
      mem_34 = (inbuf + 22) + 1;
# 7836 "gzip.c"
      mem_35 = ((inbuf + 22) + 2) + 0;
# 7836 "gzip.c"
      mem_36 = ((inbuf + 22) + 2) + 1;
# 7836 "gzip.c"
      n___0 = (ulg )((int )((ush )*mem_33) | ((int )((ush )*mem_34) << 8)) | ((ulg )((int )((ush )*mem_35) | ((int )((ush )*mem_36) << 8)) << 16);
# 7838 "gzip.c"
      if (decrypt != 0) {
# 7838 "gzip.c"
        tmp___0 = 12;
      } else {
# 7838 "gzip.c"
        tmp___0 = 0;
      }
      {
# 7838 "gzip.c"
      mem_37 = (inbuf + 18) + 0;
# 7838 "gzip.c"
      mem_38 = (inbuf + 18) + 1;
# 7838 "gzip.c"
      mem_39 = ((inbuf + 18) + 2) + 0;
# 7838 "gzip.c"
      mem_40 = ((inbuf + 18) + 2) + 1;
# 7838 "gzip.c"
      if (n___0 != ((ulg )((int )((ush )*mem_37) | ((int )((ush )*mem_38) << 8)) | ((ulg )((int )((ush )*mem_39) | ((int )((ush )*mem_40) << 8)) << 16)) - (unsigned long )tmp___0) {
# 7840 "gzip.c"
        mem_41 = (inbuf + 18) + 0;
# 7840 "gzip.c"
        mem_42 = (inbuf + 18) + 1;
# 7840 "gzip.c"
        mem_43 = ((inbuf + 18) + 2) + 0;
# 7840 "gzip.c"
        mem_44 = ((inbuf + 18) + 2) + 1;
# 7840 "gzip.c"
        fprintf((FILE * __restrict )stderr, (char const * __restrict )"len %ld, siz %ld\n",
                n___0, (ulg )((int )((ush )*mem_41) | ((int )((ush )*mem_42) << 8)) | ((ulg )((int )((ush )*mem_43) | ((int )((ush )*mem_44) << 8)) << 16));
# 7841 "gzip.c"
        error((char *)"invalid compressed data--length mismatch");
      } else {

      }
      }
      {
# 7843 "gzip.c"
      while (1) {
        while_continue: ;
# 7843 "gzip.c"
        tmp___5 = n___0;
# 7843 "gzip.c"
        n___0 --;
# 7843 "gzip.c"
        if (tmp___5 != 0) {

        } else {
# 7843 "gzip.c"
          goto while_break;
        }
# 7844 "gzip.c"
        if (inptr < insize) {
# 7844 "gzip.c"
          tmp___1 = inptr;
# 7844 "gzip.c"
          inptr ++;
# 7844 "gzip.c"
          tmp___3 = (int )inbuf[tmp___1];
        } else {
# 7844 "gzip.c"
          tmp___2 = fill_inbuf(0);
# 7844 "gzip.c"
          tmp___3 = tmp___2;
        }
# 7844 "gzip.c"
        c = (uch )tmp___3;
# 7845 "gzip.c"
        tmp___4 = outcnt;
# 7845 "gzip.c"
        outcnt ++;
# 7845 "gzip.c"
        window[tmp___4] = c;
# 7845 "gzip.c"
        if (outcnt == 32768U) {
# 7845 "gzip.c"
          flush_window();
        } else {

        }
      }
      while_break: ;
      }
# 7847 "gzip.c"
      flush_window();
    } else {
# 7849 "gzip.c"
      error((char *)"internal error, invalid method");
    }
  } else {
# 7849 "gzip.c"
    error((char *)"internal error, invalid method");
  }
# 7853 "gzip.c"
  if (pkzip == 0) {
# 7857 "gzip.c"
    n = 0;
    {
# 7857 "gzip.c"
    while (1) {
      while_continue___0: ;
# 7857 "gzip.c"
      if (n < 8) {

      } else {
# 7857 "gzip.c"
        goto while_break___0;
      }
# 7858 "gzip.c"
      if (inptr < insize) {
# 7858 "gzip.c"
        tmp___6 = inptr;
# 7858 "gzip.c"
        inptr ++;
# 7858 "gzip.c"
        tmp___8 = (int )inbuf[tmp___6];
      } else {
# 7858 "gzip.c"
        tmp___7 = fill_inbuf(0);
# 7858 "gzip.c"
        tmp___8 = tmp___7;
      }
# 7858 "gzip.c"
      buf[n] = (uch )tmp___8;
# 7857 "gzip.c"
      n ++;
    }
    while_break___0: ;
    }
# 7860 "gzip.c"
    mem_45 = (buf + 2) + 0;
# 7860 "gzip.c"
    mem_46 = (buf + 2) + 1;
# 7860 "gzip.c"
    orig_crc = (ulg )((int )((ush )buf[0]) | ((int )((ush )buf[1]) << 8)) | ((ulg )((int )((ush )*mem_45) | ((int )((ush )*mem_46) << 8)) << 16);
# 7861 "gzip.c"
    mem_47 = (buf + 4) + 0;
# 7861 "gzip.c"
    mem_48 = (buf + 4) + 1;
# 7861 "gzip.c"
    mem_49 = ((buf + 4) + 2) + 0;
# 7861 "gzip.c"
    mem_50 = ((buf + 4) + 2) + 1;
# 7861 "gzip.c"
    orig_len___0 = (ulg )((int )((ush )*mem_47) | ((int )((ush )*mem_48) << 8)) | ((ulg )((int )((ush )*mem_49) | ((int )((ush )*mem_50) << 8)) << 16);
  } else
# 7863 "gzip.c"
  if (ext_header != 0) {
# 7869 "gzip.c"
    n = 0;
    {
# 7869 "gzip.c"
    while (1) {
      while_continue___1: ;
# 7869 "gzip.c"
      if (n < 16) {

      } else {
# 7869 "gzip.c"
        goto while_break___1;
      }
# 7870 "gzip.c"
      if (inptr < insize) {
# 7870 "gzip.c"
        tmp___9 = inptr;
# 7870 "gzip.c"
        inptr ++;
# 7870 "gzip.c"
        tmp___11 = (int )inbuf[tmp___9];
      } else {
# 7870 "gzip.c"
        tmp___10 = fill_inbuf(0);
# 7870 "gzip.c"
        tmp___11 = tmp___10;
      }
# 7870 "gzip.c"
      buf[n] = (uch )tmp___11;
# 7869 "gzip.c"
      n ++;
    }
    while_break___1: ;
    }
# 7872 "gzip.c"
    mem_51 = (buf + 4) + 0;
# 7872 "gzip.c"
    mem_52 = (buf + 4) + 1;
# 7872 "gzip.c"
    mem_53 = ((buf + 4) + 2) + 0;
# 7872 "gzip.c"
    mem_54 = ((buf + 4) + 2) + 1;
# 7872 "gzip.c"
    orig_crc = (ulg )((int )((ush )*mem_51) | ((int )((ush )*mem_52) << 8)) | ((ulg )((int )((ush )*mem_53) | ((int )((ush )*mem_54) << 8)) << 16);
# 7873 "gzip.c"
    mem_55 = (buf + 12) + 0;
# 7873 "gzip.c"
    mem_56 = (buf + 12) + 1;
# 7873 "gzip.c"
    mem_57 = ((buf + 12) + 2) + 0;
# 7873 "gzip.c"
    mem_58 = ((buf + 12) + 2) + 1;
# 7873 "gzip.c"
    orig_len___0 = (ulg )((int )((ush )*mem_55) | ((int )((ush )*mem_56) << 8)) | ((ulg )((int )((ush )*mem_57) | ((int )((ush )*mem_58) << 8)) << 16);
  } else {

  }
# 7877 "gzip.c"
  tmp___12 = updcrc(outbuf, 0U);
# 7877 "gzip.c"
  if (orig_crc != tmp___12) {
# 7878 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: invalid compressed data--crc error\n",
            progname, ifname);
# 7880 "gzip.c"
    err = 1;
  } else {

  }
# 7882 "gzip.c"
  if (orig_len___0 != ((unsigned long )bytes_out & 4294967295UL)) {
# 7883 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: invalid compressed data--length error\n",
            progname, ifname);
# 7885 "gzip.c"
    err = 1;
  } else {

  }
# 7889 "gzip.c"
  if (pkzip != 0) {
# 7889 "gzip.c"
    if (inptr + 4U < insize) {
      {
# 7889 "gzip.c"
      mem_59 = (inbuf + inptr) + 0;
# 7889 "gzip.c"
      mem_60 = (inbuf + inptr) + 1;
# 7889 "gzip.c"
      mem_61 = ((inbuf + inptr) + 2) + 0;
# 7889 "gzip.c"
      mem_62 = ((inbuf + inptr) + 2) + 1;
# 7889 "gzip.c"
      if (((ulg )((int )((ush )*mem_59) | ((int )((ush )*mem_60) << 8)) | ((ulg )((int )((ush )*mem_61) | ((int )((ush )*mem_62) << 8)) << 16)) == 67324752UL) {
# 7890 "gzip.c"
        if (to_stdout != 0) {
# 7891 "gzip.c"
          if (quiet == 0) {
# 7891 "gzip.c"
            fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s has more than one entry--rest ignored\n",
                    progname, ifname);
          } else {

          }
# 7891 "gzip.c"
          if (exit_code == 0) {
# 7891 "gzip.c"
            exit_code = 2;
          } else {

          }
        } else {
# 7896 "gzip.c"
          fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s has more than one entry -- unchanged\n",
                  progname, ifname);
# 7899 "gzip.c"
          err = 1;
        }
      } else {

      }
      }
    } else {

    }
  } else {

  }
# 7902 "gzip.c"
  pkzip = 0;
# 7902 "gzip.c"
  ext_header = pkzip;
# 7903 "gzip.c"
  if (err == 0) {
# 7903 "gzip.c"
    __retres63 = 0;
# 7903 "gzip.c"
    goto return_label;
  } else {

  }
# 7904 "gzip.c"
  exit_code = 1;
# 7905 "gzip.c"
  if (test == 0) {
# 7905 "gzip.c"
    abort_gzip();
  } else {

  }
# 7906 "gzip.c"
  __retres63 = err;
  return_label:
# 7804 "gzip.c"
  return (__retres63);
}
}
# 7923 "gzip.c"
ulg crc_32_tab[256] ;
# 7929 "gzip.c"
int copy(int in , int out )
{
  int *tmp ;
  ssize_t tmp___0 ;
  int __retres5 ;

  {
# 7932 "gzip.c"
  tmp = __errno_location();
# 7932 "gzip.c"
  *tmp = 0;
  {
# 7933 "gzip.c"
  while (1) {
    while_continue: ;
# 7933 "gzip.c"
    if (insize != 0U) {
# 7933 "gzip.c"
      if ((int )insize != -1) {

      } else {
# 7933 "gzip.c"
        goto while_break;
      }
    } else {
# 7933 "gzip.c"
      goto while_break;
    }
# 7934 "gzip.c"
    write_buf(out, (voidp )((char *)(inbuf)), insize);
# 7935 "gzip.c"
    bytes_out = (off_t )((unsigned long )bytes_out + (unsigned long )insize);
# 7936 "gzip.c"
    tmp___0 = read(in, (void *)((char *)(inbuf)), (size_t )32768);
# 7936 "gzip.c"
    insize = (unsigned int )tmp___0;
  }
  while_break: ;
  }
# 7938 "gzip.c"
  if ((int )insize == -1) {
# 7939 "gzip.c"
    read_error();
  } else {

  }
# 7941 "gzip.c"
  bytes_in = bytes_out;
# 7942 "gzip.c"
  __retres5 = 0;
# 7929 "gzip.c"
  return (__retres5);
}
}
# 7956 "gzip.c"
ulg updcrc(uch *s , unsigned int n ) ;
# 7956 "gzip.c"
static ulg crc___0 = 4294967295UL;
# 7950 "gzip.c"
ulg updcrc(uch *s , unsigned int n )
{
  register ulg c ;
  uch *tmp ;
  ulg __retres5 ;

  {
# 7958 "gzip.c"
  if ((unsigned int )s == (unsigned int )((void *)0)) {
# 7959 "gzip.c"
    c = 4294967295UL;
  } else {
# 7961 "gzip.c"
    c = crc___0;
# 7962 "gzip.c"
    if (n != 0) {
      {
# 7962 "gzip.c"
      while (1) {
        while_continue: ;
# 7963 "gzip.c"
        tmp = s;
# 7963 "gzip.c"
        s ++;
# 7963 "gzip.c"
        c = crc_32_tab[((int )c ^ (int )*tmp) & 255] ^ (c >> 8);
# 7962 "gzip.c"
        n --;
# 7962 "gzip.c"
        if (n != 0) {

        } else {
# 7962 "gzip.c"
          goto while_break;
        }
      }
      while_break: ;
      }
    } else {

    }
  }
# 7966 "gzip.c"
  crc___0 = c;
# 7967 "gzip.c"
  __retres5 = c ^ 4294967295UL;
# 7950 "gzip.c"
  return (__retres5);
}
}
# 7973 "gzip.c"
void clear_bufs(void)
{


  {
# 7975 "gzip.c"
  outcnt = 0U;
# 7976 "gzip.c"
  inptr = 0U;
# 7976 "gzip.c"
  insize = inptr;
# 7977 "gzip.c"
  bytes_out = 0L;
# 7977 "gzip.c"
  bytes_in = bytes_out;
# 7973 "gzip.c"
  return;
}
}
# 7983 "gzip.c"
int fill_inbuf(int eof_ok )
{
  int len ;
  int *tmp ;
  int __retres4 ;

  {
# 7989 "gzip.c"
  insize = 0U;
  {
# 7990 "gzip.c"
  while (1) {
    while_continue: ;
# 7991 "gzip.c"
    len = read(ifd, (void *)((char *)(inbuf) + insize), 32768U - insize);
# 7992 "gzip.c"
    if (len == 0) {
# 7992 "gzip.c"
      goto while_break;
    } else {

    }
# 7993 "gzip.c"
    if (len == -1) {
# 7994 "gzip.c"
      read_error();
# 7995 "gzip.c"
      goto while_break;
    } else {

    }
# 7997 "gzip.c"
    insize += (unsigned int )len;
# 7990 "gzip.c"
    if (insize < 32768U) {

    } else {
# 7990 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }
# 8000 "gzip.c"
  if (insize == 0U) {
# 8001 "gzip.c"
    if (eof_ok != 0) {
# 8001 "gzip.c"
      __retres4 = -1;
# 8001 "gzip.c"
      goto return_label;
    } else {

    }
# 8002 "gzip.c"
    flush_window();
# 8003 "gzip.c"
    tmp = __errno_location();
# 8003 "gzip.c"
    *tmp = 0;
# 8004 "gzip.c"
    read_error();
  } else {

  }
# 8006 "gzip.c"
  bytes_in += (off_t )insize;
# 8007 "gzip.c"
  inptr = 1U;
# 8008 "gzip.c"
  __retres4 = (int )inbuf[0];
  return_label:
# 7983 "gzip.c"
  return (__retres4);
}
}
# 8015 "gzip.c"
void flush_outbuf(void)
{


  {
# 8017 "gzip.c"
  if (outcnt == 0U) {
# 8017 "gzip.c"
    goto return_label;
  } else {

  }
# 8019 "gzip.c"
  write_buf(ofd, (voidp )((char *)(outbuf)), outcnt);
# 8020 "gzip.c"
  bytes_out += (off_t )outcnt;
# 8021 "gzip.c"
  outcnt = 0U;

  return_label:
# 8015 "gzip.c"
  return;
}
}
# 8028 "gzip.c"
void flush_window(void)
{


  {
# 8030 "gzip.c"
  if (outcnt == 0U) {
# 8030 "gzip.c"
    goto return_label;
  } else {

  }
# 8031 "gzip.c"
  updcrc(window, outcnt);
# 8033 "gzip.c"
  if (test == 0) {
# 8034 "gzip.c"
    write_buf(ofd, (voidp )((char *)(window)), outcnt);
  } else {

  }
# 8036 "gzip.c"
  bytes_out += (off_t )outcnt;
# 8037 "gzip.c"
  outcnt = 0U;

  return_label:
# 8028 "gzip.c"
  return;
}
}
# 8044 "gzip.c"
void write_buf(int fd , voidp buf , unsigned int cnt )
{
  unsigned int n ;
  ssize_t tmp ;

  {
  {
# 8051 "gzip.c"
  while (1) {
    while_continue: ;
# 8051 "gzip.c"
    tmp = write(fd, (void const *)buf, cnt);
# 8051 "gzip.c"
    n = (unsigned int )tmp;
# 8051 "gzip.c"
    if (n != cnt) {

    } else {
# 8051 "gzip.c"
      goto while_break;
    }
# 8052 "gzip.c"
    if (n == 4294967295U) {
# 8053 "gzip.c"
      write_error();
    } else {

    }
# 8055 "gzip.c"
    cnt -= n;
# 8056 "gzip.c"
    buf = (voidp )((char *)buf + n);
  }
  while_break: ;
  }
# 8044 "gzip.c"
  return;
}
}
# 8063 "gzip.c"
char *strlwr(char *s )
{
  char *t ;
  int tmp___0 ;
  unsigned short const **tmp___1 ;
  unsigned short const *mem_6 ;

  {
# 8067 "gzip.c"
  t = s;
  {
# 8067 "gzip.c"
  while (1) {
    while_continue: ;
# 8067 "gzip.c"
    if (*t != 0) {

    } else {
# 8067 "gzip.c"
      goto while_break;
    }
# 8068 "gzip.c"
    tmp___1 = __ctype_b_loc();
    {
# 8068 "gzip.c"
    mem_6 = *tmp___1 + (int )((unsigned char )*t);
# 8068 "gzip.c"
    if (((int const )*mem_6 & 256) != 0) {
# 8068 "gzip.c"
      tmp___0 = tolower((int )((unsigned char )*t));
# 8068 "gzip.c"
      *t = (char )tmp___0;
    } else {
# 8068 "gzip.c"
      *t = (char )((unsigned char )*t);
    }
    }
# 8067 "gzip.c"
    t ++;
  }
  while_break: ;
  }
# 8069 "gzip.c"
  return (s);
}
}
# 8077 "gzip.c"
char *base_name(char *fname )
{
  char *p ;

  {
# 8082 "gzip.c"
  p = strrchr((char const *)fname, '/');
# 8082 "gzip.c"
  if ((unsigned int )p != (unsigned int )((void *)0)) {
# 8082 "gzip.c"
    fname = p + 1;
  } else {

  }
# 8093 "gzip.c"
  return (fname);
}
}
# 8099 "gzip.c"
int xunlink(char *filename )
{
  int r ;
  int tmp ;

  {
# 8102 "gzip.c"
  tmp = unlink((char const *)filename);
# 8102 "gzip.c"
  r = tmp;
# 8118 "gzip.c"
  return (r);
}
}
# 8129 "gzip.c"
void make_simple_name(char *name )
{
  char *p ;
  char *tmp ;

  {
# 8132 "gzip.c"
  tmp = strrchr((char const *)name, '.');
# 8132 "gzip.c"
  p = tmp;
# 8133 "gzip.c"
  if ((unsigned int )p == (unsigned int )((void *)0)) {
# 8133 "gzip.c"
    goto return_label;
  } else {

  }
# 8134 "gzip.c"
  if ((unsigned int )p == (unsigned int )name) {
# 8134 "gzip.c"
    p ++;
  } else {

  }
  {
# 8135 "gzip.c"
  while (1) {
    while_continue: ;
# 8136 "gzip.c"
    p --;
# 8136 "gzip.c"
    if ((int )*p == 46) {
# 8136 "gzip.c"
      *p = (char )'_';
    } else {

    }
# 8135 "gzip.c"
    if ((unsigned int )p != (unsigned int )name) {

    } else {
# 8135 "gzip.c"
      goto while_break;
    }
  }
  while_break: ;
  }

  return_label:
# 8129 "gzip.c"
  return;
}
}
# 8200 "gzip.c"
char *add_envopt(int *argcp , char ***argvp , char *env___0 )
{
  char *p ;
  char **oargv ;
  char **nargv ;
  int oargc ;
  int nargc ;
  char *tmp ;
  size_t tmp___0 ;
  voidp tmp___1 ;
  size_t tmp___2 ;
  size_t tmp___3 ;
  char *tmp___4 ;
  void *tmp___5 ;
  int tmp___6 ;
  char **tmp___7 ;
  char **tmp___8 ;
  size_t tmp___9 ;
  char **tmp___10 ;
  char *tmp___11 ;
  char **tmp___12 ;
  char **tmp___13 ;
  int tmp___14 ;
  char *__retres25 ;

  {
# 8208 "gzip.c"
  oargc = *argcp;
# 8209 "gzip.c"
  nargc = 0;
# 8211 "gzip.c"
  tmp = getenv((char const *)env___0);
# 8211 "gzip.c"
  env___0 = tmp;
# 8212 "gzip.c"
  if ((unsigned int )env___0 == (unsigned int )((void *)0)) {
# 8212 "gzip.c"
    __retres25 = (char *)((void *)0);
# 8212 "gzip.c"
    goto return_label;
  } else {

  }
# 8214 "gzip.c"
  tmp___0 = strlen((char const *)env___0);
# 8214 "gzip.c"
  tmp___1 = xmalloc(tmp___0 + 1U);
# 8214 "gzip.c"
  p = (char *)tmp___1;
# 8215 "gzip.c"
  env___0 = strcpy((char * __restrict )p, (char const * __restrict )env___0);
# 8217 "gzip.c"
  p = env___0;
  {
# 8217 "gzip.c"
  while (1) {
    while_continue: ;
# 8217 "gzip.c"
    if (*p != 0) {

    } else {
# 8217 "gzip.c"
      goto while_break;
    }
# 8218 "gzip.c"
    tmp___2 = strspn((char const *)p, " \t");
# 8218 "gzip.c"
    p += tmp___2;
# 8219 "gzip.c"
    if ((int )*p == 0) {
# 8219 "gzip.c"
      goto while_break;
    } else {

    }
# 8221 "gzip.c"
    tmp___3 = strcspn((char const *)p, " \t");
# 8221 "gzip.c"
    p += tmp___3;
# 8222 "gzip.c"
    if (*p != 0) {
# 8222 "gzip.c"
      tmp___4 = p;
# 8222 "gzip.c"
      p ++;
# 8222 "gzip.c"
      *tmp___4 = (char )'\000';
    } else {

    }
# 8217 "gzip.c"
    nargc ++;
  }
  while_break: ;
  }
# 8224 "gzip.c"
  if (nargc == 0) {
# 8225 "gzip.c"
    free((void *)env___0);
# 8226 "gzip.c"
    __retres25 = (char *)((void *)0);
# 8226 "gzip.c"
    goto return_label;
  } else {

  }
# 8228 "gzip.c"
  *argcp += nargc;
# 8232 "gzip.c"
  tmp___5 = calloc((size_t )(*argcp + 1), sizeof(char *));
# 8232 "gzip.c"
  nargv = (char **)tmp___5;
# 8233 "gzip.c"
  if ((unsigned int )nargv == (unsigned int )((void *)0)) {
# 8233 "gzip.c"
    error((char *)"out of memory");
  } else {

  }
# 8234 "gzip.c"
  oargv = *argvp;
# 8235 "gzip.c"
  *argvp = nargv;
# 8238 "gzip.c"
  tmp___6 = oargc;
# 8238 "gzip.c"
  oargc --;
# 8238 "gzip.c"
  if (tmp___6 < 0) {
# 8238 "gzip.c"
    error((char *)"argc<=0");
  } else {

  }
# 8239 "gzip.c"
  tmp___7 = nargv;
# 8239 "gzip.c"
  nargv ++;
# 8239 "gzip.c"
  tmp___8 = oargv;
# 8239 "gzip.c"
  oargv ++;
# 8239 "gzip.c"
  *tmp___7 = *tmp___8;
# 8242 "gzip.c"
  p = env___0;
  {
# 8242 "gzip.c"
  while (1) {
    while_continue___0: ;
# 8242 "gzip.c"
    if (nargc > 0) {

    } else {
# 8242 "gzip.c"
      goto while_break___0;
    }
# 8243 "gzip.c"
    tmp___9 = strspn((char const *)p, " \t");
# 8243 "gzip.c"
    p += tmp___9;
# 8244 "gzip.c"
    tmp___10 = nargv;
# 8244 "gzip.c"
    nargv ++;
# 8244 "gzip.c"
    *tmp___10 = p;
    {
# 8245 "gzip.c"
    while (1) {
      while_continue___1: ;
# 8245 "gzip.c"
      tmp___11 = p;
# 8245 "gzip.c"
      p ++;
# 8245 "gzip.c"
      if (*tmp___11 != 0) {

      } else {
# 8245 "gzip.c"
        goto while_break___1;
      }
    }
    while_break___1: ;
    }
# 8242 "gzip.c"
    nargc --;
  }
  while_break___0: ;
  }
  {
# 8249 "gzip.c"
  while (1) {
    while_continue___2: ;
# 8249 "gzip.c"
    tmp___14 = oargc;
# 8249 "gzip.c"
    oargc --;
# 8249 "gzip.c"
    if (tmp___14 != 0) {

    } else {
# 8249 "gzip.c"
      goto while_break___2;
    }
# 8249 "gzip.c"
    tmp___12 = nargv;
# 8249 "gzip.c"
    nargv ++;
# 8249 "gzip.c"
    tmp___13 = oargv;
# 8249 "gzip.c"
    oargv ++;
# 8249 "gzip.c"
    *tmp___12 = *tmp___13;
  }
  while_break___2: ;
  }
# 8250 "gzip.c"
  *nargv = (char *)((void *)0);
# 8251 "gzip.c"
  __retres25 = env___0;
  return_label:
# 8200 "gzip.c"
  return (__retres25);
}
}
# 8257 "gzip.c"
void error(char *m )
{


  {
# 8260 "gzip.c"
  fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: %s: %s\n",
          progname, ifname, m);
# 8261 "gzip.c"
  abort_gzip();
# 8257 "gzip.c"
  return;
}
}
# 8264 "gzip.c"
void warning(char *m )
{


  {
# 8267 "gzip.c"
  if (quiet == 0) {
# 8267 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: %s: warning: %s\n",
            progname, ifname, m);
  } else {

  }
# 8267 "gzip.c"
  if (exit_code == 0) {
# 8267 "gzip.c"
    exit_code = 2;
  } else {

  }
# 8264 "gzip.c"
  return;
}
}
# 8270 "gzip.c"
void read_error(void)
{
  int e ;
  int *tmp ;
  int *tmp___0 ;

  {
# 8272 "gzip.c"
  tmp = __errno_location();
# 8272 "gzip.c"
  e = *tmp;
# 8273 "gzip.c"
  fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: ", progname);
# 8274 "gzip.c"
  if (e != 0) {
# 8275 "gzip.c"
    tmp___0 = __errno_location();
# 8275 "gzip.c"
    *tmp___0 = e;
# 8276 "gzip.c"
    perror((char const *)(ifname));
  } else {
# 8278 "gzip.c"
    fprintf((FILE * __restrict )stderr, (char const * __restrict )"%s: unexpected end of file\n",
            ifname);
  }
# 8280 "gzip.c"
  abort_gzip();
# 8270 "gzip.c"
  return;
}
}
# 8283 "gzip.c"
void write_error(void)
{
  int e ;
  int *tmp ;
  int *tmp___0 ;

  {
# 8285 "gzip.c"
  tmp = __errno_location();
# 8285 "gzip.c"
  e = *tmp;
# 8286 "gzip.c"
  fprintf((FILE * __restrict )stderr, (char const * __restrict )"\n%s: ", progname);
# 8287 "gzip.c"
  tmp___0 = __errno_location();
# 8287 "gzip.c"
  *tmp___0 = e;
# 8288 "gzip.c"
  perror((char const *)(ofname));
# 8289 "gzip.c"
  abort_gzip();
# 8283 "gzip.c"
  return;
}
}
# 8295 "gzip.c"
void display_ratio(off_t num , off_t den , FILE *file )
{
  double tmp ;

  {
# 8300 "gzip.c"
  if (den == 0L) {
# 8300 "gzip.c"
    tmp = (double )0;
  } else {
# 8300 "gzip.c"
    tmp = (100.0 * (double )num) / (double )den;
  }
# 8300 "gzip.c"
  fprintf((FILE * __restrict )file, (char const * __restrict )"%5.1f%%", tmp);
# 8295 "gzip.c"
  return;
}
}
# 8307 "gzip.c"
void fprint_off(FILE *file , off_t offset , int width )
{
  char buf[8U * sizeof(off_t )] ;
  char *p ;
  int tmp ;

  {
# 8313 "gzip.c"
  p = buf + sizeof(buf);
# 8316 "gzip.c"
  if (offset < 0L) {
    {
# 8317 "gzip.c"
    while (1) {
      while_continue: ;
# 8318 "gzip.c"
      p --;
# 8318 "gzip.c"
      *p = (char )(48L - offset % 10L);
# 8317 "gzip.c"
      offset /= 10L;
# 8317 "gzip.c"
      if (offset != 0L) {

      } else {
# 8317 "gzip.c"
        goto while_break;
      }
    }
    while_break: ;
    }
# 8321 "gzip.c"
    p --;
# 8321 "gzip.c"
    *p = (char )'-';
  } else {
    {
# 8323 "gzip.c"
    while (1) {
      while_continue___0: ;
# 8324 "gzip.c"
      p --;
# 8324 "gzip.c"
      *p = (char )(48L + offset % 10L);
# 8323 "gzip.c"
      offset /= 10L;
# 8323 "gzip.c"
      if (offset != 0L) {

      } else {
# 8323 "gzip.c"
        goto while_break___0;
      }
    }
    while_break___0: ;
    }
  }
# 8328 "gzip.c"
  width -= (buf + sizeof(buf)) - p;
  {
# 8329 "gzip.c"
  while (1) {
    while_continue___1: ;
# 8329 "gzip.c"
    tmp = width;
# 8329 "gzip.c"
    width --;
# 8329 "gzip.c"
    if (0 < tmp) {

    } else {
# 8329 "gzip.c"
      goto while_break___1;
    }
# 8330 "gzip.c"
    _IO_putc(' ', file);
  }
  while_break___1: ;
  }
  {
# 8332 "gzip.c"
  while (1) {
    while_continue___2: ;
# 8332 "gzip.c"
    if ((unsigned int )p < (unsigned int )(buf + sizeof(buf))) {

    } else {
# 8332 "gzip.c"
      goto while_break___2;
    }
# 8333 "gzip.c"
    _IO_putc((int )*p, file);
# 8332 "gzip.c"
    p ++;
  }
  while_break___2: ;
  }
# 8307 "gzip.c"
  return;
}
}
# 8339 "gzip.c"
voidp xmalloc(unsigned int size )
{
  voidp cp ;
  void *tmp ;

  {
# 8342 "gzip.c"
  tmp = malloc(size);
# 8342 "gzip.c"
  cp = tmp;
# 8344 "gzip.c"
  if ((unsigned int )cp == (unsigned int )((void *)0)) {
# 8344 "gzip.c"
    error((char *)"out of memory");
  } else {

  }
# 8345 "gzip.c"
  return (cp);
}
}
# 8351 "gzip.c"
ulg crc_32_tab[256] =
# 8351 "gzip.c"
  { (ulg )0L, (ulg )1996959894L, 3993919788UL, 2567524794UL,
        (ulg )124634137L, (ulg )1886057615L, 3915621685UL, 2657392035UL,
        (ulg )249268274L, (ulg )2044508324L, 3772115230UL, 2547177864UL,
        (ulg )162941995L, (ulg )2125561021L, 3887607047UL, 2428444049UL,
        (ulg )498536548L, (ulg )1789927666L, 4089016648UL, 2227061214UL,
        (ulg )450548861L, (ulg )1843258603L, 4107580753UL, 2211677639UL,
        (ulg )325883990L, (ulg )1684777152L, 4251122042UL, 2321926636UL,
        (ulg )335633487L, (ulg )1661365465L, 4195302755UL, 2366115317UL,
        (ulg )997073096L, (ulg )1281953886L, 3579855332UL, 2724688242UL,
        (ulg )1006888145L, (ulg )1258607687L, 3524101629UL, 2768942443UL,
        (ulg )901097722L, (ulg )1119000684L, 3686517206UL, 2898065728UL,
        (ulg )853044451L, (ulg )1172266101L, 3705015759UL, 2882616665UL,
        (ulg )651767980L, (ulg )1373503546L, 3369554304UL, 3218104598UL,
        (ulg )565507253L, (ulg )1454621731L, 3485111705UL, 3099436303UL,
        (ulg )671266974L, (ulg )1594198024L, 3322730930UL, 2970347812UL,
        (ulg )795835527L, (ulg )1483230225L, 3244367275UL, 3060149565UL,
        (ulg )1994146192L, (ulg )31158534L, 2563907772UL, 4023717930UL,
        (ulg )1907459465L, (ulg )112637215L, 2680153253UL, 3904427059UL,
        (ulg )2013776290L, (ulg )251722036L, 2517215374UL, 3775830040UL,
        (ulg )2137656763L, (ulg )141376813L, 2439277719UL, 3865271297UL,
        (ulg )1802195444L, (ulg )476864866L, 2238001368UL, 4066508878UL,
        (ulg )1812370925L, (ulg )453092731L, 2181625025UL, 4111451223UL,
        (ulg )1706088902L, (ulg )314042704L, 2344532202UL, 4240017532UL,
        (ulg )1658658271L, (ulg )366619977L, 2362670323UL, 4224994405UL,
        (ulg )1303535960L, (ulg )984961486L, 2747007092UL, 3569037538UL,
        (ulg )1256170817L, (ulg )1037604311L, 2765210733UL, 3554079995UL,
        (ulg )1131014506L, (ulg )879679996L, 2909243462UL, 3663771856UL,
        (ulg )1141124467L, (ulg )855842277L, 2852801631UL, 3708648649UL,
        (ulg )1342533948L, (ulg )654459306L, 3188396048UL, 3373015174UL,
        (ulg )1466479909L, (ulg )544179635L, 3110523913UL, 3462522015UL,
        (ulg )1591671054L, (ulg )702138776L, 2966460450UL, 3352799412UL,
        (ulg )1504918807L, (ulg )783551873L, 3082640443UL, 3233442989UL,
        3988292384UL, 2596254646UL, (ulg )62317068L, (ulg )1957810842L,
        3939845945UL, 2647816111UL, (ulg )81470997L, (ulg )1943803523L,
        3814918930UL, 2489596804UL, (ulg )225274430L, (ulg )2053790376L,
        3826175755UL, 2466906013UL, (ulg )167816743L, (ulg )2097651377L,
        4027552580UL, 2265490386UL, (ulg )503444072L, (ulg )1762050814L,
        4150417245UL, 2154129355UL, (ulg )426522225L, (ulg )1852507879L,
        4275313526UL, 2312317920UL, (ulg )282753626L, (ulg )1742555852L,
        4189708143UL, 2394877945UL, (ulg )397917763L, (ulg )1622183637L,
        3604390888UL, 2714866558UL, (ulg )953729732L, (ulg )1340076626L,
        3518719985UL, 2797360999UL, (ulg )1068828381L, (ulg )1219638859L,
        3624741850UL, 2936675148UL, (ulg )906185462L, (ulg )1090812512L,
        3747672003UL, 2825379669UL, (ulg )829329135L, (ulg )1181335161L,
        3412177804UL, 3160834842UL, (ulg )628085408L, (ulg )1382605366L,
        3423369109UL, 3138078467UL, (ulg )570562233L, (ulg )1426400815L,
        3317316542UL, 2998733608UL, (ulg )733239954L, (ulg )1555261956L,
        3268935591UL, 3050360625UL, (ulg )752459403L, (ulg )1541320221L,
        2607071920UL, 3965973030UL, (ulg )1969922972L, (ulg )40735498L,
        2617837225UL, 3943577151UL, (ulg )1913087877L, (ulg )83908371L,
        2512341634UL, 3803740692UL, (ulg )2075208622L, (ulg )213261112L,
        2463272603UL, 3855990285UL, (ulg )2094854071L, (ulg )198958881L,
        2262029012UL, 4057260610UL, (ulg )1759359992L, (ulg )534414190L,
        2176718541UL, 4139329115UL, (ulg )1873836001L, (ulg )414664567L,
        2282248934UL, 4279200368UL, (ulg )1711684554L, (ulg )285281116L,
        2405801727UL, 4167216745UL, (ulg )1634467795L, (ulg )376229701L,
        2685067896UL, 3608007406UL, (ulg )1308918612L, (ulg )956543938L,
        2808555105UL, 3495958263UL, (ulg )1231636301L, (ulg )1047427035L,
        2932959818UL, 3654703836UL, (ulg )1088359270L, (ulg )936918000L,
        2847714899UL, 3736837829UL, (ulg )1202900863L, (ulg )817233897L,
        3183342108UL, 3401237130UL, (ulg )1404277552L, (ulg )615818150L,
        3134207493UL, 3453421203UL, (ulg )1423857449L, (ulg )601450431L,
        3009837614UL, 3294710456UL, (ulg )1567103746L, (ulg )711928724L,
        3020668471UL, 3272380065UL, (ulg )1510334235L, (ulg )755167117L};
# 8428 "gzip.c"
int yesno(void)
{
  char buf[128] ;
  int len ;
  int c ;
  int tmp ;
  unsigned short const **tmp___0 ;
  int tmp___1 ;
  unsigned short const *mem_7 ;
  int __retres8 ;

  {
# 8437 "gzip.c"
  len = 0;
  {
# 8440 "gzip.c"
  while (1) {
    while_continue: ;
# 8440 "gzip.c"
    c = getchar();
# 8440 "gzip.c"
    if (c != -1) {
# 8440 "gzip.c"
      if (c != 10) {

      } else {
# 8440 "gzip.c"
        goto while_break;
      }
    } else {
# 8440 "gzip.c"
      goto while_break;
    }
# 8441 "gzip.c"
    if (len > 0) {
# 8441 "gzip.c"
      if (len < 127) {
# 8442 "gzip.c"
        tmp = len;
# 8442 "gzip.c"
        len ++;
# 8442 "gzip.c"
        buf[tmp] = (char )c;
      } else {
# 8441 "gzip.c"
        goto _L;
      }
    } else
    _L:
# 8441 "gzip.c"
    if (len == 0) {
# 8441 "gzip.c"
      tmp___0 = __ctype_b_loc();
      {
# 8441 "gzip.c"
      mem_7 = *tmp___0 + c;
# 8441 "gzip.c"
      if (((int const )*mem_7 & 8192) != 0) {

      } else {
# 8442 "gzip.c"
        tmp = len;
# 8442 "gzip.c"
        len ++;
# 8442 "gzip.c"
        buf[tmp] = (char )c;
      }
      }
    } else {

    }
  }
  while_break: ;
  }
# 8443 "gzip.c"
  buf[len] = (char )'\000';
# 8445 "gzip.c"
  tmp___1 = rpmatch((char const *)(buf));
# 8445 "gzip.c"
  __retres8 = tmp___1 == 1;
# 8428 "gzip.c"
  return (__retres8);
}
}
# 8457 "gzip.c"
static ulg crc ;
# 8465 "gzip.c"
int zip(int in , int out )
{
  uch flags___0 ;
  ush attr ;
  ush deflate_flags ;
  unsigned int tmp ;
  unsigned int tmp___0 ;
  unsigned int tmp___1 ;
  unsigned int tmp___2 ;
  unsigned int tmp___3 ;
  ulg tmp___4 ;
  unsigned int tmp___5 ;
  ulg tmp___6 ;
  unsigned int tmp___7 ;
  ulg tmp___8 ;
  unsigned int tmp___9 ;
  ulg tmp___10 ;
  unsigned int tmp___11 ;
  ulg tmp___12 ;
  unsigned int tmp___13 ;
  ulg tmp___14 ;
  unsigned int tmp___15 ;
  ulg tmp___16 ;
  unsigned int tmp___17 ;
  ulg tmp___18 ;
  unsigned int tmp___19 ;
  unsigned int tmp___20 ;
  char *p ;
  char *tmp___21 ;
  unsigned int tmp___22 ;
  char *tmp___23 ;
  unsigned int tmp___24 ;
  unsigned int tmp___25 ;
  unsigned int tmp___26 ;
  unsigned int tmp___27 ;
  unsigned int tmp___28 ;
  unsigned int tmp___29 ;
  unsigned int tmp___30 ;
  unsigned int tmp___31 ;
  unsigned int tmp___32 ;
  unsigned int tmp___33 ;
  unsigned int tmp___34 ;
  unsigned int tmp___35 ;
  unsigned int tmp___36 ;
  unsigned int tmp___37 ;
  unsigned int tmp___38 ;
  unsigned int tmp___39 ;
  char const *mem_48 ;
  char const *mem_49 ;
  int __retres50 ;

  {
# 8468 "gzip.c"
  flags___0 = (uch )0;
# 8469 "gzip.c"
  attr = (ush )0;
# 8470 "gzip.c"
  deflate_flags = (ush )0;
# 8472 "gzip.c"
  ifd = in;
# 8473 "gzip.c"
  ofd = out;
# 8474 "gzip.c"
  outcnt = 0U;
# 8478 "gzip.c"
  method = 8;
# 8479 "gzip.c"
  tmp = outcnt;
# 8479 "gzip.c"
  outcnt ++;
# 8479 "gzip.c"
  mem_48 = "\037\213" + 0;
# 8479 "gzip.c"
  outbuf[tmp] = (uch )*mem_48;
# 8479 "gzip.c"
  if (outcnt == 16384U) {
# 8479 "gzip.c"
    flush_outbuf();
  } else {

  }
# 8480 "gzip.c"
  tmp___0 = outcnt;
# 8480 "gzip.c"
  outcnt ++;
# 8480 "gzip.c"
  mem_49 = "\037\213" + 1;
# 8480 "gzip.c"
  outbuf[tmp___0] = (uch )*mem_49;
# 8480 "gzip.c"
  if (outcnt == 16384U) {
# 8480 "gzip.c"
    flush_outbuf();
  } else {

  }
# 8481 "gzip.c"
  tmp___1 = outcnt;
# 8481 "gzip.c"
  outcnt ++;
# 8481 "gzip.c"
  outbuf[tmp___1] = (uch )8;
# 8481 "gzip.c"
  if (outcnt == 16384U) {
# 8481 "gzip.c"
    flush_outbuf();
  } else {

  }
# 8483 "gzip.c"
  if (save_orig_name != 0) {
# 8484 "gzip.c"
    flags___0 = (uch )((int )flags___0 | 8);
  } else {

  }
# 8486 "gzip.c"
  tmp___2 = outcnt;
# 8486 "gzip.c"
  outcnt ++;
# 8486 "gzip.c"
  outbuf[tmp___2] = flags___0;
# 8486 "gzip.c"
  if (outcnt == 16384U) {
# 8486 "gzip.c"
    flush_outbuf();
  } else {

  }
# 8487 "gzip.c"
  if (outcnt < 16382U) {
# 8487 "gzip.c"
    tmp___3 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___4 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___4 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___3] = (uch )((tmp___4 & 65535UL) & 255UL);
# 8487 "gzip.c"
    tmp___5 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___6 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___6 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___5] = (uch )((int )((ush )(tmp___6 & 65535UL)) >> 8);
  } else {
# 8487 "gzip.c"
    tmp___7 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___8 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___8 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___7] = (uch )((tmp___8 & 65535UL) & 255UL);
# 8487 "gzip.c"
    if (outcnt == 16384U) {
# 8487 "gzip.c"
      flush_outbuf();
    } else {

    }
# 8487 "gzip.c"
    tmp___9 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___10 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___10 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___9] = (uch )((int )((ush )(tmp___10 & 65535UL)) >> 8);
# 8487 "gzip.c"
    if (outcnt == 16384U) {
# 8487 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
# 8487 "gzip.c"
  if (outcnt < 16382U) {
# 8487 "gzip.c"
    tmp___11 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___12 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___12 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___11] = (uch )((tmp___12 >> 16) & 255UL);
# 8487 "gzip.c"
    tmp___13 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___14 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___14 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___13] = (uch )((int )((ush )(tmp___14 >> 16)) >> 8);
  } else {
# 8487 "gzip.c"
    tmp___15 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___16 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___16 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___15] = (uch )((tmp___16 >> 16) & 255UL);
# 8487 "gzip.c"
    if (outcnt == 16384U) {
# 8487 "gzip.c"
      flush_outbuf();
    } else {

    }
# 8487 "gzip.c"
    tmp___17 = outcnt;
# 8487 "gzip.c"
    outcnt ++;
# 8487 "gzip.c"
    if ((unsigned long )time_stamp == ((unsigned long )time_stamp & 4294967295UL)) {
# 8487 "gzip.c"
      tmp___18 = (ulg )time_stamp;
    } else {
# 8487 "gzip.c"
      tmp___18 = (ulg )0;
    }
# 8487 "gzip.c"
    outbuf[tmp___17] = (uch )((int )((ush )(tmp___18 >> 16)) >> 8);
# 8487 "gzip.c"
    if (outcnt == 16384U) {
# 8487 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
# 8491 "gzip.c"
  crc = updcrc((uch *)0, 0U);
# 8493 "gzip.c"
  bi_init(out);
# 8494 "gzip.c"
  ct_init(& attr, & method);
# 8495 "gzip.c"
  lm_init(level, & deflate_flags);
# 8497 "gzip.c"
  tmp___19 = outcnt;
# 8497 "gzip.c"
  outcnt ++;
# 8497 "gzip.c"
  outbuf[tmp___19] = (uch )deflate_flags;
# 8497 "gzip.c"
  if (outcnt == 16384U) {
# 8497 "gzip.c"
    flush_outbuf();
  } else {

  }
# 8498 "gzip.c"
  tmp___20 = outcnt;
# 8498 "gzip.c"
  outcnt ++;
# 8498 "gzip.c"
  outbuf[tmp___20] = (uch )3;
# 8498 "gzip.c"
  if (outcnt == 16384U) {
# 8498 "gzip.c"
    flush_outbuf();
  } else {

  }
# 8500 "gzip.c"
  if (save_orig_name != 0) {
# 8501 "gzip.c"
    tmp___21 = base_name(ifname);
# 8501 "gzip.c"
    p = tmp___21;
    {
# 8502 "gzip.c"
    while (1) {
      while_continue: ;
# 8503 "gzip.c"
      tmp___22 = outcnt;
# 8503 "gzip.c"
      outcnt ++;
# 8503 "gzip.c"
      outbuf[tmp___22] = (uch )*p;
# 8503 "gzip.c"
      if (outcnt == 16384U) {
# 8503 "gzip.c"
        flush_outbuf();
      } else {

      }
# 8502 "gzip.c"
      tmp___23 = p;
# 8502 "gzip.c"
      p ++;
# 8502 "gzip.c"
      if (*tmp___23 != 0) {

      } else {
# 8502 "gzip.c"
        goto while_break;
      }
    }
    while_break: ;
    }
  } else {

  }
# 8506 "gzip.c"
  header_bytes = (off_t )outcnt;
# 8508 "gzip.c"
  deflate();
# 8521 "gzip.c"
  if (outcnt < 16382U) {
# 8521 "gzip.c"
    tmp___24 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___24] = (uch )((crc & 65535UL) & 255UL);
# 8521 "gzip.c"
    tmp___25 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___25] = (uch )((int )((ush )(crc & 65535UL)) >> 8);
  } else {
# 8521 "gzip.c"
    tmp___26 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___26] = (uch )((crc & 65535UL) & 255UL);
# 8521 "gzip.c"
    if (outcnt == 16384U) {
# 8521 "gzip.c"
      flush_outbuf();
    } else {

    }
# 8521 "gzip.c"
    tmp___27 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___27] = (uch )((int )((ush )(crc & 65535UL)) >> 8);
# 8521 "gzip.c"
    if (outcnt == 16384U) {
# 8521 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
# 8521 "gzip.c"
  if (outcnt < 16382U) {
# 8521 "gzip.c"
    tmp___28 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___28] = (uch )((crc >> 16) & 255UL);
# 8521 "gzip.c"
    tmp___29 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___29] = (uch )((int )((ush )(crc >> 16)) >> 8);
  } else {
# 8521 "gzip.c"
    tmp___30 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___30] = (uch )((crc >> 16) & 255UL);
# 8521 "gzip.c"
    if (outcnt == 16384U) {
# 8521 "gzip.c"
      flush_outbuf();
    } else {

    }
# 8521 "gzip.c"
    tmp___31 = outcnt;
# 8521 "gzip.c"
    outcnt ++;
# 8521 "gzip.c"
    outbuf[tmp___31] = (uch )((int )((ush )(crc >> 16)) >> 8);
# 8521 "gzip.c"
    if (outcnt == 16384U) {
# 8521 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
# 8522 "gzip.c"
  if (outcnt < 16382U) {
# 8522 "gzip.c"
    tmp___32 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___32] = (uch )(((ulg )bytes_in & 65535UL) & 255UL);
# 8522 "gzip.c"
    tmp___33 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___33] = (uch )((int )((ush )((ulg )bytes_in & 65535UL)) >> 8);
  } else {
# 8522 "gzip.c"
    tmp___34 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___34] = (uch )(((ulg )bytes_in & 65535UL) & 255UL);
# 8522 "gzip.c"
    if (outcnt == 16384U) {
# 8522 "gzip.c"
      flush_outbuf();
    } else {

    }
# 8522 "gzip.c"
    tmp___35 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___35] = (uch )((int )((ush )((ulg )bytes_in & 65535UL)) >> 8);
# 8522 "gzip.c"
    if (outcnt == 16384U) {
# 8522 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
# 8522 "gzip.c"
  if (outcnt < 16382U) {
# 8522 "gzip.c"
    tmp___36 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___36] = (uch )(((ulg )bytes_in >> 16) & 255UL);
# 8522 "gzip.c"
    tmp___37 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___37] = (uch )((int )((ush )((ulg )bytes_in >> 16)) >> 8);
  } else {
# 8522 "gzip.c"
    tmp___38 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___38] = (uch )(((ulg )bytes_in >> 16) & 255UL);
# 8522 "gzip.c"
    if (outcnt == 16384U) {
# 8522 "gzip.c"
      flush_outbuf();
    } else {

    }
# 8522 "gzip.c"
    tmp___39 = outcnt;
# 8522 "gzip.c"
    outcnt ++;
# 8522 "gzip.c"
    outbuf[tmp___39] = (uch )((int )((ush )((ulg )bytes_in >> 16)) >> 8);
# 8522 "gzip.c"
    if (outcnt == 16384U) {
# 8522 "gzip.c"
      flush_outbuf();
    } else {

    }
  }
# 8523 "gzip.c"
  header_bytes = (off_t )((unsigned long )header_bytes + (unsigned long )(2U * sizeof(long )));
# 8525 "gzip.c"
  flush_outbuf();
# 8526 "gzip.c"
  __retres50 = 0;
# 8465 "gzip.c"
  return (__retres50);
}
}
# 8535 "gzip.c"
int file_read(char *buf , unsigned int size )
{
  unsigned int len ;
  ssize_t tmp ;
  int __retres5 ;

  {
# 8543 "gzip.c"
  tmp = read(ifd, (void *)buf, size);
# 8543 "gzip.c"
  len = (unsigned int )tmp;
# 8544 "gzip.c"
  if (len == 0U) {
# 8544 "gzip.c"
    __retres5 = (int )len;
# 8544 "gzip.c"
    goto return_label;
  } else {

  }
# 8545 "gzip.c"
  if (len == 4294967295U) {
# 8546 "gzip.c"
    read_error();
# 8547 "gzip.c"
    __retres5 = -1;
# 8547 "gzip.c"
    goto return_label;
  } else {

  }
# 8550 "gzip.c"
  crc = updcrc((uch *)buf, len);
# 8551 "gzip.c"
  bytes_in += (off_t )len;
# 8552 "gzip.c"
  __retres5 = (int )len;
  return_label:
# 8535 "gzip.c"
  return (__retres5);
}
}
# 8573 "gzip.c"
 __attribute__((__nothrow__)) int ( __attribute__((__nonnull__(1), __leaf__)) rpmatch)(char const *response ) ;
# 8573 "gzip.c"
int ( __attribute__((__nonnull__(1), __leaf__)) rpmatch)(char const *response )
{
  int tmp ;
  int tmp___0 ;

  {
# 8577 "gzip.c"
  if ((int const )*response == 121) {
# 8577 "gzip.c"
    tmp___0 = 1;
  } else
# 8577 "gzip.c"
  if ((int const )*response == 89) {
# 8577 "gzip.c"
    tmp___0 = 1;
  } else {
# 8577 "gzip.c"
    if ((int const )*response == 110) {
# 8577 "gzip.c"
      tmp = 0;
    } else
# 8577 "gzip.c"
    if ((int const )*response == 78) {
# 8577 "gzip.c"
      tmp = 0;
    } else {
# 8577 "gzip.c"
      tmp = -1;
    }
# 8577 "gzip.c"
    tmp___0 = tmp;
  }
# 8577 "gzip.c"
  return (tmp___0);
}
}
# 8582 "gzip.c"
int getopt_long(int argc , char * const *argv , char const *options , struct option const *long_options ,
                int *opt_index )
{
  int tmp ;

  {
# 8590 "gzip.c"
  tmp = _getopt_internal(argc, argv, options, long_options, opt_index, 0);
# 8590 "gzip.c"
  return (tmp);
}
}
# 8598 "gzip.c"
int getopt_long_only(int argc , char * const *argv , char const *options , struct option const *long_options ,
                     int *opt_index )
{
  int tmp ;

  {
# 8606 "gzip.c"
  tmp = _getopt_internal(argc, argv, options, long_options, opt_index, 1);
# 8606 "gzip.c"
  return (tmp);
}
}
