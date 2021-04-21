function getBarEquations(bf::BarFramework)
    # OUTPUT: should produce the squared edge length equations
    eqnz = [bar_equation(bf, edge) for edge in bf.edges]
    return eqnz
end

function bar_equation(bf::BarFramework, edge::Tuple{Int64, Int64})
    i,j = edge # unpacking
    eqn = -bf.edgelengths[edge] # initialize with negative squared edge length
    eqn += sum( (Variable(:x,i,k) - Variable(:x,j,k))^2 for k in 1:bf.dimension )
    return eqn
end

function getSystem(bf::BarFramework)
    # this only works for bf.dimension ∈ {1,2,3}
    n = length(bf.vertices)
    movingframevarz = [Variable(:x,2,1),
                        Variable(:x,3,1), Variable(:x,3,2)]
    movingframevarz = vcat(movingframevarz,
        [Variable(:x,i,k) for i in 4:n for k in 1:bf.dimension])

    subz1 = Dict([Variable(:x,1,k) => 0 for k in 1:bf.dimension]...)
    subz2 = Dict([Variable(:x,2,k) => 0 for k in 2:bf.dimension]...)
    subz3 = Dict([Variable(:x,3,k) => 0 for k in 3:bf.dimension]...)
    subz = merge(subz1, subz2, subz3)
    eqnz = getBarEquations(bf)
    movingeqnz = subs(eqnz, subz)

    F = System(movingeqnz; variables=movingframevarz)
    return F
end

function realizations(bf::BarFramework)
    HCSystem = getSystem(bf)
    HCResult = solve(HCSystem)
    realsols = real_solutions(HCResult)
    result = RealizationsResult(HCSystem,HCResult,realsols)
    return result
end
