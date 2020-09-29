"""
    Authentictor (Datatype:TwiliteTimeline)

Authenticator is defined datatype to create an object which will be used
to authenticate the user when interacting with the twitter API. Someone must
generate the Consumer Key, Consumer Secret, OAuth Token and OAuth Secret
using their own twitter developer account then using those credentionas
create a value of the type Authenticator.

# Example
julia> creds = Authentictor("asdf", "asdf", "asdf", "asdf")
Authentictor("asdf", "asdf", "asdf", "asdf")
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

# Example
```
julia> resource_params = ResourceParams("realDonaldTrump", count=100)
ResourceParams("realDonaldTrump", nothing, nothing, 100, nothing, 0, 1, 1)


julia> resource_params = ResourceParams("realDonaldTrump", count=100, exclude_replies=0)
ResourceParams("realDonaldTrump", nothing, nothing, 100, nothing, 0, 0, 1)
```
"""
struct ResourceParams
    screen_name::String
    user_id::Union{Integer, Nothing}
    since_id::Union{Integer, Nothing}
    count::Integer
    max_id::Union{Integer, Nothing}
    trim_user::Union{Integer, String}
    exclude_replies::Union{Integer, String}
    include_rts::Union{Integer, String}

    ResourceParams(
        screen_name;
        user_id = nothing,
        science_id = nothing,
        count=1,
        max_id=nothing,
        trim_user=0,
        exclude_replies=1,
        include_rts=1
    ) = new(
        screen_name, user_id, science_id, count,
        max_id, trim_user, exclude_replies, include_rts
    )
end
