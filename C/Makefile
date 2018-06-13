CC := gcc
CFLAGS := -Wall

EXE := main

all: $(EXE)

main: main.o utils.o
	$(CC) $(CFLAGS) $^ -o $@

main.o: main.c
	$(CC) $(CFLAGS) -c $<

utils.o: utils.c utils.h
	$(CC) $(CFLAGS) -c $<

solver.o: solver.c solver.h
	$(CC) $(CFLAGS) -c $<

clean:
	rm *.o $(EXE)
