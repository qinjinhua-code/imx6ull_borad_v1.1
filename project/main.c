/**************************************************************
Copyright © zuozhongkai Co., Ltd. 1998-2019. All rights reserved.
文件名	: 	 mian.c
作者	   : 左忠凯
版本	   : V1.0
描述	   : I.MX6U开发板裸机实验4 使用NXP提供的I.MX6ULL官方IAR SDK包开发
其他	   : 前面其他所有实验中，寄存器定义都是我们自己手写的，但是I.MX6U
		 的寄存器有很多，全部自己写太费时间，而且没意义。NXP官方提供了
		 针对I.MX6ULL的SDK开发包，是基于IAR环境的，这个SDK包里面已经提
		 供了I.MX6ULL所有相关寄存器定义，虽然是针对I.MX6ULL编写的，但是同样
		 适用于I.MX6UL。本节我们就将相关的寄存器定义文件移植到Linux环境下，
		 要移植的文件有：
		 fsl_common.h
		 fsl_iomuxc.h
		 MCIMX6Y2.h
		 自定义文件 cc.h
论坛		：www.openedv.com
在线教育	: www.yuanzige.com
日志	   : 初版V1.0 2019/1/3 左忠凯创建
**********************************************************/
#include "bsp_clk.h"
#include "bsp_delay.h"
#include "bsp_led.h"
#include "bsp_beep.h"
#include "bsp_key.h"

// 全局变量led和beep状态指示变量
unsigned char led_state = OFF;
unsigned char beep_state = OFF;


/*
 * @description	: mian函数
 * @param 		: 无
 * @return 		: 无
 */
int main(void)
{
	clk_enable();		/* 使能所有的时钟			*/
	led_init();			/* 初始化led				*/
	beep_init();		/* 初始化beep				*/
	key_init();			/* 初始化key 			*/
	
	int i = 0;

	unsigned char led_state = OFF;
	unsigned char beep_state = OFF;




	while(1)			/* 死循环 				*/
	{	
		keyvalue = key_getvalue();
		if(keyvalue)
		{
			switch ((keyvalue))
			{
				case KEY0_VALUE:
					beep_state = !beep_state;
					beep_switch(beep_state);
					break;
			}
		}

		i++;
		if(i==50)
		{
			i = 0;
			led_state = !led_state;
			led_switch(LED0, led_state);
		}
		delay(10);
	}

	return 0;
}


/*
 * @description	: 自定义APP
  * @param 		: 无
 * @return 		: 无
 */







