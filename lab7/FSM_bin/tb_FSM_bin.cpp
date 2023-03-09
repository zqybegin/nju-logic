#include "verilated.h"
#include "verilated_vcd_c.h"
#include "VFSM_bin.h"

VerilatedContext* contextp = NULL;
VerilatedVcdC* tfp = NULL;

static VFSM_bin* top;

void sim_init(){
	contextp = new VerilatedContext;
	tfp = new VerilatedVcdC;
	top = new VFSM_bin;
	contextp->traceEverOn(true);
	top->trace(tfp, 0);
	tfp->open("dump.vcd");
}

int main() {
    int posedge_cnt = 0;
	sim_init();
    while(contextp->time() < 50 ){
	    top->clk ^= 1;
        if(top->clk == 1){
            posedge_cnt++;
            if(posedge_cnt < 4) top->reset = 1;
            else                top->reset = 0;
            if(posedge_cnt >= 5 && posedge_cnt < 10) top->in = 1;
            else                                     top->in = 0;
        }
        top->eval();
	    tfp->dump(contextp->time());
	    contextp->timeInc(1);
    }
	tfp->close();
}
