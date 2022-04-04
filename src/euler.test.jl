using Test
include("euler.jl")

@testset "1st order derivative" begin
    matrixIn::Matrix{Float64} = hcat([[0, 2, 2 * x] for x in 1:100]...)'
    derived = eulerDerivativeOfMatrix(matrixIn; order=1)
    @test derived[30, :] == [0, 0, 2]
end

@testset "2nd order derivative" begin
    matrixIn::Matrix{Float64} = hcat([[0, 2, 2 * x, x^2, 2 * x^2] for x in 1:100]...)'
    derived = eulerDerivativeOfMatrix(matrixIn; order=2)
    @test derived[50, :] == [0, 0, 0, 2, 4]
end

@testset "3rd order derivative" begin
    matrixIn::Matrix{Float64} = hcat([[0, 2, x^2, x^3, 3 * x^3] for x in 1:100]...)'
    derived = eulerDerivativeOfMatrix(matrixIn; order=3)
    @test derived[50, :] == [0, 0, 0, 6, 18]
end

@testset "4th order derivative" begin
    matrixIn::Matrix{Float64} = hcat([[0, 2, x^2, x^3, x^4, 4 * x^4] for x in 1:100]...)'
    derived = eulerDerivativeOfMatrix(matrixIn; order=4)
    @test derived[50, :] == [0, 0, 0, 0, 24, 96]
end