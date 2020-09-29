using TwiliteTimeline
using Test

# @testset "TwiliteTimeline.jl" begin
#     # Write your tests here.
# end

@testset "collector.jl" begin
    # Write your tests here.
    @testset "Validate Types" begin
        creds = Authentictor("asdf", "asdf", "asdf", "asdf")
        @test isa(creds, Authentictor)
        resource_params = ResourceParams("realDonaldTrump", count=100)
        @test isa(resource_params, ResourceParams)
    end
end
