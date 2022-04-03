using Test
include("IMUSim.jl")

@testset "PositionPath constructor" begin
    rectilinear(t) = [2 * t, 0, 0, 0, 0, 0] # 2m/s
    positionPath = IMUSim.PositionPath(rectilinear, 100)
    @test positionPath.posXYZrotXYZ[1, :] == [2, 0, 0, 0, 0, 0]
    @test positionPath.posXYZrotXYZ[2, :] == [4, 0, 0, 0, 0, 0]
    @test positionPath.posXYZrotXYZ[3, :] == [6, 0, 0, 0, 0, 0]
end