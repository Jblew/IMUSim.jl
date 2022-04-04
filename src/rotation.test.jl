using Test
include("rotation.jl")

@testset "No rotation gives unitary matrix" begin
    rm = getXYZRotationMatrix(0.0, 0.0, 0.0)
    @test rm == [1 0 0; 0 1 0; 0 0 1]
end

@testset "360 rotation gives unitary matrix" begin
    rm = getXYZRotationMatrix(2 * pi, 2 * pi, 2 * pi)
    @test isapprox.(rm, [1 0 0; 0 1 0; 0 0 1]; atol=0.001) == fill(true, (3, 3))
end
