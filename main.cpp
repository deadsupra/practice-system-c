/**
 * 
 */

#include <stdio.h>
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
	sc_in <bool> clk, reset, load;
	sc_out <sc_uint<5> > q;
	sc_out <sc_uint<5> > parallelin;

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

SC_MODULE(clkgen) {
	sc_out <bool> clk;

	SC_CTOR(clkgen) { SC_THREAD(runme);}

	void runme() {
		clk = 0;
		while(1) {
			cout << "Toggle at " << sc_time_stamp() << "\n";
			wait(50, SC_NS);
			clk = !clk.read();
		}
	}
};

int sc_main(int argc, char* argv[]) {
	hello_world hello("HELLO");
	hello.say_hello();

	printf("fixed-field arithmetic/counter example:\n");

	sc_trace_file *tf = sc_create_vcd_trace_file("trace");
	tf->set_time_unit(1, SC_NS);

	sc_signal <bool> clk, load, reset;
	sc_signal <sc_uint <5> > parallelin, q;

	clkgen u_clkgen("u_clkgen");
	u_clkgen.clk(clk);

	fivebitcounter u_fivebitcounter("u_fivebitcounter");
	u_fivebitcounter.clk(clk);
	u_fivebitcounter.parallelin(parallelin);
	u_fivebitcounter.load(load);
	u_fivebitcounter.q(q);
	u_fivebitcounter.reset(reset);

	sc_trace(tf, parallelin, "parallelin");
	sc_trace(tf, q, "q");
	sc_trace(tf, clk, "clk");
	sc_trace(tf, load, "load");
	sc_trace(tf, reset, "reset");

	// useful but crude way of generating input stimulus
	reset = 1;
	parallelin = 0;
	load = 0;
	cout << "Exiting from reset at " << sc_time_stamp() << "\n";

	sc_start(4000, SC_NS);
	parallelin = 4;
	load = 1;
	cout << "Set load high at " << sc_time_stamp() << "\n";
	sc_start(2000, SC_NS);

	cout << "Finished at " << sc_time_stamp() << "\n";

	return 0;
}