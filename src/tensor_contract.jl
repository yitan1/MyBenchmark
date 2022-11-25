function tensor_test()
    mul1(A,B,C) = @tensor result4[i,j] := A[i,a,b]*B[b,a,c]*C[c,j]

    function testm(A,B,C)
        Tullio.@tensor W[i,j] := A[i,a,b]*B[b,a,j]
        Tullio.@tensor W1[i,j] := W[i,a]*C[a,j]
    end

    function test_matrix(A,B,C)
        A = permutedims(A, (1,3,2))
        A = reshape(A, (size(A,1), size(A,2)*size(A,3)))
        B = reshape(B, (size(B,1)*size(B,2), size(B,3)))
        W = A*B
        W = W*C
    end

    A = rand(50,30,200)
    B = rand(200,30,10)
    C = rand(10,40)
    # testm(A,B,C) ≈ test_matrix(A,B,C)

    @btime mul1($A,$B,$C); 
    @btime testm($A,$B,$C); 
    @btime test_matrix($A,$B,$C); 

    # test1(A,B) = @tensor W[:] := A[-1,1]*B[1,-2]
    # test2(A,B) = @tullio W[i,j] := A[i,a]*B[a,j]
    # test3(A,B) = Tullio.@tensor  W[i,j] := A[i,a]*B[a,j]
end
