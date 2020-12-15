INSTALLPREFIX  ?= /usr/local

CFLAGS += -O2 -fPIC
CFLAGS += -Wall
CFLAGS += -Wno-strict-aliasing

CXXFLAGS += -O2 -fPIC
CXXFLAGS += -Wall
CXXFLAGS += -Wno-sign-compare
CXXFLAGS += -Wno-deprecated-declarations
CXXFLAGS += -Wno-unused-function

LDID_OBJS += ldid.cpp.o lookup2.c.o
LDFLAGS += -lplist-2.0 -lcrypto -pthread

.PHONY: all clean

all: ldid

%.c.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $^ -I.

%.cpp.o: %.cpp
	$(CXX) $(CXXFLAGS) -std=c++0x -o $@ -c $^ -I.

ldid: $(LDID_OBJS)
	$(CXX) $(CFLAGS) $(CXXFLAGS) -o $@ $^ $(LDFLAGS)

clean:
	rm -f $(LDID_OBJS)

install: all
	mkdir -p $(INSTALLPREFIX)/bin
	cp ldid $(INSTALLPREFIX)/bin
