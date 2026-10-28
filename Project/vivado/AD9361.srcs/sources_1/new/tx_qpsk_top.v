`timescale 1ns / 1ps

module tx_qpsk_top #(
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

    // Packed output: {signed Q[15:0], signed I[15:0]}
    output wire [31:0] m_axis_tdata,
    output wire        m_axis_tvalid,
    output wire        m_axis_tlast,
    input  wire        m_axis_tready
);

    reg active;

    wire accepted_start;

    wire coding_busy;
    wire coding_done;
    wire frame_busy;
    wire frame_done;

    wire [15:0] configured_payload_length;

    wire [1:0] coded_data;
    wire       coded_valid;
    wire       coded_last;
    wire       coded_ready;

    wire [1:0] frame_data;
    wire       frame_valid;
    wire       frame_last;
    wire       frame_ready;

    assign configured_payload_length = PAYLOAD_BYTES;

    assign accepted_start =
        resetn && start && !active;

    assign busy = active;

    // Track completion at the final mapper output,
    // rather than at an earlier stage in the chain.
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

    tx_coded_top #(
        .PAYLOAD_BYTES(PAYLOAD_BYTES)
    ) coding (
        .clk            (clk),
        .resetn         (resetn),
        .start          (accepted_start),

        .busy           (coding_busy),
        .packet_done    (coding_done),

        .m_axis_tdata   (coded_data),
        .m_axis_tvalid  (coded_valid),
        .m_axis_tlast   (coded_last),
        .m_axis_tready  (coded_ready)
    );

    frame_assembler #(
        .MAX_CODED_PAIRS(MAX_CODED_PAIRS)
    ) framing (
        .clk                  (clk),
        .resetn               (resetn),

        .payload_length_bytes (configured_payload_length),

        .s_axis_tdata         (coded_data),
        .s_axis_tvalid        (coded_valid),
        .s_axis_tlast         (coded_last),
        .s_axis_tready        (coded_ready),

        .m_axis_tdata         (frame_data),
        .m_axis_tvalid        (frame_valid),
        .m_axis_tlast         (frame_last),
        .m_axis_tready        (frame_ready),

        .busy                 (frame_busy),
        .packet_done          (frame_done),
        .overflow_error       (overflow_error)
    );

    qpsk_mapper #(
        .AMPLITUDE(AMPLITUDE)
    ) mapper (
        .clk            (clk),
        .resetn         (resetn),

        .s_axis_tdata   (frame_data),
        .s_axis_tvalid  (frame_valid),
        .s_axis_tlast   (frame_last),
        .s_axis_tready  (frame_ready),

        .m_axis_tdata   (m_axis_tdata),
        .m_axis_tvalid  (m_axis_tvalid),
        .m_axis_tlast   (m_axis_tlast),
        .m_axis_tready  (m_axis_tready)
    );

endmodule