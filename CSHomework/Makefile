all: trace

lc4: lc4.c lc4.h
	clang lc4.c -o lc4

objectfiles: object_files.c object_files.h lc4.c lc4.h
	clang object_files.c lc4.c -o objectfiles

trace: object_files.c object_files.h lc4.c lc4.h trace.c
	clang trace.c object_files.c lc4.c -o trace

#
# THIS IS FOR GRADING. DO NOT MODIFY THIS TARGET.
#
testlc4: testlc4.c lc4
	clang -g -o testlc4 lc4.o

clean:
	rm -f *.o
	rm -f trace
	rm -f *.exe
	rm -f *.trace
