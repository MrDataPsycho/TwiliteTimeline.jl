```@meta
CurrentModule = TwiliteTimeline
```

# TwiliteTimeline

TwiliteTimeline is a twitter API client, which is capable of querying the Twitter `statuses/user_timeline` and `statuses/update` endpoint. __The current version of the package only valid for Twitter API version 1.1__

## Use Case & Example:
The current version of the App has limited feature which will be improved in future updates. Each new feature will be introduced with elaborate examples. The current version has introduced new feature, now you can post tweet using TwiliteTimeline. But the design also changed along the way and old usecase examples are deprecated. Please follow new use cases to know more.

### Use Case:  Get latest 5 tweets from a Profile
To be able to use the package first user need their OAuth tokens and secrets which can be created after log in to twitter developer account by creating a new app. Then using the `Authentictor` and `ParamsGetTweets` type provided by the package they need to define values of that type and finally use the `get_tweets` methods to query the API.

- Authentictor is a julia concrete type to store the Consumer Key, Consumer Secret, OAuth Token and OAuth Token from twitter API. It is recommended that user save them into environment and load them by using `ENV` keyword.
- The ResourceParams concrete type is to store the Parameters needed to query the API and based on the [API document version 1.1](https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline). The default values in the package are sometime different than the API document. By default the `trim_user` is set to `false`, when providing any valid count parameter the `include_rts` will be set to `true` silently.

```julia
creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"]);
params = ParamsGetTweets("rustlang", count=5);
tweets = get_tweets(creds, params);
```

### Use Case: Post a New Tweet
To be able to use the package first user need their OAuth tokens and secrets which can be created after log in to twitter developer account by creating a new app. Then using the `Authentictor` and `ParamsPostTweet` type provided by the package they need to define values of that type and finally use the `post_tweet` methods to send the request.

```julia
creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"]);
params = ParamsPostTweet("... asdf asdf test tweet .... @JuliaLanguage using TwiliteTimeline.jl");
tweet = post_tweet(creds, params);
```
As twitter also return the whole tweet object after success post it is possible to persist every twitter after every post request or atleast test the return value that everything went well. In `ParamsPostTweet` type the `status` field is required and all other field either optional or has default value. **The other field need proper understanding before you use so please follow the `status/update.json` api doc before adding the other field of `ParamsPostTweet`.

Now it is possible to write and read json files having single tweets or array of tweets for better persistency.

### Use Case: Write to Json and Read from Json
First run the any of the first or second usecase to load the tweets in to a object called `tweets`. Assuming we have a `temp` directory to store the tweets. Then follow the example:

```julia
# Write the tweets
write_to_json("./temp/all_tweets.json", tweets)

# Later read the tweets
read_from_json("./temp/all_tweets.json")
```

**Deprecated and will be removed in the next minor release**
To be able to use the package first user need their OAuth tokens and secrets which can be created after log in to twitter developer account by creating a new app. Then using the `Authentictor` and `ResourceParams` type provided by the package they need to define values of that type and finally use the `collect_tweets` methods to query the API.

- Authentictor is a julia concrete type to store the Consumer Key, Consumer Secret, OAuth Token and OAuth Token from twitter API. It is recommended that user save them into environment and load them by using `ENV` keyword.
- The ResourceParams concrete type is to store the Parameters needed to query the API and based on the [API document version 1.1](https://developer.twitter.com/en/docs/twitter-api/v1/tweets/timelines/api-reference/get-statuses-user_timeline). The default values in the package are sometime different than the API document. By default the `trim_user` is set to `false`, when providing any valid count parameter the `include_rts` will be set to `true` silently.

### Use Case: Get latest 100 tweets from a Profile
In the following example the all credentials is saved as environment variable and later loaded from ENV dictionary.

```julia
# Create value of type Authentictor
creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
# Create Value of Type ResourceParams
rps = ResourceParams("Viral_B_Shah", count=100)

# Call The Twitter API
tweets = collect_tweets(creds, rps)
```

### Use Case: Get latest 5 tweets with Excluding Replies and Trim User Data
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


```@index
```

```@autodocs
Modules = [TwiliteTimeline]
```
