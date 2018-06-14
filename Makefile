CC = g++
CFLAGS =
SYSTEMC_HOME = /usr/local/systemc232
DEPS = -I. -I$(SYSTEMC_HOME)/include -L. -L$(SYSTEMC_HOME)/lib-linux64

all: main

main: main.o
	$(CC) $(DEPS) -Wl,-rpath=$(SYSTEMC_HOME)/lib-linux64 -o main.cpp -lsystemc -lm

main.o: main.cpp
	$(CC) -c main.cpp

clean:
	rm *.o main
