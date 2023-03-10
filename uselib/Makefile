CFLAGS = -I.. -Wall -g

all: libs uselib_none uselib_rpath uselib_runpath_rel uselib_runpath_abs uselib_runpath_origin

.PHONY: libs clean run

%.o : %.c
	$(CC) -c $(CFLAGS) $^ -o $@

uselib_none: uselib.o
	$(CC) $< -o $@ -L../mylibA -lmylib

uselib_rpath: uselib.o
	$(CC) $< -o $@ -L../mylibA -lmylib -Wl,-rpath,./mylibA -Wl,--disable-new-dtags

uselib_runpath_rel: uselib.o
	$(CC) $< -o $@ -L../mylibA -lmylib -Wl,-rpath,./mylibA

uselib_runpath_abs: uselib.o
	$(CC) $< -o $@ -L../mylibA -lmylib -Wl,-rpath,$$PWD/../mylibA

uselib_runpath_origin: uselib.o
	$(CC) $< -o $@ -L../mylibA -lmylib '-Wl,-rpath,$$ORIGIN/../mylibA'


clean:
	rm -f uselib_* *.o
