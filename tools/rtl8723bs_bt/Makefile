rtk_hciattach:hciattach.c hciattach_rtk.o  
	/usr/local/rk3188/arm-eabi-4.6/bin/arm-eabi-gcc -I/usr/include -o rtk_hciattach hciattach.c hciattach_rtk.o  

hciattach_rtk.o:hciattach_rtk.c
	/usr/local/rk3188/arm-eabi-4.6/bin/arm-eabi-gcc -I/usr/include -c hciattach_rtk.c

clean:
	rm -f *.o  rtk_hciattach

install:
	mkdir -p /lib/firmware/rtl_bt
	cp -p rtlbt_* /lib/firmware/rtl_bt/.
