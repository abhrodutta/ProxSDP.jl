module ProxSDP

    using MathOptInterface, TimerOutputs
    using Arpack
    using Compat
    using Printf

    include("MOI_wrapper.jl")
    include("eigsolver.jl")
    include("convex_sets.jl")
    include("types.jl")
    include("util.jl")
    include("printing.jl")    
    include("scaling.jl")
    include("chambolle_pock.jl")
    include("convergence.jl")
    include("prox_operators.jl")

    MOIU.@model _ProxSDPModelData () (MOI.EqualTo, MOI.GreaterThan, MOI.LessThan) (MOI.Zeros, MOI.Nonnegatives, MOI.Nonpositives, MOI.PositiveSemidefiniteConeTriangle) () (MOI.SingleVariable,) (MOI.ScalarAffineFunction,) (MOI.VectorOfVariables,) (MOI.VectorAffineFunction,)

    Solver(;args...) = MOIU.CachingOptimizer(_ProxSDPModelData{Float64}(), ProxSDP.Optimizer(args))

end