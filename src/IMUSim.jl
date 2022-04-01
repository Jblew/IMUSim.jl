module IMUSim
using GLMakie
include("animate.jl")

function makeAndSaveAnimation()
    save("animation.jl", makeAnimation())
end

function run()
    makeAndSaveAnimationCG()
end

export makeAnimation, makeAndSaveAnimation, run
end # module
