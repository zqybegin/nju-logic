#include <nvboard.h>
#include <Valu.h>

Valu *dut = new Valu;

int main() {

    nvboard_init();
    nvboard_bind_pin(&dut->sel  , BIND_RATE_SCR, BIND_DIR_IN, 3, SW15,SW14,SW13);
    nvboard_bind_pin(&dut->opdata1, BIND_RATE_SCR, BIND_DIR_IN, 4, SW3, SW2, SW1, SW0 );
    nvboard_bind_pin(&dut->opdata2, BIND_RATE_SCR, BIND_DIR_IN, 4, SW7, SW6, SW5, SW4 );
    nvboard_bind_pin(&dut->zero, BIND_RATE_SCR, BIND_DIR_OUT, 1, LD15); 
    nvboard_bind_pin(&dut->overflow, BIND_RATE_SCR, BIND_DIR_OUT, 1, LD14); 
    nvboard_bind_pin(&dut->cout, BIND_RATE_SCR, BIND_DIR_OUT, 1, LD13); 
    nvboard_bind_pin(&dut->result, BIND_RATE_SCR, BIND_DIR_OUT, 4, LD3,LD2,LD1,LD0);
    nvboard_bind_pin(&dut->result_arith, BIND_RATE_SCR, BIND_DIR_OUT, 4, LD7,LD6,LD5,LD4);

    while(1){
        dut->eval();
        nvboard_update();
    }

    nvboard_quit();
    return 0;
}
