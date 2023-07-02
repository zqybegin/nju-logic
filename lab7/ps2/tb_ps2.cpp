#include <nvboard.h>
#include <Vps2.h>
#include <stdio.h>
Vps2 *dut = new Vps2;

int main() {

    nvboard_init();
    nvboard_bind_pin(&dut->ps2_clk,   BIND_RATE_RT,  BIND_DIR_IN,  1, PS2_CLK);
    nvboard_bind_pin(&dut->ps2_data,  BIND_RATE_RT,  BIND_DIR_IN,  1, PS2_DAT);
    nvboard_bind_pin(&dut->overflow,  BIND_RATE_SCR, BIND_DIR_OUT, 1, LD0);
    nvboard_bind_pin(&dut->hex_data,  BIND_RATE_SCR, BIND_DIR_OUT, 16, SEG1A, SEG1B, SEG1C, SEG1D, SEG1E, SEG1F, SEG1G, DEC1P, SEG0A, SEG0B, SEG0C, SEG0D, SEG0E, SEG0F, SEG0G, DEC0P);
    nvboard_bind_pin(&dut->hex_acii,  BIND_RATE_SCR, BIND_DIR_OUT, 16, SEG3A, SEG3B, SEG3C, SEG3D, SEG3E, SEG3F, SEG3G, DEC3P, SEG2A, SEG2B, SEG2C, SEG2D, SEG2E, SEG2F, SEG2G, DEC2P);
    nvboard_bind_pin(&dut->hex_count, BIND_RATE_SCR, BIND_DIR_OUT, 16, SEG5A, SEG5B, SEG5C, SEG5D, SEG5E, SEG5F, SEG5G, DEC5P, SEG4A, SEG4B, SEG4C, SEG4D, SEG4E, SEG4F, SEG4G, DEC4P);
    nvboard_bind_pin(&dut->hex_show,  BIND_RATE_SCR, BIND_DIR_OUT, 16, SEG7A, SEG7B, SEG7C, SEG7D, SEG7E, SEG7F, SEG7G, DEC7P, SEG6A, SEG6B, SEG6C, SEG6D, SEG6E, SEG6F, SEG6G, DEC6P);

    dut->rst = 1;
    dut->clk = 1;
    int count = 0;

    while(1){
        dut->rst = 0;
        dut->clk ^= 1;
        dut->eval();
        nvboard_update();
    }

    nvboard_quit();
    return 0;
}
