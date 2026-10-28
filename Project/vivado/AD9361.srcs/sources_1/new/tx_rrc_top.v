`timescale 1ns / 1ps

module tx_rrc_top #(
    parameter integer PAYLOAD_BYTES   = 16,
    parameter integer MAX_CODED_PAIRS = 2048,
    parameter integer AMPLITUDE       = 8192
)(
    input  wire        clk,
    input  wire        resetn,
    input  wire        start,

    output wire        busy,
    output reg         packet_done,
    output wire        overflow_error,

    // Packed sample output: {signed Q, signed I}.
    output wire [31:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    output wire        m_axis_tlast,
    input  wire        m_axis_tready
);

    reg active;

    wire accepted_start;
    wire symbol_busy;
    wire symbol_done;
    wire rrc_busy;
    wire rrc_done;

    wire [31:0] symbol_data;
    wire        symbol_valid;
    wire        symbol_last;
    wire        symbol_ready;

    assign accepted_start =
        resetn && start && !active;

    assign busy = active;

    always @(posedge clk) begin
        if (!resetn) begin
            active      <= 1'b0;
            packet_done <= 1'b0;
        end
        else begin
            packet_done <= 1'b0;

            if (accepted_start)
                active <= 1'b1;

            if (m_axis_tvalid &&
                m_axis_tready &&
                m_axis_tlast) begin

                active      <= 1'b0;
                packet_done <= 1'b1;
            end
        end
    end

    tx_qpsk_top #(
        .PAYLOAD_BYTES  (PAYLOAD_BYTES),
        .MAX_CODED_PAIRS(MAX_CODED_PAIRS),
        .AMPLITUDE     (AMPLITUDE)
    ) symbol_source (
        .clk            (clk),
        .resetn         (resetn),
        .start          (accepted_start),

        .busy           (symbol_busy),
        .packet_done    (symbol_done),
        .overflow_error (overflow_error),

        .m_axis_tdata   (symbol_data),
        .m_axis_tvalid  (symbol_valid),
        .m_axis_tlast   (symbol_last),
        .m_axis_tready  (symbol_ready)
    );

    rrc_interpolator shaping (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (symbol_data),
        .s_axis_tvalid  (symbol_valid),
        .s_axis_tlast   (symbol_last),
        .s_axis_tready  (symbol_ready),

        .m_axis_tdata   (m_axis_tdata),
        .m_axis_tvalid  (m_axis_tvalid),
        .m_axis_tlast   (m_axis_tlast),
        .m_axis_tready  (m_axis_tready),

        .busy           (rrc_busy),
        .packet_done    (rrc_done)
    );

endmodule