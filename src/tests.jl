include("BarFrameworks.jl")

V = [1,2,3,4]
E = [(1,2), (2,3), (3,4), (1,4), (1,3)]
edgelengths = Dict((1,2) => 1,
                (2,3) => 1.0,
                (3,4) => 1.0 + 0.0im,
                (1,4) => 1,
                (1,3) => sqrt(2) )
bf = BarFrameworks.BarFramework(V,E,edgelengths,2)
eqnz = BarFrameworks.getBarEquations(bf)


# F = BarFrameworks.getSystem(bf)
# typeof(F)
#
# using HomotopyContinuation
# result = solve(F)
# typeof(result)
# realsols = real_solutions(result)

realizationsresult = BarFrameworks.realizations(bf)

realsol = realizationsresult.realsolutions[1]

mat = BarFrameworks.tomatrix(bf, realsol)

mats = [BarFrameworks.tomatrix(bf, realsol) for realsol in realizationsresult.realsolutions]

import LinearAlgebra
LinearAlgebra.norm(mat[3,:])

minimum(mat[i,1] for i in 1:4)
maximum(mat[i,1] for i in 1:4)

minimum(minimum(mat[i,1] for i in 1:4) for mat in mats)
maximum(maximum(mat[i,1] for i in 1:4) for mat in mats)
