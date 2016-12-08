module core.sys.linux.termios;

static import core.sys.posix.sys.ioctl;

deprecated ("Import core.sys.posix.sys.ioctl instead")
alias core.sys.posix.sys.ioctl.winsize winsize;
