module age_matrix #(
    parameter WIDTH = 4
)(
    input               clk,
    input               rst_n,
    input               alloc_en,
    input  [WIDTH-1:0]  v_alloc,
    output [WIDTH-1:0]  vv_matrix [WIDTH-1:0]
);

logic [WIDTH-1:0] vv_matrix_tmp [WIDTH-1:0];
logic [WIDTH-1:0] vv_set        [WIDTH-1:0];
logic [WIDTH-1:0] vv_unset      [WIDTH-1:0];

genvar i,j;

generate
    for(i=0;i<WIDTH;i=i+1) begin: row
        for(j=0;j<WIDTH;j=j+1) begin: column 
            if(i==j) begin 
                assign vv_matrix_tmp[i][j]  = 1'b1;
            end else if(i<j) begin 
                assign vv_set[i][j]         = v_alloc[i] && alloc_en;
                assign vv_unset[i][j]       = v_alloc[j] && alloc_en;
                assign vv_matrix_tmp[i][j]  = vv_set[i][j] ? 1'b1 : (vv_unset[i][j] ? 1'b0 : vv_matrix_tmp[i][j]);
            end else begin 
                assign vv_matrix_tmp[i][j]  = ~vv_matrix_tmp[j][i];
            end 
        end
    end 
endgenerate

assign vv_matrix = vv_matrix_tmp;


endmodule