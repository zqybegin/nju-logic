#include <nvboard.h>
#include <Vmux41.h>

Vmux41 *dut = new Vmux41;

int main() {

    nvboard_init();
    nvboard_bind_pin(&dut->Y , BIND_RATE_SCR, BIND_DIR_IN,  2, SW1, SW0);
    nvboard_bind_pin(&dut->X0, BIND_RATE_SCR, BIND_DIR_IN,  2, SW3, SW2);
    nvboard_bind_pin(&dut->X1, BIND_RATE_SCR, BIND_DIR_IN,  2, SW5, SW4);
    nvboard_bind_pin(&dut->X2, BIND_RATE_SCR, BIND_DIR_IN,  2, SW7, SW6);
    nvboard_bind_pin(&dut->X3, BIND_RATE_SCR, BIND_DIR_IN,  2, SW9, SW8);
    nvboard_bind_pin(&dut->F , BIND_RATE_SCR, BIND_DIR_OUT, 2, LD1, LD0);

    while(1){
        dut->eval();
        nvboard_update();
    }

    nvboard_quit();
    return 0;
}
