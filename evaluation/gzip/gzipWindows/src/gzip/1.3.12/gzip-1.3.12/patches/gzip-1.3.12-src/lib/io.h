#ifndef _NONPOSIX_IO_H
#define _NONPOSIX_IO_H 1

#include_next <io.h> /* defines lseek etc on Win32 */

#ifdef _WIN32

#define lseek		_lseeki64
#define lseek64	_lseeki64
#define tell		_telli64
#define tell64		_telli64

#endif /* _WIN32 */

#endif /* io.h  */
