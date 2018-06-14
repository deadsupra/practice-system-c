CC=g++
CFLAGS=
DEPS = -I. -I\$SYSTEMC_HOME/include -L. -L\$SYSTEMC_HOME/lib-linux64

all: main

main: main.o message.o
	$(CC) main.o message.o -o testexe

main.o: main.cpp
	$(CC) -c main.cpp

sysc: 
	$(CC) $(DEPS) -Wl,-rpath=\$SYSTEMC_HOME/lib-linux64 -o hello main.cpp -lsystemc -lm


clean:
	rm *.o testexe
