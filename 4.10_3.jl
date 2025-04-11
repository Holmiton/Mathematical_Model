using TyMath
using TyPlot

#Jacobi
function Jacobi(xk, B1, f)
    xkp1 = B1 * xk + f
end

function JacIter(A, x0, b)
    D = diagm(diag(A))
    U = triu(A, 1)
    L = tril(A, -1)
    B1 = D\(L + U)
    f= D\b;
    xk = Jacobi(x0, B1, f)
    xkp1 = Jacobi(xk, B1, f)
    ctr = 2
    while xk != xkp1
        xk = Jacobi(xkp1, B1, f)
        xkp1 = Jacobi(xk, B1, f)
        ctr = ctr + 2
    end
    println("Jacobi")
    println("b: ", b)
    println("x0: ", x0)
    println("iteration times is ", ctr)
    println(xk)
    println(xkp1)
end


#GaussSeideil
function GaussSeideil(xk, B2, f2)
    xkp1 = B2 * xk + f2
end

function GauSedIter(A, x0, b)
    D = diagm(diag(A))
    U = triu(A, 1)
    L = tril(A, -1)
    B2 = (D - L) \ U
    f2 = (D - L) \ b
    xk = GaussSeideil(x0, B2, f2)
    xkp1 = GaussSeideil(xk, B2, f2)
    ctr = 2
    while xk != xkp1
        xk = GaussSeideil(xkp1, B2, f2)
        xkp1 = GaussSeideil(xk, B2, f2)
        ctr = ctr + 2
    end
    println("GaussSeideil")
    println("b: ", b)
    println("x0: ", x0)  
    println("iter times is ", ctr)
    println(xk)
    println(xkp1)
end

A = zeros(20, 20)
for i in 1 : 20
    A[i, i] = 3
    if(i <= 18)
        A[i, i + 2] = -1/4
    end
    if(i <= 19)
        A[i, i + 1] = -1/2
    end
    if(i >= 2)
        A[i, i-1] = -1/2
    end
    if(i >= 3)
        A[i, i-2] = -1/4
    end
end

println("(1)")
global x0 = reshape(zeros(20), : , 1)
global b = reshape(ones(20), : , 1)
JacIter(A, x0, b)
GauSedIter(A, x0, b)
x0 = 2 * x0
JacIter(A, x0, b)
GauSedIter(A, x0, b)
global x0 = reshape(ones(20), : , 1)
global b = reshape(zeros(20), : , 1)
JacIter(A, x0, b)
GauSedIter(A, x0, b)


println("(2)")
println("成倍增加主对角线元素")
for i in 1 : 20
    A[i, i] = 2 * A[i, i]
end

b = reshape(ones(20), : , 1)
x0 = reshape(zeros(20), : , 1)
JacIter(A, x0, b)
println("再次成倍增加主对角线元素")
for i in 1 : 20
    A[i, i] = 2 * A[i, i]
end
JacIter(A, x0, b)
println("发现成倍增加主对角线元素会使得迭代次数减少，收敛更快")
