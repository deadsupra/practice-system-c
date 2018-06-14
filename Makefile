CC = g++
CFLAGS =
SYSTEMC_HOME = /usr/local/systemc232
DEPS = -I. -I$(SYSTEMC_HOME)/include -L. -L$(SYSTEMC_HOME)/lib-linux64

all: main

main:
	$(CC) $(DEPS) -Wl,-rpath=$(SYSTEMC_HOME)/lib-linux64 -o main main.cpp -lsystemc -lm

clean:
	rm *.o main
