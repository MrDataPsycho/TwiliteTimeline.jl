"""Constant for base url and url suffix."""
const BASE_URL = "https://api.twitter.com/1.1/statuses/"
const URL_SUFFIX = ".json"


"""
    get_tweets(a::Authentictor, p::ParamsGetTweet)

Try to collect tweets based on given object of type Autenticator and ParamsGetTweet. The `get_tweets` is a wrapper around the `oauth_request_resource` method from `OAuth` package which is responsible for sending the `get` request to the `statuses/user_timeline.json`.

# Example
```
# Here Twitter OAuth token and secret is stored as environment varialbe whith name
# CKEY, CSEC, OTOK, OSEC
julia> creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
julia> params = ParamsGetTweet("realDonaldTrump", count=100)
julia> tweets = get_tweets(creds, params);
```
That should return 100 latest tweets from the profile @realDonaldTrump.
"""
function get_tweets(a::Authentictor, p::ParamsGetTweets)
    url = joinpath(BASE_URL, "user_timeline.json")
    # paramter convertion to dictionary
    params = params_to_dict(p)
    # Response Object
    resp = oauth_request_resource(
        url,
        "GET",
        params,
        a.consumer_key,
        a.consumer_secret,
        a.oauth_token,
        a.oauth_secret
    )
    if resp.status == 200
        newdata = JSON.parse(String(resp.body))
        return newdata
    else
        error("Twitter API returned $(r.status) status")
    end
end

"""
    post_tweet(a::Authentictor, p::ParamsPostTweet)

Try to collect tweets based on given object of type Autenticator and ParamsPostTweet. The `post_tweet` is a wrapper around the `oauth_request_resource` method from `OAuth` package which is responsible for sending the `get` request to the `statuses/update.json`.

# Example
```
# Here Twitter OAuth token and secret is stored as environment varialbe whith name
# CKEY, CSEC, OTOK, OSEC
julia> creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
julia> resource_params = ParamsPostTweet("asdf asdf asdf Test tweet")
julia> tweets = post_tweet(creds, resource_params);
```
That should return 100 latest tweets from the profile @realDonaldTrump.
"""
function post_tweet(a::Authentictor, p::ParamsPostTweet)
    url = joinpath(BASE_URL, "update.json")
    # paramter convertion to dictionary
    params = params_to_dict(p)
    # Response Object
    resp = oauth_request_resource(
        url,
        "POST",
        params,
        a.consumer_key,
        a.consumer_secret,
        a.oauth_token,
        a.oauth_secret
    )
    if resp.status == 200
        newdata = JSON.parse(String(resp.body))
        return newdata
    else
        error("Twitter API returned $(r.status) status")
    end
end
