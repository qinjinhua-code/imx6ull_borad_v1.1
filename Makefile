CROSS_COMPILE ?= arm-linux-gnueabihf-
TARGET		  ?= target

CC 		:= $(CROSS_COMPILE)gcc
LD		:= $(CROSS_COMPILE)ld
OBJCOPY := $(CROSS_COMPILE)objcopy
OBJDUMP := $(CROSS_COMPILE)objdump



# 头文件包含路径
INCDIRS	:= imx6ul \
		   bsp/clk \
   		   bsp/led \
  		   bsp/delay \
		   bsp/beep \
		   bsp/key \
		   bsp/gpio


# 源文件包含路径
SRCDIRS := project \
		   bsp/clk \
   		   bsp/led \
  		   bsp/delay \
		   bsp/beep \
		   bsp/key \
		   bsp/gpio

# 给变量添加-I符号
# 例如： INCLUDE := -I imx6ul -I bsp/clk -I bsp/led
INCLUDE := $(patsubst %, -I %, $(INCDIRS))


#从源文件路径中筛选出所有.s 和 .o 文件
#例如: CFILES = project/main.c bsp/clk/bsp_clk.c bsp/led/bsp_led.c
SFILES := $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.S))
CFILES := $(foreach dir, $(SRCDIRS), $(wildcard $(dir)/*.c))

#去掉文件路径
#例如：
# CFILES = project/main.c bsp/clk/bsp_clk.c bsp/led/bsp_led.c
# CFILENDIR = main.c bsp_clk.c bsp_led.c
SFILENDIR := $(notdir $(SFILES))
CFILENDIR := $(notdir $(CFILES))

#编译成.o文件后制定的目录
#例如：
# SOBJS = obj/start.o
# COBJS = obj/main.o obj/bsp_clk.o obj/bsp_led.o
# OBJS为SOBJS、COBJS的集合
# OBJS = obj/start.o obj/main.o obj/bsp_clk.o obj/bsp_led.o
SOBJS := $(patsubst %, obj/%, $(SFILENDIR:.S=.o))
COBJS := $(patsubst %, obj/%, $(CFILENDIR:.c=.o))
OBJS := $(SOBJS) $(COBJS)

# 指定搜索路径
VPATH := $(SRCDIRS)

.PHONY: clean




$(TARGET).bin : $(OBJS)
	$(LD) -Timx6ul.lds -o $(TARGET).elf $^
	$(OBJCOPY) -O binary -S $(TARGET).elf $@
	$(OBJDUMP) -D -m arm $(TARGET).elf > $(TARGET).dis


$(SOBJS) : obj/%.o : %.S
	$(CC) -Wall -nostdlib -c -O2  $(INCLUDE) -o $@ $<

$(COBJS) : obj/%.o : %.c
	$(CC) -Wall -nostdlib -c -O2  $(INCLUDE) -o $@ $<
	
clean:
	# rm -rf *.o $(NAME).bin $(NAME).elf $(NAME).dis *.imx
	rm -rf $(TARGET).elf $(TARGET).dis $(TARGET).bin $(COBJS) $(SOBJS) *.imx


	
