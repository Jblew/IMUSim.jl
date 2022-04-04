using Test
include("IMUSim.jl")

~(a::Vector, b::Vector) = isapprox.(a, b; atol=0.001) == fill(true, size(a))

@testset "uniform rectilinear motion" begin
    rectilinear(t) = [2 * t, 0, 0, 0, 0, 0] # 2m/s
    positionPath = IMUSim.PositionPath(rectilinear, 100)
    @test IMUSim.getPositionXYZAt(positionPath, 1) == [2, 0, 0]
    @test IMUSim.getRotationXYZAt(positionPath, 1) == [0, 0, 0]
    @test IMUSim.getPositionXYZAt(positionPath, 5) == [2 * 5, 0, 0]
    @test IMUSim.getRotationXYZAt(positionPath, 5) == [0, 0, 0]
end

@testset "uniformly accelerated motion without gravity" begin
    accelerated(t) = [0, 0, 2 * t^2, 0, t^2, 0] # 2m/s^2
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100); gravityEnabled=false)
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [0, 0, 4]
    @test IMUSim.getAngularRateXYZAt(mcuReadingsPath, 10) == [0, 2, 0]
end

@testset "no motion with gravity" begin
    accelerated(t) = [0, 0, 0, 0, 0, 0]
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100))
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [0, 0, -1]
    @test IMUSim.getAngularRateXYZAt(mcuReadingsPath, 10) == [0, 0, 0]
end

@testset "uniformly accelerated motion with gravity" begin
    accelerated(t) = [0, 0, 2 * t^2, 0, 0, 0]
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100))
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [0, 0, 4 - 1]
    @test IMUSim.getAngularRateXYZAt(mcuReadingsPath, 10) == [0, 0, 0]
end

@testset "uniformly accelerated motion with gravity with rotation perpendicular to gravity" begin
    accelerated(t) = [0, 2 * t^2, 0, 0, 0, 1 / 2 * pi * t]
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100))
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [0, 4, -1]
    @test IMUSim.getAngularRateXYZAt(mcuReadingsPath, 10) == [0, 0, 0]
end

@testset "uniformly accelerated motion with gravity with 90deg tilt along x axis" begin
    accelerated(t) = [0, 2 * t^2, 0, pi / 2, 0, 0]
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100))
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [0, 4 + 1, 0]
    @test IMUSim.getAngularRateXYZAt(mcuReadingsPath, 10) == [0, 0, 0]
end

@testset "uniformly accelerated motion with gravity with -90deg tilt along x axis" begin
    accelerated(t) = [0, 2 * t^2, 0, -pi / 2, 0, 0]
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100))
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [0, 4 - 1, 0]
    @test IMUSim.getAngularRateXYZAt(mcuReadingsPath, 10) == [0, 0, 0]
end

@testset "uniformly accelerated motion with gravity with -45deg tilt along x axis" begin
    accelerated(t) = [2 * t^2, 0, 0, -pi / 4, 0, 0]
    mcuReadingsPath = IMUSim.MCUPath(IMUSim.PositionPath(accelerated, 100))
    @test IMUSim.getAccelerationXYZAt(mcuReadingsPath, 10) ~ [4.0, -1 / sqrt(2), -1 / sqrt(2)]
end