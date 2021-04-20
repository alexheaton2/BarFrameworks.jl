struct BarFramework
    vertices::Vector{Int64},
    edges::Vector{Tuple{Int64,Int64}},
    edgelengths::Dict{Tuple{Int64,Int64}, Number}
    dimension::Int64

    function BarFramework(vertices, edges, edgelengths, dimension)
        new(vertices, edges, edgelengths, dimension)
    end
end
