#include <nvboard.h>
#include <Vtop.h>

Vtop *dut = new Vtop;

int main() {

    nvboard_init();
    nvboard_bind_pin(&dut->x  , BIND_RATE_SCR, BIND_DIR_IN, 8, SW7 ,SW6 ,SW5 ,SW4 ,SW3 ,SW2 ,SW1 ,SW0);
    nvboard_bind_pin(&dut->en , BIND_RATE_SCR, BIND_DIR_IN, 1, SW8 );
    nvboard_bind_pin(&dut->y  , BIND_RATE_SCR, BIND_DIR_OUT, 3, LD2 ,LD1 ,LD0);
    nvboard_bind_pin(&dut->out, BIND_RATE_SCR, BIND_DIR_OUT, 1, LD4 );
    nvboard_bind_pin(&dut->hex, BIND_RATE_SCR, BIND_DIR_OUT, 8, SEG0A, SEG0B, SEG0C, SEG0D, SEG0E, SEG0F, SEG0G, DEC0P);

    while(1){
        dut->eval();
        nvboard_update();
    }

    nvboard_quit();
    return 0;
}
