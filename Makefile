ARCH := $(shell getconf LONG_BIT)

CC = gcc
CXX = g++
CFLAGS = -I.
CXXFLAGS = -Wall -I.

# program output name
OUT = output

# Determine lib-linux folder
ifeq ($(ARCH),64)
	LIB_LINUX = lib-linux64
else
	LIB_LINUX = lib-linux
endif

# Ensure SYSTEMC_HOME is defined for environment variables
ifeq (${SYSTEMC_HOME},)
	echo "SYSTEMC_HOME environment variable not set"
else
	echo "SYSTEMC_HOME is set"
endif

# systemC standard dependencies
DEPS = -I. -I${SYSTEMC_HOME}/include -L. -L${SYSTEMC_HOME}/$(LIB_LINUX) -Wl,-rpath=${SYSTEMC_HOME}/$(LIB_LINUX)

all: main
	./$(OUT)

install:

clean:
	rm *.o $(OUT)

main: main.cpp
	$(CXX) $(DEPS) -o $(OUT) main.cpp -lsystemc -lm
