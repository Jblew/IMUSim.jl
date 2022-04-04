using Test

@testset "Tests" begin
    include("IMUSim.test.jl")
    include("euler.test.jl")
    include("movement.test.jl")
end

nothing