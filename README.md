# TwiliteTimeline

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://DataPsycho.github.io/TwiliteTimeline.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://DataPsycho.github.io/TwiliteTimeline.jl/dev)
[![Build Status](https://github.com/DataPsycho/TwiliteTimeline.jl/workflows/CI/badge.svg)](https://github.com/DataPsycho/TwiliteTimeline.jl/actions)
[![Coverage](https://codecov.io/gh/DataPsycho/TwiliteTimeline.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/DataPsycho/TwiliteTimeline.jl)

TwiliteTimeline is a twitter API client, which is capable of querying the Twitter `statuses/user_timeline` endpoint. __The current version of the package only valid for Twitter API version 1.1__

## Use Case & Example:
The current version of the App has limited feature which will be improved in future updates. Each new feature will be introduced with elaborate examples.

To be able to use the package first user need their OAuth tokens and secrets which can be created after log in to twitter devloper account by ceate a new app. Then using the `Authentictor` and `ResourceParams` type provided by the package they need to define values of that type and finally use the `collect_tweets` methods to query the API.

- Authentictor is a julia concrete type to store the Consumer Key, Consumer Secret, OAuth Token and OAuth Token from twitter api. It is recommended that user
save them into environment and load them by using `ENV` keyword.
- The ResourceParams concrete type is to store the Parametes needed to query the API and based on the [API document version 1.1](https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline). The default values in the package are sometime different than the API document. By default the `trim_user` is set to `false`, when providing any valid count parameter the `include_rts` will be set to `true` silintly.

Use Case 1: Get latest 100 tweets from a Profile
In the following example the all credentials is saved as environment variable and later loaded from ENV dictionary.

```julia
# Create value of type Authentictor
creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
# Create Value of Type ResourceParams
rps = ResourceParams('realDonaldTrump', count=100)

# Call The Twitter API
tweets = collect_tweets(creds, rps)
```

The data return as list/array of dictionary, were each dictionary object is a Tweet.
