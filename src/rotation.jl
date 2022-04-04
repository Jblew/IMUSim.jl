function getXYZRotationMatrix(x::AbstractFloat, y::AbstractFloat, z::AbstractFloat)
    sα = sin(x)
    cα = cos(x)
    sβ = sin(y)
    cβ = cos(y)
    sγ = sin(z)
    cγ = cos(z)

    return [
        cβ*cγ sα*sβ*cγ-cα*sγ cα*sβ*cγ+sα*sγ
        cβ*sγ sα*sβ*sγ+cα*cγ cα*sβ*sγ-sα*cγ
        -sβ sα*cβ cα*cβ
    ]
end
getXYZRotationMatrix(v::Vector{T}) where {T<:AbstractFloat} = getXYZRotationMatrix(v[1], v[2], v[3])

function rotateByAngles(dir::Vector{T}, angularPosXYZ::Matrix{T}) where {T<:Float64}
    size(angularPosXYZ)[2] != 3 ? throw(DimensionMismatch("Angles must be a matrix of size (_, 3), $(size(angles)) was given")) : nothing

    x = angularPosXYZ[:, 1]
    y = angularPosXYZ[:, 2]
    z = angularPosXYZ[:, 3]
    sα = sin.(x)
    cα = cos.(x)
    sβ = sin.(y)
    cβ = cos.(y)
    sγ = sin.(z)
    cγ = cos.(z)

    a1 = cβ .* cγ
    b1 = sα .* sβ .* cγ .- cα .* sγ
    c1 = cα .* sβ .* cγ .+ sα .* sγ
    a2 = cβ .* sγ
    b2 = sα .* sβ .* sγ .+ cα .* cγ
    c2 = cα .* sβ .* sγ .- sα .* cγ
    a3 = .-sβ
    b3 = sα .* cβ
    c3 = cα .* cβ
    rotationMatrixLx3x3 = [a1 b1 c1;;; a2 b2 c2;;; a3 b3 c3]

    return vcat([dir' * rotationMatrixLx3x3[i, :, :] for i in 1:size(angularPosXYZ)[1]]...)
end