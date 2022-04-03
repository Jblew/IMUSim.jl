using Test

@testset "Tests" begin
    include("IMUSim.test.jl")
    include("movement.test.jl")
end

nothing