CFLAGS = -I.. -Wall -g

all: libmylib.so

%.o : %.c
	$(CC) -c $(CFLAGS) $^ -o $@

libmylib.so: mylib.o
	$(CC) --shared $^ -o $@

clean:
	rm -f *.so *.o

