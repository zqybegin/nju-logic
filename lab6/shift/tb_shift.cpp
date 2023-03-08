#include <nvboard.h>
#include <Vshift.h>
#include <stdio.h>
Vshift *dut = new Vshift;

int main() {
    int count = 0;

    nvboard_init();
	nvboard_bind_pin(&dut->en   , BIND_RATE_SCR, BIND_DIR_IN, 1, SW12);
	nvboard_bind_pin(&dut->sel  , BIND_RATE_SCR, BIND_DIR_IN, 3, SW15,SW14,SW13);
	nvboard_bind_pin(&dut->in   , BIND_RATE_SCR, BIND_DIR_IN, 8, SW7, SW6, SW5, SW4, SW3, SW2, SW1, SW0);
	nvboard_bind_pin(&dut->load , BIND_RATE_SCR, BIND_DIR_IN, 1, SW11); 
	nvboard_bind_pin(&dut->out, BIND_RATE_SCR, BIND_DIR_OUT, 8, LD7,LD6,LD5,LD4,LD3,LD2,LD1,LD0);
    dut->clk = 1;

    while(1){
        if(count == 500000){
            dut->clk ^= 1;
            count = 0;
        }
        dut->eval();
        nvboard_update();
        count++;
        printf("%d\n",count);
    }

    nvboard_quit();
    return 0;
}
