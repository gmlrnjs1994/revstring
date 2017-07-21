
all : a

a : a.o
	ld -o a a.o

a.o : a.s
	nasm -f elf64 a.s

clean :
	rm *.o a
