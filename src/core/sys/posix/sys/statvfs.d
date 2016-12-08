/**
*    statvfs - VFS File System information structure
* from sys/statvfs.h
* http://www.opengroup.org/onlinepubs/009695399/basedefs/sys/statvfs.h.html
*
* Copyright: Fawzi Mohamed
* License:   tango license
* Authors:   Fawzi Mohamed
*/

module core.sys.posix.sys.statvfs;
import core.stdc.config;

struct statvfs_t
{
    c_ulong f_bsize;
    c_ulong f_frsize;
    c_ulong f_blocks;
    c_ulong f_bfree;
    c_ulong f_bavail;
    c_ulong f_files;
    c_ulong f_ffree;
    c_ulong f_favail;
    c_ulong f_fsid;
    c_ulong f_flag;
    c_ulong f_namemax;
    int[6] __f_spare;
};
enum
{
    ST_RDONLY = 1,
    ST_NOSUID = 2,
}

extern(C){
    int fstatvfs(int, statvfs_t *);
    int statvfs(char * , statvfs_t *);
}
