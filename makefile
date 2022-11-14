all:
	g++ -g test.cpp -o eval_test `pkg-config --cflags --libs hiredis`
