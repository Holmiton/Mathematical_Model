using TyMath
using TyPlot

A = zeros(5, 5)
for i in 1 : 5
    A[i, i] = -1
end

A[1, 3] = 5
A[1, 4] = 3
A[2, 1] = 0.4
A[5, 4] = 0.4
A[3, 2] = 0.6
A[4, 3] = 0.6
b = [500, 400, 200, 100, 100]
b = reshape(b, :, 1)
x = A \ b
println(x)

b = [500, 500, 500, 500, 500]
b = reshape(b, :, 1)
x = A \ b
println(x)
println("增加xk，发现x5算出来是负数")
A[5, 4] = 1
x = A \ b
println(x)
println("s4改成1，使得x的分量都为正")