# Do not edit this Makefile.
# It will compile all .c files in the directory
# and produce a binary named: q2

SRC:= $(wildcard *.c)

q2: $(SRC)
	clang -o q2 $^ -Wall -lm -g

build_tests:
	./q2 < input0 > my_output0
	./q2 < input1 > my_output1
	./q2 < input2 > my_output2
	./q2 < input3 > my_output3

run_tests:
	diff -w -B ref_output0 my_output0
	diff -w -B ref_output1 my_output1
	diff -w -B ref_output2 my_output2
	diff -w -B ref_output3 my_output3

