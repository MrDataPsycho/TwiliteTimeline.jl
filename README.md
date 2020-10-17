# TwiliteTimeline

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://DataPsycho.github.io/TwiliteTimeline.jl/stable)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://DataPsycho.github.io/TwiliteTimeline.jl/dev)
[![Build Status](https://github.com/DataPsycho/TwiliteTimeline.jl/workflows/CI/badge.svg)](https://github.com/DataPsycho/TwiliteTimeline.jl/actions)
[![Coverage](https://codecov.io/gh/DataPsycho/TwiliteTimeline.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/DataPsycho/TwiliteTimeline.jl)

TwiliteTimeline is a twitter API client, which is capable of querying the Twitter `statuses/user_timeline` endpoint. __The current version of the package only valid for Twitter API version 1.1__

## Use Case & Example:
The current version of the App has limited feature which will be improved in future updates. Each new feature will be introduced with elaborate examples.

To be able to use the package first user need their OAuth tokens and secrets which can be created after log in to twitter developer account by creating a new app. Then using the `Authentictor` and `ResourceParams` type provided by the package they need to define values of that type and finally use the `collect_tweets` methods to query the API.

- Authentictor is a julia concrete type to store the Consumer Key, Consumer Secret, OAuth Token and OAuth Token from twitter API. It is recommended that user save them into environment and load them by using `ENV` keyword.
- The ResourceParams concrete type is to store the Parameters needed to query the API and based on the [API document version 1.1](https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline). The default values in the package are sometime different than the API document. By default the `trim_user` is set to `false`, when providing any valid count parameter the `include_rts` will be set to `true` silently.

### Use Case 1: Get latest 100 tweets from a Profile
In the following example the all credentials is saved as environment variable and later loaded from ENV dictionary.

```julia
# Create value of type Authentictor
creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
# Create Value of Type ResourceParams
rps = ResourceParams("Viral_B_Shah", count=100)

# Call The Twitter API
tweets = collect_tweets(creds, rps)
```

### Use Case 2: Get latest 5 tweets with Excluding Replies and Trim User Data
The field `trim_user` and `exclude_replies` decides that if we want to exclude user data and  exclude replies when fetching the data or not.

```
# Create value of type Authentictor
creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])

# Create Value of Type ResourceParams
rps = ResourceParams("tomkwong", count=5, trim_user=true, exclude_replies=true)

# Call The Twitter API
tweets = collect_tweets(creds, rps)
```
The data return as list/array of dictionary, were each dictionary object is a Tweet.

Now it is possible to write and read json files having single tweets or array of tweets for
better persistency.

### User Case: Write to Json and Read from Json
First run the any of the first or second usecase to load the tweets in to a object called `tweets`. Assuming we have a `temp` directory to store the tweets. Then follow the example:

```julia
# Write the tweets
write_to_json("./temp/all_tweets.json", tweets)

# Later read the tweets
read_from_json("./temp/all_tweets.json")
```
