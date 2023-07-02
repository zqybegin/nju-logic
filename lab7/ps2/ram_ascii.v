module ram_ascii(
    input  [7:0] key,
    output [7:0] ascii
);
    reg [7:0] ram [255:0];
    initial begin
        $readmemh("lab7/ps2/keybind.txt", ram, 0, 255);
    end

    assign ascii = ram[key];

endmodule

