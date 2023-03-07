include $(NVBOARD_HOME)/scripts/nvboard.mk
LAB    = lab2
MODULE = decode38

RSC_DIR   = $(shell find $(abspath ./$(LAB)/$(MODULE)) -name "*.v" -or -name "*.cpp")
BUILD_DIR = $(abspath ./$(LAB)/$(MODULE)_dir)
EXE_DIR   = $(abspath ./$(LAB)/$(MODULE)_dir/V$(MODULE))

.PHONY:sim clean nvboard

sim:$(EXE_DIR)
	$(EXE_DIR)
	mv ./dump.vcd $(BUILD_DIR)/dump.vcd
	gtkwave $(BUILD_DIR)/dump.vcd

clean:
	rm -rf $(BUILD_DIR)

$(EXE_DIR):$(RSC_DIR)
	verilator --trace -cc --build --exe $^ --Mdir $(BUILD_DIR) -o $(EXE_DIR)

nvboard:$(RSC_DIR) $(NVBOARD_ARCHIVE)
	rm -rf $(BUILD_DIR)
	verilator --Wall -cc --build --exe\
	 $^ \
	 --top-module $(MODULE)\
	 -LDFLAGS -lSDL2 -LDFLAGS -lSDL2_image\
	 -CFLAGS -I/home/zqybegin/Workstation/ysyx-workbench/nvboard/include\
	 --Mdir $(BUILD_DIR) -o $(EXE_DIR)
	$(EXE_DIR)

echo:
	@echo $(RSC_DIR)
	@echo $(BUILD_DIR)
	@echo $(EXE_DIR)
	@echo $(MODULE)
	@echo $(LAB)
