function eulerDerivativeOfMatrix(matrixRowBased::Matrix{Float64}; order=1)
    kernelVec = pascalSubtractionTriangleCoeffsAt(order + 1)'
    kernelSize = size(kernelVec)[2]

    derivedM = zeros(size(matrixRowBased))
    rowCount = size(matrixRowBased)[1]
    colCount = size(matrixRowBased)[2]
    for i = 1:rowCount
        viewRangeIndices = (i - kernelSize + 1, i)
        derivedRow = kernelVec * paddedMatrixView(matrixRowBased; indices=viewRangeIndices, columnCount=colCount)
        derivedM[i, :] = derivedRow
    end

    return derivedM
end

function paddedMatrixView(matrixRowBased::Matrix{Float64}; indices::Tuple{Int,Int}, columnCount::Int)::Matrix{Float64}
    (s, e) = indices
    if s <= 0
        paddingSize = -s + 1
        paddingM = zeros(paddingSize, columnCount)
        return [paddingM; matrixRowBased[1:e, :]]
    else
        return matrixRowBased[s:e, :]
    end
end

function pascalSubtractionTriangleCoeffsAt(n::Int)::Vector{Int}
    coeffs::Vector{Int} = zeros(n)
    for i = 0:n-1
        coeffs[i+1] = binomial(n - 1, i) * (i % 2 == 0 ? 1 : -1)
    end
    return reverse(coeffs)
end