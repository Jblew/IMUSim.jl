module IMUSim

struct PositionPath
    posXYZrotXYZ::Matrix{Float64}
    PositionPath(positionFn::Function, length::Int) = new(zeros(length, 6))
end

function getPositionXYZAt(path::PositionPath, t::Int)::Vector{Float64}
    return [0, 0, 0]
end

function getRotationXYZAt(path::PositionPath, t::Int)::Vector{Float64}
    return [0, 0, 0]
end

export PositionPath, getPositionXYZAt, getRotationXYZAt

end # module
