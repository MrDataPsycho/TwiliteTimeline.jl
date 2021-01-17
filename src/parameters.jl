"""
    Params(AbstractType: TwiliteTimeline)

ApiParams is a abstruct type for any parameter subtype. So Any subtype of ApiParams should sataify all the requirements of the ApiParams.
"""
abstract type Params end

# params_to_dict(p::Params) = error("Parameter to Dict method is not defined in concrete type.")



"""
    ParamsGetTweets(ConcreteType: TwiliteTimeline)

ParamGetTweets is a defined datatype to store the Resource Parameter mentioned in the twitter API document which we have to send when qurying the API in the request body.

To be able to use twitter API the fild value shoud satisfy the following criteria:
- When Providing valid `count` value the `include_rts` arguments must have to be 1; by default providing any valid `count` value of the `include_rts` will be set to 1 silintly
- When providing constructor argument value for the boolean field such as `trim_user`, `exclude_replies` and `include_rts` the value mush have to be 1 or 0. By the default the values are set to the default value according to Twitter API doc.

# Example
```
julia> resource_params = ParamsGetTweet("realDonaldTrump", count=100)
ParamsGetTweet("realDonaldTrump", nothing, nothing, 100, nothing, false, true)


julia> resource_params = ParamsGetTweet("realDonaldTrump", count=100, exclude_replies=true)
ParamsGetTweet("realDonaldTrump", nothing, nothing, 100, nothing, false, true)
```
"""
struct ParamsGetTweets <: Params
    screen_name::String
    user_id::Union{Integer, Nothing}
    since_id::Union{Integer, Nothing}
    count::Union{Integer, Nothing}
    max_id::Union{Integer, Nothing}
    trim_user::Union{Bool, Nothing}
    exclude_replies::Union{Bool, Nothing}

    # Custom Constructor for the Type Signature
    ParamsGetTweets(
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
    ParamsPostTweet(ConcreteType: ParamsPostTweet)

ParamsPostTweet is a defined datatype to store the Resource Parameter mentioned in the twitter API document which we have to send when qurying the API in the request body.

The status field is a mandatory field and rest of the field is set according to twitter api doc with default values. There is a lot of condition implied when using optional fields os it is suggested that use should first see the twitter version 1 api doc.

# Example

```
julia> test = ParamsPostTweet("asdf asdf asdf.")
ParamsPostTweet("asdf asdf asdf.", nothing, false, nothing, nothing, nothing, false, nothing, nothing, nothing, nothing, false, false, true, nothing)


```
"""
struct ParamsPostTweet <: Params
    status::String
    in_reply_to_status_id::Union{Integer, Nothing}
    auto_populate_reply_metadata::Union{Bool, Nothing}
    # Comma Separeted List Not sure what?
    exclude_reply_user_ids::Union{String, Nothing}
    attachment_url::Union{String, Nothing}
    # Comma Separeted List Not sure what?
    media_ids::Union{String, Nothing}
    possibly_sensitive::Union{Bool, Nothing}
    lat::Union{Float32, Nothing}
    long::Union{Float32, Nothing}
    place_id::Union{String, Nothing}
    display_coordinates::Union{Bool, Nothing}
    trim_user::Union{Bool, Nothing}
    enable_dmcommands::Union{Bool, Nothing}
    fail_dmcommands::Union{Bool, Nothing}
    card_uri::Union{String, Nothing}

    ParamsPostTweet(
        status;
        in_reply_to_status_id = nothing,
        auto_populate_reply_metadata = false,
        exclude_reply_user_ids = nothing,
        attachment_url = nothing,
        media_ids = nothing,
        possibly_sensitive = false,
        lat = nothing,
        long = nothing,
        place_id = nothing,
        display_coordinates = nothing,
        trim_user = false,
        enable_dmcommands = false,
        fail_dmcommands = true,
        card_uri = nothing
        ) = new(
            status,
            in_reply_to_status_id,
            auto_populate_reply_metadata,
            exclude_reply_user_ids,
            attachment_url,
            media_ids,
            possibly_sensitive,
            lat,
            long,
            place_id,
            display_coordinates,
            trim_user,
            enable_dmcommands,
            fail_dmcommands,
            card_uri
        )
end

"""
    params_to_dict(rp::ResourceParams)

Is a internal function to convert the user provided Twitter API parameter into dictionary which `oauth_request_resource` from `OAuth` package expect. The method silently add `include_rts` paramater value to 1 when providing an valid `count paramter`.
"""
function params_to_dict(rp::T) where {T <: Params}
    params = Dict{String, Union{String, Integer, Float32}}()
    for fn in fieldnames(T)
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
