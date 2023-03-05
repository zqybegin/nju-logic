include $(NVBOARD_HOME)/scripts/nvboard.mk

MODULE = mux41
BUILD  = ./build/$(MODULE)_dir

MODULE_DIR = $(BUILD_DIR)/V$(MODULE)
BUILD_DIR = $(abspath $(BUILD))
VRSC_DIR = $(abspath ./vsrc/$(MODULE).v)
CRSC_DIR = $(abspath ./csrc/tb_$(MODULE).cpp)
MUX_DIR = $(abspath ./vsrc/MuxKey.v)
MUXI_DIR = $(abspath ./vsrc/MuxKeyInternal.v)

.PHONY:sim wave nvboard

nvboard:$(VRSC_DIR) $(CRSC_DIR) $(MUX_DIR) $(MUXI_DIR) $(NVBOARD_ARCHIVE)
	rm -rf $(BUILD_DIR)
	verilator --Wall -cc --build --exe\
	 $^ \
	 --top-module mux41\
	 -LDFLAGS -lSDL2 -LDFLAGS -lSDL2_image\
	 -CFLAGS -I/home/zqybegin/Workstation/ysyx-workbench/nvboard/include\
	 --Mdir $(BUILD_DIR) -o $(MODULE_DIR)
	$(BUILD_DIR)/V$(MODULE)

sim:$(MODULE_DIR)
	$(MODULE_DIR)
	mv waveform.vcd $(BUILD_DIR)/waveform.vcd

wave:$(BUILD_DIR)/waveform.vcd
	gtkwave $^

$(MODULE_DIR):$(VRSC_DIR) $(CRSC_DIR)
	verilator --trace -cc --build --exe $^ --Mdir $(BUILD_DIR) -o $(MODULE_DIR)
