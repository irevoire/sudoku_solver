CC := gcc
CFLAGS := -Wall -O2

EXE := main

all: $(EXE)

main: main.o utils.o solver.o
	$(CC) $(CFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $<

utils.o: utils.c utils.h
	$(CC) $(CFLAGS) -c $<

solver.o: solver.c solver.h
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o $(EXE)

