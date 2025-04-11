using TyPlot
using TyMath

c = 10
a1 = 0.5
a2 = 0.25
b = 0.2
p = -a1 * b * c
q = -a2 * b * (1 -a1) * b * c
x0 = 50

A = zeros(49, 49)
for i in 1 : 49
    if i <=48
        A[i, i + 1] = 1
    end
    if i >=2
        A[i, i - 1] = q
    end
    A[i, i] = p
end

b = zeros(49)
b = reshape(b, : , 1)
b[1] = -q * x0
b[49] = 600

#L, U = lu(A)
#追赶法
l = zeros(49)
u = zeros(49)
u[1] = b[1]
for i in 2 : 49
    l[i] = A[i, i - 1]
    u[i] = b[i] - l[i] * A[i - 1, i]
end

L = diagm(ones(49))
U = diagm(u)
for i in 1 : 49
    if i >= 2
        L[i, i - 1] = l[i]
    end
    if i <=48
        U[i, i + 1] = A[i, i + 1]
    end
end

y = L \ b
x = U \ y
println(x)
