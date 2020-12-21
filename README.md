# Matrix_Multiplier

A matrix multiplier is designed, where the output C (4x3) is the product of the 2 input matrices A (4x5) and B (5x3). The matrix multiplication is finely pipelined so that in every cycle, the product aij.bjk is produced and added to the partial product cik in location P(i,k). A complete cik is generated in every 5 clock cycles. Assume that the aij, bjk and cik terms are all 32 bit wide integers.

