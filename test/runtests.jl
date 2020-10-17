using TwiliteTimeline
using Test


@testset "collector.jl" begin
    @testset "Validate Types" begin
        err = try ResourceParams("realDonaldTrump", count=-1) catch ex; ex; end
        @test err isa Exception
        err = try ResourceParams("realDonaldTrump", count=0) catch ex; ex; end
        @test err isa Exception
        test_param = ResourceParams("realDonaldTrump", trim_user=true)
        @test test_param isa ResourceParams
    end

    @testset "Test for params_to_dict" begin
        expected = Dict("include_rts" => 1,"count" => 100,"trim_user" => "true","screen_name" => "realDonaldTrump","exclude_replies" => "true")
        params = ResourceParams("realDonaldTrump", count=100, trim_user=true)
        params_dict = TwiliteTimeline.params_to_dict(params)
        @test params_dict == expected
    end
    # @testset "Test for collect_tweets" begin
    #     creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"]);
    #     params = ResourceParams("realDonaldTrump", count=100);
    #     tweets = collect_tweets(creds, params)
    #     println(tweets)
    # end
end
