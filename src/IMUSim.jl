module IMUSim

function generatePositionPath(positionFn::Function{Float64}, range::Tuple{Float64,Float64,Float64})
    (rangeFrom, rangePrecision, rangeTo) = range
    movementPieces = floor((rangeTo - rangeFrom) / rangePrecision)
    return zeros(movementPieces, 6)
end

function getPositionXYZAt(point::Float64)
    return [0, 0, 0]
end

function getRotationXYZAt(point::Float64)
    return [0, 0, 0]
end

export generatePositionPath, getPositionXYZAt, getRotationXYZAt

end # module
