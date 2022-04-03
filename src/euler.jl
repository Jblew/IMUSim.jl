function euler2nOrderDerivative(matrixRowBased::Matrix{Float64}; order=1)
    2nOrderDerivativeKernel = [
        fill(1, 6)'
        fill(-2, 6)'
        fill(1, 6)'
    ]
    # Can we apply this in loop that will be multithreaded?
    return m
end