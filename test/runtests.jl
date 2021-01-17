using TwiliteTimeline
using Test


@testset "Test for collector.jl" begin
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

@testset "Test for parameters.jl" begin
    @testset "Validate Type ParamsPostTweet" begin
        expected = Dict("status" => "asdf asdf asdf.", "auto_populate_reply_metadata" => "false", "fail_dmcommands" => "true", "enable_dmcommands" => "false", "trim_user" => "false", "possibly_sensitive" => "false")
        params =  ParamsPostTweet("asdf asdf asdf.")
        params_dict = TwiliteTimeline.params_to_dict(params)
        @test params_dict == expected
    end

    @testset "Validate Type ParamsGetTweets" begin
        expected = Dict("include_rts" => 1,"count" => 100,"trim_user" => "true","screen_name" => "realDonaldTrump","exclude_replies" => "true")
        params = ParamsGetTweets("realDonaldTrump", count=100, trim_user=true)
        params_dict = TwiliteTimeline.params_to_dict(params)
        @test params_dict == expected
    end
end

# @testset "Test for Caller Functions" begin
#     @testset "Test for get_tweets" begin
#         creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"]);
#         params = ParamsGetTweets("rustlang", count=2);
#         tweets = get_tweets(creds, params);
#         @test length(tweets) > 0
#     end
#
#     @testset "Test for post_tweet" begin
#         creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"]);
#         params = ParamsPostTweet("... asdf asdf test tweet .... @JuliaLanguage using TwiliteTimeline.jl");
#         tweet = post_tweet(creds, params);
#         @test strip(tweet["text"]) == strip(params.status)
#     end
# end
