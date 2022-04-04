module IMUSim
export PositionPath, MCUPath, getPositionXYZAt, getRotationXYZAt, getAccelerationXYZAt, getAngularRateXYZAt
include("euler.jl")
include("rotation.jl")

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

struct MCUPath
    accXYZgyrXYZ::Matrix{Float64}
    MCUPath(positionPath::PositionPath; gravityEnabled=true) = new(genMXUReadingsPath(positionPath; gravityEnabled))
end

function getAccelerationXYZAt(path::MCUPath, t::Int)::Vector{Float64}
    return path.accXYZgyrXYZ[t, 1:3]
end

function getAngularRateXYZAt(path::MCUPath, t::Int)::Vector{Float64}
    return path.accXYZgyrXYZ[t, 4:6]
end

function genMXUReadingsPath(positionPath::PositionPath; gravityEnabled::Bool)::Matrix{Float64}
    accelPath = eulerDerivativeOfMatrix(positionPath.posXYZrotXYZ; order=2)
    if gravityEnabled
        baseGravityAccel = [0.0, 0.0, -1.0]
        gravityAccel = rotateByAngles(baseGravityAccel, positionPath.posXYZrotXYZ[:, 4:6])
        nrows = size(gravityAccel)[1]
        return accelPath .+ [gravityAccel zeros(nrows, 3)]
    else
        return accelPath
    end
end

function genPositionPathMatrix(positionFn::Function, length::Int)::Matrix{Float64}
    m = zeros(length, 6)
    for i = 1:length
        m[i, :] = positionFn(i)
    end
    return m
end

end # module
