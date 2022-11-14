all:
	g++ -g test.cpp -o eval_test `pkg-config --cflags --libs hiredis` -I./json /home/feng/.config/nvim/json/libs/linux-gcc-4.2.4/libjson_linux-gcc-4.2.4_libmt.a
