`timescale 1ns / 1ps

module tx_coded_top #(
    parameter integer PAYLOAD_BYTES = 16
)(
    input  wire       clk,
    input  wire       resetn,
    input  wire       start,

    output wire       busy,
    output wire       packet_done,

    output wire [1:0] m_axis_tdata,
    output wire       m_axis_tvalid,
    output wire       m_axis_tlast,
    input  wire       m_axis_tready
);

    reg active;

    wire accepted_start;
    wire source_busy;
    wire source_done;
    wire fec_done;

    wire [7:0] crc_data;
    wire       crc_valid;
    wire       crc_last;
    wire       crc_ready;

    wire [7:0] scrambled_data;
    wire       scrambled_valid;
    wire       scrambled_last;
    wire       scrambled_ready;

    assign accepted_start = start && !active && resetn;
    assign busy           = active;
    assign packet_done    = fec_done;

    always @(posedge clk) begin
        if (!resetn)
            active <= 1'b0;
        else if (accepted_start)
            active <= 1'b1;
        else if (fec_done)
            active <= 1'b0;
    end

    tx_payload_crc_top #(
        .PAYLOAD_BYTES(PAYLOAD_BYTES)
    ) payload_crc (
        .clk            (clk),
        .resetn         (resetn),
        .start          (accepted_start),
        .busy           (source_busy),
        .packet_done    (source_done),

        .m_axis_tdata   (crc_data),
        .m_axis_tvalid  (crc_valid),
        .m_axis_tlast   (crc_last),
        .m_axis_tready  (crc_ready)
    );

    packet_scrambler scrambler (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (crc_data),
        .s_axis_tvalid  (crc_valid),
        .s_axis_tlast   (crc_last),
        .s_axis_tready  (crc_ready),

        .m_axis_tdata   (scrambled_data),
        .m_axis_tvalid  (scrambled_valid),
        .m_axis_tlast   (scrambled_last),
        .m_axis_tready  (scrambled_ready)
    );

    conv_encoder fec (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (scrambled_data),
        .s_axis_tvalid  (scrambled_valid),
        .s_axis_tlast   (scrambled_last),
        .s_axis_tready  (scrambled_ready),

        .m_axis_tdata   (m_axis_tdata),
        .m_axis_tvalid  (m_axis_tvalid),
        .m_axis_tlast   (m_axis_tlast),
        .m_axis_tready  (m_axis_tready),

        .packet_done    (fec_done)
    );

endmodule