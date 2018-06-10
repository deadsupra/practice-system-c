CC=g++
CFLAGS=
DEPS = 

all: main

main: main.o message.o
	$(CC) main.o message.o -o testexe

main.o: main.cpp
	$(CC) -c main.cpp

message.o: message.cpp message.h
	$(CC) -c message.cpp

clean:
	rm *.o testexe
