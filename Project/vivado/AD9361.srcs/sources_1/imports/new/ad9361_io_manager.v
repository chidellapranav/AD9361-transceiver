`timescale 1ns / 1ps

module ad9361_io_manager (
    // ==========================================
    // Zynq EMIO GPIO Interface - bundled as "GPIO" bus interface
    // ==========================================
    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio_rtl:1.0 GPIO_0 TRI_O" *)
    input  wire [63:0] ps_gpio_o,

    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio_rtl:1.0 GPIO_0 TRI_I" *)
    output wire [63:0] ps_gpio_i,

    (* X_INTERFACE_INFO = "xilinx.com:interface:gpio_rtl:1.0 GPIO_0 TRI_T" *)
    input  wire [63:0] ps_gpio_t,
    // AD9361 Strict Directional Ports (still separate, flat ports)
    (* X_INTERFACE_IGNORE = "true" *) output wire        gpio_resetb,
    (* X_INTERFACE_IGNORE = "true" *) output wire        gpio_sync,
    (* X_INTERFACE_IGNORE = "true" *) output wire        gpio_en_agc,
    (* X_INTERFACE_IGNORE = "true" *) output wire [3:0]  gpio_ctl,
    (* X_INTERFACE_IGNORE = "true" *) input  wire [7:0]  gpio_status,
    (* X_INTERFACE_IGNORE = "true" *) output wire        gpio_clksel,

    // Added ENSM control ports mapped to unused GPIO bits
    (* X_INTERFACE_IGNORE = "true" *) output wire        up_enable,
    (* X_INTERFACE_IGNORE = "true" *) output wire        up_txnrx
);

    // ==========================================
    // 1. OUTPUTS (Zynq driving AD9361)
    // ==========================================
    assign gpio_resetb = ps_gpio_o[47];
    assign gpio_sync   = ps_gpio_o[48];
    assign gpio_en_agc = ps_gpio_o[49];
    assign gpio_ctl    = ps_gpio_o[53:50];
    assign gpio_clksel = ps_gpio_o[54];
    
    assign up_enable   = ps_gpio_o[55];
    assign up_txnrx    = ps_gpio_o[56];

    // ==========================================
    // 2. INPUTS (AD9361 driving Zynq)
    // ==========================================
    assign ps_gpio_i[46:39] = gpio_status;

    // ==========================================
    // 3. HARDWARE READBACK LOOP (CRITICAL)
    // ==========================================
    assign ps_gpio_i[47]    = ps_gpio_o[47];
    assign ps_gpio_i[48]    = ps_gpio_o[48];
    assign ps_gpio_i[49]    = ps_gpio_o[49];
    assign ps_gpio_i[53:50] = ps_gpio_o[53:50];
    assign ps_gpio_i[54]    = ps_gpio_o[54];
    
    assign ps_gpio_i[55]    = ps_gpio_o[55];
    assign ps_gpio_i[56]    = ps_gpio_o[56];

    // ==========================================
    // 4. UNUSED TIE-OFFS
    // ==========================================
    assign ps_gpio_i[38:0]  = 39'd0;
    assign ps_gpio_i[63:57] = 7'd0;

endmodule