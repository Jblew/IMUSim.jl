function eulerDerivative(matrixRowBased::Matrix{Float64}; order=1)
    kernel = getDerivativeKernel(; order, kernelLength=6)
    # Can we apply this in loop that will be multithreaded?
    return m
end

function getDerivativeKernel(; order::Int, kernelLength::Int)
    coeffs = pascalSubtractionTriangleCoeffsAt(order + 1)
    kernelLines = [fill(coeffs[i], kernelLength)' for i in 1:length(coeffs)]
    return vcat(kernelLines...)
end

function pascalSubtractionTriangleCoeffsAt(n::Int)::Vector{Int}
    coeffs::Vector{Int} = zeros(n)
    for i = 0:n-1
        coeffs[i+1] = binomial(n - 1, i) * (i % 2 == 0 ? 1 : -1)
    end
    return coeffs
end