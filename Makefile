ARCH := $(shell getconf LONG_BIT)

CC = gcc
CXX = g++
CFLAGS = -I.
CXXFLAGS = -c -Wall -I.

OUT = output
ifeq ($(ARCH),64)
	LIB_LINUX = lib-linux64
else
	LIB_LINUX = lib-linux
endif
DEPS = -I. -I${SYSTEMC_HOME}/include -L. -L${SYSTEMC_HOME}/$(LIB_LINUX) -Wl,-rpath=${SYSTEMC_HOME}/$(LIB_LINUX)

all: main
	./$(OUT)

install:

clean:
	rm *.o $(OUT)

main: main.cpp
	$(CXX) $(DEPS) -o $(OUT) main.cpp -lsystemc -lm
