CC := gcc
CFLAGS := -Wall -O2

EXE := main solve

all: $(EXE)

main: main.o utils.o solver.o
	$(CC) $(CFLAGS) $^ -o $@

solve: solve.o utils.o solver.o
	$(CC) $(CFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $<

solve.o: solve.c
	$(CC) $(CFLAGS) -c $<

utils.o: utils.c utils.h
	$(CC) $(CFLAGS) -c $<

solver.o: solver.c solver.h
	$(CC) $(CFLAGS) -c $<

clean:
	rm -f *.o $(EXE)

