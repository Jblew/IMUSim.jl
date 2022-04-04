function eulerDerivativeOfMatrix(matrixRowBased::Matrix{Float64}; order=1)
    kernelVec = pascalSubtractionTriangleCoeffsAt(order + 1)
    kernelSize = size(kernelVec)[2]

    derivedM = zeros(size(matrixRowBased))
    rowCount = size(matrixRowBased)[1]
    colCount = size(matrixRowBased)[2]
    for i = 1:rowCount
        kernelView::Metrix{Float64}
        if i < kernelSize
            paddingSize = kernelSize - i
            paddingM = zeros(paddingSize, colCount)
            kernelView = [paddingM; matrixRowBased[i:kernelSize, :]]
        else
            viewStart = i - kernelSize
            viewEnd = i
            kernelView = matrixRowBased[viewStart:viewEnd, :]
        end
        derivedRow = kernelVec * kernelView
        derivedM[i, :] = derivedRow
    end

    return derivedM
end

function pascalSubtractionTriangleCoeffsAt(n::Int)::Vector{Int}
    coeffs::Vector{Int} = zeros(n)
    for i = 0:n-1
        coeffs[i+1] = binomial(n - 1, i) * (i % 2 == 0 ? 1 : -1)
    end
    return coeffs
end