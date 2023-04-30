`timescale 1ns / 1ps
module blur_tb();

 reg clk, reset, done_in;
 reg [2:0] sel_module;
 reg[7:0] val;
 reg[7:0] red1;
 reg[7:0] red2;
 reg[7:0] red3;
 reg[7:0] red4;
 reg[7:0] red5;
 reg[7:0] red6;
 reg[7:0] red7;
 reg[7:0] red8;
 reg[7:0] red9;
 reg[7:0] red10;
 
 wire done_out;
 wire[7:0] red_o;

blur tb( clk, reset, sel_module,red1,red2,red3,red4,red5,red6,red7,red8,red9, red10,     // input signlas
                     done_in, done_out,       // output signals for tgb2gray
                //     val,                           // brightness values
                     red_o);
                     
                     
`define read_fileName1 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\road_gray.bmp"
`define read_fileName2 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\left.bmp"
`define read_fileName3 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\right.bmp"
`define read_fileName4 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\up.bmp"
`define read_fileName5 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\\\down.bmp"
`define read_fileName6 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\leftup.bmp"
`define read_fileName7 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\leftdown.bmp"
`define read_fileName8 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\rightup.bmp"
`define read_fileName9 "D:\\Lenix\\lane_detection\\Python\\parallel_images\\rightdown.bmp"
`define read_filename10 "D:\\Lenix\\lane_detection\\FPGA\\bmp\\output\\road_sobel.bmp"

 localparam ARRAY_LEN = 1000*1024;
 
 reg[7:0] data1[0: ARRAY_LEN];
 reg[7:0] data2[0: ARRAY_LEN];
 reg[7:0] data3[0: ARRAY_LEN];
 reg[7:0] data4[0: ARRAY_LEN];
 reg[7:0] data5[0: ARRAY_LEN];
 reg[7:0] data6[0: ARRAY_LEN];
 reg[7:0] data7[0: ARRAY_LEN];
 reg[7:0] data8[0: ARRAY_LEN];
 reg[7:0] data9[0: ARRAY_LEN];
 reg[7:0] data10[0:ARRAY_LEN]; 
 
 integer size, start_pos, width, height, bitcount;
 
 
 
 task readBMP;
     integer fileID1, fileID2, fileID3, fileID4, fileID5, fileID6, fileID7, fileID8, fileID9, fileID10;
 //    integer i;
     begin
         fileID1 = $fopen(`read_fileName1, "rb");
         fileID2 = $fopen(`read_fileName2, "rb");
         fileID3 = $fopen(`read_fileName3, "rb");
         fileID4 = $fopen(`read_fileName4, "rb");
         fileID5 = $fopen(`read_fileName5, "rb");
         fileID6 = $fopen(`read_fileName6, "rb");
         fileID7 = $fopen(`read_fileName7, "rb");
         fileID8 = $fopen(`read_fileName8, "rb");
         fileID9 = $fopen(`read_fileName9, "rb");
         fileID10 = $fopen(`read_filename10, "rb");
         $display("%d", fileID1);
         if(fileID1 == 0) begin
             $display("Error: Please check file path");
             $finish;
         end else begin
             $fread(data1, fileID1);
             $fclose(fileID1);
             
             $fread(data2, fileID2);
             $fclose(fileID2);
            
             $fread(data3, fileID3);
             $fclose(fileID3);
                          
             $fread(data4, fileID4);
             $fclose(fileID4);
             
             $fread(data5, fileID5);
             $fclose(fileID5);
             
             $fread(data6, fileID6);
             $fclose(fileID6);
             
             $fread(data7, fileID7);
             $fclose(fileID7);
             
             $fread(data8, fileID8);
             $fclose(fileID8);
                                       
             $fread(data9, fileID9);
             $fclose(fileID9);
             
             $fread(data10, fileID10);
             $fclose(fileID10);
                                                    
                                                    
             size = {data1[5],data1[4],data1[3],data1[2]};
             $display("size - %d", size);
             start_pos = {data1[13],data1[12],data1[11],data1[10]};
             $display("startpos : %d", start_pos);
             width = {data1[21],data1[20],data1[19],data1[18]};
             height = {data1[25],data1[24],data1[23],data1[22]};
             $display("width - %d; height - %d",width, height );
         
             bitcount = {data1[29],data1[28]};
 //            for(i = start_pos; i<size;i = i+1)begin
 //                $display("%h", data[i]);
 //            end
        end
     end
 endtask
 // Image read complete

 

 integer i, j;
 localparam RESULT_ARRAY_LEN = 1000*1024;
 
 reg[7:0] result[0:RESULT_ARRAY_LEN - 1];
 
 
 always @(posedge clk) begin
    if(sel_module == 2'b00)begin
        if(reset) begin
            j <= 8'd0;
        end else begin
            if(done_out) begin
                result[j] <= red_o;
                j <= j+1;
                //$display("%d, %d", gray, result[j]);
            end
        end
    end else begin
        if(reset) begin
            j <= 8'd0;
        end else begin
            if(done_out) begin
                //$display("done_out, %d", done_out);
                //$display("something");
                result[j] <= red_o;
                j <= j+1;
//                $display("j-%d", j);
//                $display("blue-%d;green-%d;red-%d;", result[j],result[j+1],result[j+2]);
            end
        end    
    end
 end
 

 
//Image Write Start
 
 `define write_filename "D:\\Lenix\\lane_detection\\FPGA\\bmp\\output\\road_sobel_binarized.bmp"
 
task writeBMP;
integer fileID, k;
 begin
     fileID = $fopen(`write_filename, "wb");
     
     for(k = 0; k < start_pos; k = k+1)begin
         $fwrite(fileID, "%c", data1[k]);
     end
     
     for(k = start_pos; k<size; k = k+1)begin
         $fwrite(fileID, "%c", result[k - start_pos]);
     end
     
     $fclose(fileID);
     $display("Result.bmp is generated \n");
 end
endtask
 
 //Image Write ends
 
 
 
 
 
// 1 = original 	(2, 2)
// 2 = left         (2, 3)
// 3 = right         (2, 1)
// 4 = up             (1, 2)
// 5 = down         (3, 2)
// 6 = leftup         (1, 3)
// 7 = leftdown     (3, 3)
// 8 = rightup     (1, 1)
// 9 = rightdown     (3, 1)
 
 
// | 8 4 6 |
// | 3 1 2 |
// | 9 5 7 |




always begin
     #5 clk = ~clk;
end

initial begin
    clk = 1;
    reset = 1;
    done_in = 0;
    sel_module = 3'b111;
    val = 50;
    
    red1 = 8'd0;
    
    readBMP;
    
    #10;
    reset = 0;
 
    for(i = start_pos; i < size; i = i+1)begin
        red1 = data1[i];
        red2 = data2[i];        
        red3 = data3[i];
        red4 = data4[i];
        red5 = data5[i];        
        red6 = data6[i];
        red7 = data7[i];
        red8 = data8[i];
        red9 = data9[i];
        red10 = data10[i];
        #10;
        done_in = 1;
    end
    
    #10;
    done_in  = 1'b0;
    
    #10;
    writeBMP;
    
    
    #10;
    $stop;

end

endmodule

