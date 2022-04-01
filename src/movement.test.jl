using Test

@testset "uniform rectilinear motion" begin
    rectilinear(t) = [2 * t, 0, 0, 0, 0, 0] # 2m/s
    positionPath = generatePositionPath(position)
    @test getPositionXYZAt(positionPath, 0) == [0, 0, 0]
    @test getRotationXYZAt(positionPath, 0) == [0, 0, 0]
    @test getPositionXYZAt(positionPath, 5) == [2 * 5, 0, 0]
    @test getRotationXYZAt(positionPath, 5) == [0, 0, 0]
end