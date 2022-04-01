using ConstructiveGeometry
using GLMakie

function makeAndSaveAnimationCG()
    u = union(
        [0, 0, 0] + color("cyan") * cube(20),
        [50, 0, 0] + color("green") * cube(20)
    )
    save("test.png", plot(u))
end