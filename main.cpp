#include <systemc.h>

using namespace std;

SC_MODULE (hello_world) {
	SC_CTOR(hello_world) {

	}
	void say_hello() {
		cout << "Hello paul.\n";
	}
};

SC_MODULE (fivebitcounter) {
	sc_in clk, reset, load;
	sc_out > q;
	sc_out > parallelin;

	SC_CTOR(fivebitcounter) {
		void clkme();
		SC_METHOD(clkme);
		sensitive << clk.pos() << reset.pos();
	}

	void clkme() {
		if (reset.read()) q = 0;
		else if (load.read()) q = parallelin.read();
		else {
			int nv = q.read() + 1;
			printf("Five pending set to %i\n", nv);
			q = nv;
		}
	}
};

int sc_main(int argc, char* argv[]) {
	hello_world hello("HELLO");
	hello.say_hello();

	return 0;
}