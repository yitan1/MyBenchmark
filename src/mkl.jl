using LinearAlgebra, TensorOperations, BenchmarkTools, Tullio, OMEinsum

function mkl_test()
    A = rand(10,200,30)
    B = rand(200,30,10)
    C = rand(10,40)

    # D = rand(1000,1000)
    # F = rand(1000,1000);
    mul1(A,B,C) = @tensor result4[i,j] := A[i,a,b]*B[a,b,c]*C[c,j];
    mul2(A,B,C) = @tullio result4[i,j] := A[i,a,b]*B[a,b,c]*C[c,j];
    mul3(A,B,C) = @ein result4[i,j] := A[i,a,b]*B[a,b,c]*C[c,j];
    mul4(A,B,C) = Tullio.@tensor result4[i,j] := A[i,a,b]*B[a,b,c]*C[c,j];

    # @btime result1 = D*F;
    # @btime @tensor result2[:] := D[-1,1]*F[1,-2]
    @btime mul1($A,$B,$C); 
    @btime mul2($A,$B,$C);
    @btime mul3($A,$B,$C);
    @btime mul4($A,$B,$C);
    BLAS.get_config()
    
end