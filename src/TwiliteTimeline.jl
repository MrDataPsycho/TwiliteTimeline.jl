module TwiliteTimeline

using OAuth, JSON

export Authentictor, ResourceParams, collect_tweets
export ParamsGetTweets, ParamsPostTweet
export get_tweets, post_tweet
export write_to_json, read_from_json

include("collector.jl")
include("persistor.jl")
include("parameters.jl")
include("callers.jl")

end
