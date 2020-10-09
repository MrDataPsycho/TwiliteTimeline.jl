using TwiliteTimeline
using Test

# @testset "TwiliteTimeline.jl" begin
#     # Write your tests here.
# end

@testset "collector.jl" begin
    @testset "Validate Types" begin
        err = try ResourceParams("realDonaldTrump", count=-1) catch ex; ex; end
        @test err isa Exception
        err = try ResourceParams("realDonaldTrump", count=0) catch ex; ex; end
        @test err isa Exception
        test_param = ResourceParams("realDonaldTrump", trim_user=5)
        @test test_param isa ResourceParams
    end

    @testset "Test for check_boolean_values" begin
        test_bool = TwiliteTimeline.check_boolean_values("trim_user", 1)
        @test test_bool == nothing
        err = try TwiliteTimeline.check_boolean_values("trim_user", 5) catch ex; ex; end
        @test err isa Exception
    end

    @testset "Test for params_to_dict" begin
        params = ResourceParams("realDonaldTrump", trim_user=5)
        err = try TwiliteTimeline.params_to_dict(params) catch ex; ex; end
        @test err isa Exception
        expected = Dict("include_rts" => 1,"count" => 100,"trim_user" => 0,"screen_name" => "realDonaldTrump","exclude_replies" => 1)
        params = ResourceParams("realDonaldTrump", count=100)
        params_dict = TwiliteTimeline.params_to_dict(creds)
        @test params_dict == expected
    end
    # @testset "Test for collect_tweets" begin
    #     creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"]);
    #     params = ResourceParams("realDonaldTrump", count=100);
    #     tweets = collect_tweets(creds, params)
    # end
end
