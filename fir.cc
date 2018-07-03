/**
 * fir.cc
 */

#include "fir.h"

void fir::fir_main(void) {
	outp.write(0);
	wait();

	while( true ) {
		for (int i = 5 - 1; i > 0; i--) {
			taps[i] = taps[i - 1];
		}
		taps[0] = inp.read();

		sc_int<16> val;
		for (int i = 0; i < 5; i++) {
			val += coef[i] * taps[i];
		}
		outp.write( val );
		wait();
	}
}