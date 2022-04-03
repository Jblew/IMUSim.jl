module IMUSim
export PositionPath, getPositionXYZAt, getRotationXYZAt

struct PositionPath
    posXYZrotXYZ::Matrix{Float64}
    PositionPath(positionFn::Function, length::Int) = new(genPositionPathMatrix(positionFn, length))
end

function getPositionXYZAt(path::PositionPath, t::Int)::Vector{Float64}
    return path.posXYZrotXYZ[t, 1:3]
end

function getRotationXYZAt(path::PositionPath, t::Int)::Vector{Float64}
    return path.posXYZrotXYZ[t, 4:6]
end

function genPositionPathMatrix(positionFn::Function, length::Int)::Matrix{Float64}
    m = zeros(length, 6)
    for i = 1:length
        m[i, :] = positionFn(i)
    end
    return m
end

end # module
