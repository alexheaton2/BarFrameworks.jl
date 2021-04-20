function getBarEquations(bf::BarFramework)
    # OUTPUT: should produce the squared edge length equations
    # xvarz = [HomotopyContinuation.Variable(:x, i) for i in bf.vertices]
    eqnz = [bar_equation(bf, edge) for edge in bf.edges]
    return eqnz
end

function bar_equation(bf::BarFramework, edge::Tuple{Int64, Int64})
    i,j = edge # unpacking
    eqn = -bf.edgelengths[edge] # initialize with negative squared edge length
    for k in 1:bf.dimension
        eqn += (HomotopyContinuation.Variable(:x,i,k) - HomotopyContinuation.Variable(:x,j,k))^2
    end
    return eqn
end
