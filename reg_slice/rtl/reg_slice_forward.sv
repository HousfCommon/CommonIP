module reg_slice_forward #(
    parameter PLD_WIDTH = 32
)(
    input                       clk,
    input                       rst_n,

    input                       s_vld,
    output                      s_rdy,
    input   [PLD_WIDTH-1:0]     s_pld,

    output                      m_vld,
    input                       m_rdy,
    output  [PLD_WIDTH-1:0]     m_pld

);

logic                   vld_r;
logic [PLD_WIDTH-1:0]   pld_r;

assign s_rdy = !m_vld || m_rdy;
assign m_vld = vld_r;
assign m_pld = pld_r;

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) vld_r <= 1'b0;
    else if(s_vld&&s_rdy) vld_r <= 1'b1;
    else if(m_rdy) vld_r <= 1'b0;
end 

always @(posedge clk or negedge rst_n) begin 
    if(~rst_n) pld_r <= {PLD_WIDTH{1'b0}};
    else if(s_vld&&s_rdy) pld_r <= s_pld;
end 

endmodule   