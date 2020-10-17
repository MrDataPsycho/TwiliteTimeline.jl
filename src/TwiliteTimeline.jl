module TwiliteTimeline

using OAuth, JSON

export Authentictor, ResourceParams, collect_tweets
export write_to_json, read_from_json

include("collector.jl")
include("persistor.jl")

end
