using Test
include("IMUSim.jl")

@testset "uniform rectilinear motion" begin
    rectilinear(t) = [2 * t, 0, 0, 0, 0, 0] # 2m/s
    positionPath = IMUSim.PositionPath(rectilinear, 100)
    @test IMUSim.getPositionXYZAt(positionPath, 1) == [2, 0, 0]
    @test IMUSim.getRotationXYZAt(positionPath, 1) == [0, 0, 0]
    @test IMUSim.getPositionXYZAt(positionPath, 5) == [2 * 5, 0, 0]
    @test IMUSim.getRotationXYZAt(positionPath, 5) == [0, 0, 0]
end