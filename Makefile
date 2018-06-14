CC=g++
CFLAGS=
DEPS = -I. 

all: main

main: main.o message.o
	$(CC) main.o message.o -o testexe

main.o: main.cpp
	$(CC) -c main.cpp

sysc: 
	$(CC) -I. -I$SYSTEMC_HOME/include -L. -L$SYSTEMC_HOME/lib-linux -Wl,-rpath=$SYSTEMC_HOME/lib-linux -o hello main.cpp -lsystemc -lm


clean:
	rm *.o testexe
