# Makefile for rpi-omx-jpeg-encode

# Settings
CC=g++
GCC=gcc
CFLAGS=-Wall -I/opt/vc/include -O3 -mcpu=cortex-a7 -mfpu=neon-vfpv4 -ftree-vectorize -mfloat-abi=hard
LDFLAGS=-L/opt/vc/lib -lpthread -lbcm_host -lvcos -lopenmaxil
OPENCV_LDFLAGS=-lopencv_core -lopencv_imgproc -lopencv_highgui -lopencv_ml -lopencv_video -lopencv_features2d -lopencv_calib3d -lopencv_objdetect -lopencv_flann -lopencv_imgcodecs 

# Colours
YELLOW=\033[1;33m
BLUE=\033[0;34m
NC=\033[0m

all: jpeg_bench

jpeg_bench:
	@echo "$(YELLOW)Building JPEG Benchmark...$(YELLOW)"
	@$(CC) $(CFLAGS) jpeg_bench.cpp -o jpeg_bench $(LDFLAGS) $(OPENCV_LDFLAGS)
	
clean:
	@echo "$(BLUE)Cleaning all binaries...$(NC)"
	@rm -f jpeg_bench
