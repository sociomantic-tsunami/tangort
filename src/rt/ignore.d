// adding these eliminates runtime linking to sprintf, FP, I/O subsystems, etc (22+KB)

module rt.ignore;

extern(C)
{
        void _assert(int x) {throw new Exception("asserted", __FILE__, __LINE__);}
        void _fltused() {throw new Exception("fltused");}
}
