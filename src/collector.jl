using OAuth, JSON

const USER_TIMELINE = "https://api.twitter.com/1.1/statuses/user_timeline.json"

"""
    Authentictor (Datatype:TwiliteTimeline)

Authenticator is defined datatype to create an object which will be used
to authenticate the user when interacting with the twitter API. Someone must
generate the Consumer Key, Consumer Secret, OAuth Token and OAuth Secret
using their own twitter developer account then using those credentionas
create a value of the type Authenticator.

# Example
```
# Here Twitter OAuth token and secret is stored as environment varialbe whith name
# CKEY, CSEC, OTOK, OSEC
julia> creds =  Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
```
"""
struct Authentictor
    consumer_key::String
    consumer_secret::String
    oauth_token::String
    oauth_secret::String
end

"""
    ResourceParams(DataType:TwiliteTimeline)

ResourceParams is a defined datatype to store the Resource Parameter mentioned in the twitter API document which we have to send when qurying the API in the request body.

To be able to use twitter API the fild value shoud satisfy the following criteria:
- When Providing valid `count` value the `include_rts` arguments must have to be 1; by default providing any valid `count` value of the `include_rts` will be set to 1 silintly
- When providing constructor argument value for the boolean field such as `trim_user`, `exclude_replies` and `include_rts` the value mush have to be 1 or 0. By the default the values are set to the default value according to Twitter API doc.

# Example
```
julia> resource_params = ResourceParams("realDonaldTrump", count=100)
ResourceParams("realDonaldTrump", nothing, nothing, 100, nothing, 0, 1)


julia> resource_params = ResourceParams("realDonaldTrump", count=100, exclude_replies=0)
ResourceParams("realDonaldTrump", nothing, nothing, 100, nothing, 0, 0)
```
"""
struct ResourceParams
    screen_name::String
    user_id::Union{Integer, Nothing}
    since_id::Union{Integer, Nothing}
    count::Union{Integer, Nothing}
    max_id::Union{Integer, Nothing}
    trim_user::Union{Bool, Nothing}
    exclude_replies::Union{Bool, Nothing}

    # Custom Constructor for the Type Signature
    ResourceParams(
        screen_name;
        user_id = nothing,
        science_id = nothing,
        count=1,
        max_id=nothing,
        trim_user=false,
        exclude_replies=true,
    ) = (
    count isa Integer && count < 1
    ? error("Count must have to be greter than or equal to 1")
    : new(screen_name, user_id, science_id, count, max_id, trim_user, exclude_replies)
    )
end

"""
    params_to_dict(rp::ResourceParams)

Is a internal function to convert the user provided Twitter API parameter into dictionary which `oauth_request_resource` from `OAuth` package expect. The method silently add `include_rts` paramater value to 1 when providing an valid `count paramter`.
"""
function params_to_dict(rp::ResourceParams)
    params = Dict{String, Union{String, Integer}}()
    for fn in fieldnames(ResourceParams)
        fv = getfield(rp, fn)
        if fv |> !isnothing
            fn_str = string(fn)
            if fv isa Bool
                params[fn_str] = string(fv)
            else
                params[fn_str] = fv
            end
        end
    end
    if haskey(params, "count")
        params["include_rts"] = 1
    end
    return params
end

"""
    collect_tweets(a::Authentictor, rp::ResourceParams)

Try to collect tweets based on given object of type Autenticator and ResourceParams. The `collect_tweets` is a wrapper around the `oauth_request_resource` method from `OAuth` package which is responsible for sending the `get` request to the `statuses/user_timeline`.

# Example
```
# Here Twitter OAuth token and secret is stored as environment varialbe whith name
# CKEY, CSEC, OTOK, OSEC
julia> creds = Authentictor(ENV["CKEY"], ENV["CSEC"], ENV["OTOK"], ENV["OSEC"])
julia> resource_params = ResourceParams("realDonaldTrump", count=100)
julia> tweets = collect_tweets(creds, resource_params);
```
That should return 100 latest tweets from the profile @realDonaldTrump.
"""
function collect_tweets(a::Authentictor, rp::ResourceParams)
    # paramter convertion to dictionary
    params = params_to_dict(rp)
    # Response Object
    resp = oauth_request_resource(
        USER_TIMELINE,
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
