# rpi-omx-jpeg-encode
Hardware JPEG Encoding on Raspberry Pi using OpenMAX IL.

### Description ###
This repository contains source code to utilize the hardware JPEG encoder on the RPi GPU to do JPEG encoding.

### Building ###
	make clean && make all

### Usage ###
	./jpeg-bench <frame_count> > <jpeg_data_output>
	Recommended <jpeg_data_output> to /dev/null
	Example: ./jpeg-bench 20 > /dev/null
	If you want to output single JPEG image with OMX Encoder, modify the soruce code of jpeg_bench.cpp, set "ENABLE_WRITE_IN_B4" to 1 and others to 0, compile and run with ./jpeg_bench 1 > ./omx_image.jpg

### Files ###
**Makefile:**
> Makefile for the project

**jpeg_bench.cpp:**
> Contains 4 benchmarks which compare jpeg encoding speed with openCV.
>
> The speedup is over 1x tested on RPi 2.
>
> Benchmark 1: openCV JPEG decode and openCV JPEG encode
> 
> Benchmark 2: openCV JPEG decode and openCV JPEG encode with 1/2 resize
> 
> Benchmark 3: openCV JPEG decode and openCV JPEG encode with 1/2 pryDown
> 
> Benchmark 4: openCV JPEG decode and RPi OMX Hardware JPEG encode

*jpeg_bench.cpp relies on jpeg_bench_image.h, which provide smaple JPEG data for decoding.*

*The image is taken from wikimedia:*

*[https://commons.wikimedia.org/wiki/File:Burosch_Blue-Only_Test_pattern.jpg](https://commons.wikimedia.org/wiki/File:Burosch_Blue-Only_Test_pattern.jpg)*

The supplied image is 1280*720 in size, feel free to use your own image in any size, remember to modify the following values when you do so:

	jpeg_bench.cpp marcos:   
	IMAGE_WIDTH		(JPEG image width)
	IMAGE_HEIHGT	(JPEG image height)
	IMAGE_CHANNELS	(JPEG image channels, usually 3)
	
	jpeg_bench_image.h marcos:
	JPEG_DATA_SIZE	(JPEG image size)
	
	jpeg_bench_image.h variables:
	jpegData		(JPEG image data)
	

### Test results ##
- Raspberry Pi 2, 200 frames

	[1] openCV JPEG decode and encode
	
	Result CPU Clocks: 24359705 (24s)
	
	[2] openCV JPEG decode and encode with openCV resize 1/2 *
	
	Result CPU Clocks: 16562283 (16s)
	
	[3] openCV JPEG decode and encode with openCV pryDown 1/2 *
	
	Result CPU Clocks: 19074908 (19s)
	
	[4] openCV JPEG decode and OMX encode
	
	Result CPU Clocks: 10463216 (10s)

### Additional Notes ###
You can extract the omx code in jpeg_bench.cpp and copy into your project to use the OMX Hardware JPEG Encoder. It is quite nice to use that to replace openCV *imencode* for JPEG as the speed up is quite noticable.

Despite the openCV Mat is using BGR888 structure, you need to configure the OMX Encoder to RGB888 to have correct image output. Please refer to [https://www.raspberrypi.org/forums/viewtopic.php?f=70&t=172670&p=1104848](this) for more information.

Note to RPi1 user: The Makefile used NEON and VFPv4 optimizations which are not supported in RPi1, please remove those from the cflags.

### Feature in the future ###
- Add options to modify the QFactor of the JPEG encoder

## Known Bugs ###
- At 1920x1080, you will get Seg. Fault, still no idea why. Tested resolutions: 1280x720, 640x480

### References ###
- Supplied image: [https://commons.wikimedia.org/wiki/File:Burosch_Blue-Only_Test_pattern.jpg](https://commons.wikimedia.org/wiki/File:Burosch_Blue-Only_Test_pattern.jpg)
- OMX Encoder inspiration: [OpenMAX IL demos for Raspberry Pi](https://github.com/tjormola/rpi-openmax-demos/)
