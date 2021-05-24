CC=gcc 
CFLAG = -g -Wall 
sort: sort.o
	$(CC) sort.o -o $@

sort.o: sort.c
	$(CC) 	$(CFLAG) sort.c -o $@

clean:
	rm -f sort sort.o

