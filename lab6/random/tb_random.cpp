#include <nvboard.h>
#include <Vrandom.h>

Vrandom *dut = new Vrandom;

int main() {

    int count = 0;

    nvboard_init();
	nvboard_bind_pin(&dut->en, BIND_RATE_SCR, BIND_DIR_IN, 1, SW15);
	nvboard_bind_pin(&dut->rst, BIND_RATE_SCR, BIND_DIR_IN, 1, SW14);
	nvboard_bind_pin(&dut->in, BIND_RATE_SCR, BIND_DIR_IN, 8, SW7, SW6, SW5, SW4, SW3, SW2, SW1, SW0 );
	nvboard_bind_pin(&dut->out, BIND_RATE_SCR, BIND_DIR_OUT, 8, LD7,LD6,LD5,LD4,LD3,LD2,LD1,LD0);
	nvboard_bind_pin(&dut->hex, BIND_RATE_SCR, BIND_DIR_OUT, 16, SEG1A, SEG1B, SEG1C, SEG1D, SEG1E, SEG1F, SEG1G, DEC1P, SEG0A, SEG0B, SEG0C, SEG0D, SEG0E, SEG0F, SEG0G, DEC0P);
    while(1){
        if(count == 200){
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
