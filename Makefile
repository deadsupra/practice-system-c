# This is a makefile for systemC program

# Determine Operating System
ifeq ($(OS),Windows_NT)
	ifeq ($(PROCESSOR_ARCHITEW6432),AMD64)
		CCFLAGS += -D AMD64
	else
		ifeq ($(PROCESSOR_ARCHITECTURE),AMD64)
			CCFLAGS += -D AMD64
		endif
		ifeq ($(PROCESSOR_ARCHITECTURE),x86)
			CCFLAGS += -D IA32
		endif
	endif
else
	UNAME_S := $(shell uname -s)
	ifeq ($(UNAME_S),Linux)
			CCFLAGS += -D LINUX
	endif
	ifeq ($(UNAME_S),Darwin)
		CCFLAGS += -D OSX
	endif
	UNAME_P := $(shell uname -p)
	ifeq ($(UNAME_P),x86_64)
		CCFLAGS += -D AMD64
	endif
	ifneq ($(filter %86,$(UNAME_P)),)
		CCFLAGS += -D IA32
	endif
	ifneq ($(filter arm%,$(UNAME_P)),)
		CCFLAGS += -D ARM
	endif
endif

# Determine architecture
ARCH := $(shell getconf LONG_BIT)

# Compiler and compiler flag options
CC = gcc
CXX = g++
CFLAGS = -I.
CXXFLAGS = -Wall -I.

# Determine lib-linux folder
ifeq ($(ARCH),64)
	LIB_LINUX = lib-linux64
else
	LIB_LINUX = lib-linux
endif

# Ensure SYSTEMC_HOME is defined for environment variables
ifeq (${SYSTEMC_HOME},)
	TEMP_MESSAGE = SYSTEMC_HOME environment variable not set
	echo $(TEMP_MESSAGE)
endif

# program output name
OUT = output

# systemC standard dependencies
DEPS = -I. -I${SYSTEMC_HOME}/include -L. -L${SYSTEMC_HOME}/$(LIB_LINUX) -Wl,-rpath=${SYSTEMC_HOME}/$(LIB_LINUX)

all: main
	./$(OUT)

install:

clean:
	rm *.o $(OUT)

main: main.cpp
	$(CXX) $(DEPS) -o $(OUT) main.cpp -lsystemc -lm

test:
	echo $(CCFLAGS)