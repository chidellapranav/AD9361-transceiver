`timescale 1ns / 1ps

module packet_scrambler #(
    parameter [6:0] SEED = 7'b1111111
)(
    input  wire       clk,
    input  wire       resetn,

    input  wire [7:0] s_axis_tdata,
    input  wire       s_axis_tvalid,
    input  wire       s_axis_tlast,
    output wire       s_axis_tready,

    output reg  [7:0] m_axis_tdata,
    output wire       m_axis_tvalid,
    output reg        m_axis_tlast,
    input  wire       m_axis_tready
);

    reg [6:0] lfsr;
    reg       out_valid;

    reg [6:0] next_lfsr;
    reg [7:0] scrambled_byte;
    integer bit_index;

    // Output register can accept a new byte if it is empty,
    // or if its current byte will be consumed this cycle.
    wire slot_free;

    assign slot_free =
        !out_valid || m_axis_tready;

    assign s_axis_tready =
        resetn && slot_free;

    assign m_axis_tvalid =
        resetn && out_valid;

    // --------------------------------------------------------
    // Calculate eight successive scrambling bits.
    //
    // For each input bit:
    //   PN output = state[6]
    //   feedback  = state[6] XOR state[3]
    //   next state = {state[5:0], feedback}
    //
    // Input byte is processed bit 0 first.
    // SEED must be nonzero.
    // --------------------------------------------------------
    always @* begin
        next_lfsr      = lfsr;
        scrambled_byte = 8'h00;

        for (bit_index = 0;
             bit_index < 8;
             bit_index = bit_index + 1) begin

            scrambled_byte[bit_index] =
                s_axis_tdata[bit_index] ^ next_lfsr[6];

            next_lfsr = {
                next_lfsr[5:0],
                next_lfsr[6] ^ next_lfsr[3]
            };
        end
    end

    // --------------------------------------------------------
    // Registered output with backpressure support
    // --------------------------------------------------------
    always @(posedge clk) begin
        if (!resetn) begin
            lfsr          <= SEED;
            out_valid     <= 1'b0;
            m_axis_tdata  <= 8'h00;
            m_axis_tlast  <= 1'b0;
        end
        else if (slot_free) begin
            out_valid    <= s_axis_tvalid;
            m_axis_tlast <= 1'b0;

            if (s_axis_tvalid) begin
                m_axis_tdata <= scrambled_byte;
                m_axis_tlast <= s_axis_tlast;

                // The accepted final byte uses the current state.
                // Reset the state for the NEXT packet.
                if (s_axis_tlast)
                    lfsr <= SEED;
                else
                    lfsr <= next_lfsr;
            end
        end

        // If stalled, all output registers and LFSR hold.
    end

endmodule