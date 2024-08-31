`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.08.2024 00:17:51
// Design Name: Rohit Vijay Gupta
// Module Name: aes_uart
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

module aes_uart(
    input clk,
    input reset,
    input en_tx,
    input en_rx,
    input [127:0] data_in,
    input [127:0] key,
    output u_tx_done,
    output u_rx_done,
    output [127:0] data_out
);

    wire uart_tx;
    wire [127:0] encrypt_data, des_out;
    wire [127:0] uart_out;

    // AES encryption module
    AES_encryption_top aes2 (
        .hex_input(data_in),
        .key(key),
        .encrypt_data(encrypt_data)
    );

    // UART module
    uart u1 (
        .clk(clk),
        .reset(reset),
        .en_tx(en_tx),
        .en_rx(en_rx),
        .data_in(encrypt_data),
        .u_tx_done(u_tx_done),
        .u_rx_done(u_rx_done),
        .data_out(uart_out)
    );

    // AES decryption module
    AES_decryption_top d1 (
        .encrypt_data(uart_out),
        .key(key),
        .decrypt_data(des_out)
    );

    assign data_out = des_out;

endmodule

