`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2024 00:33:44
// Design Name: Rohit Vijay Gupta
// Module Name: tb_aes_uart
// Project Name: AES-Based Encryption and Decryption in UART Protocols
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_aes_uart;
    reg clk_tb;
    reg reset_tb;
    reg en_tx_tb;
    reg en_rx_tb;
    reg [127:0] data_in_tb;
    reg [127:0] key_tb;
    wire u_tx_done_tb;
    wire u_rx_done_tb;
    wire [127:0] data_out_tb;

    aes_uart uut (
        .clk(clk_tb),
        .reset(reset_tb),
        .en_tx(en_tx_tb),
        .en_rx(en_rx_tb),
        .data_in(data_in_tb),
        .key(key_tb),
        .u_tx_done(u_tx_done_tb),
        .u_rx_done(u_rx_done_tb),
        .data_out(data_out_tb)
    );

    initial begin
        clk_tb = 0;
        forever #5 clk_tb = ~clk_tb; 
    end


    task perform_tx_rx;
        input enable;
        begin
            if(enable)
               begin
                    reset_tb = 1;
                    #150 reset_tb = 0;
        
                    data_in_tb = {$random ,$random , $random , $random} ;
                    key_tb =  {$random ,$random , $random , $random};
                    en_tx_tb = 1;
                    en_rx_tb = 1;
        
                    #2000; 
        
                    if (data_out_tb == data_in_tb) begin
                        $display("Data transmission and reception successful! Sent: %h, Received: %h", data_in_tb, data_out_tb);
                    end else begin
                        $display("Data mismatch! Sent: %h, Received: %h", data_in_tb, data_out_tb);
                        end
                    en_tx_tb = 0;
                    en_rx_tb = 0;
              end
        end
    endtask

    initial begin
        reset_tb = 1;
        en_tx_tb = 0;
        en_rx_tb = 0;
        data_in_tb = 128'h0;
        key_tb = 128'h0;

        #20 reset_tb = 0;

        // Test Case 1
        #10 perform_tx_rx(1);

        // Test Case 2
        #150 perform_tx_rx(1);

        // Test Case 3
        #150 perform_tx_rx(1);
        
        // Test Case 4
        #150 perform_tx_rx(1);
         
         // Test Case 5
        #150 perform_tx_rx(1);

        $finish;
    end
   
endmodule

