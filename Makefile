CFLAGS = -I.. -Wall -g

all: deps

.PHONY: deps clean run

%.o : %.c
	$(CC) -c $(CFLAGS) $^ -o $@

run:
	./uselib/uselib_none           ; echo
	./uselib/uselib_rpath          ; echo
	./uselib/uselib_runpath_rel    ; echo
	./uselib/uselib_runpath_abs    ; echo
	./uselib/uselib_runpath_origin ; echo
	LD_LIBRARY_PATH=./mylibB ./uselib/uselib_none           ; echo
	LD_LIBRARY_PATH=./mylibB ./uselib/uselib_rpath          ; echo
	LD_LIBRARY_PATH=./mylibB ./uselib/uselib_runpath_rel    ; echo
	LD_LIBRARY_PATH=./mylibB ./uselib/uselib_runpath_abs    ; echo
	LD_LIBRARY_PATH=./mylibB ./uselib/uselib_runpath_origin ; echo
	mkdir -p test
	cd test ; ../uselib/uselib_rpath          ; echo
	cd test ; ../uselib/uselib_runpath_rel    ; echo
	cd test ; ../uselib/uselib_runpath_abs    ; echo
	cd test ; ../uselib/uselib_runpath_origin ; echo

check:
	readelf -d ./uselib/uselib_rpath          | grep path
	readelf -d ./uselib/uselib_runpath_rel    | grep path
	readelf -d ./uselib/uselib_runpath_abs    | grep path
	readelf -d ./uselib/uselib_runpath_origin | grep path

deps:
	cd mylibA; $(MAKE)
	cd mylibB; $(MAKE)
	cd uselib; $(MAKE)

clean:
	cd mylibA; $(MAKE) clean
	cd mylibB; $(MAKE) clean
	cd uselib; $(MAKE) clean
