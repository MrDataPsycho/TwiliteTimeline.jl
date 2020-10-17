const ArrayOrDict = Union{Array, Dict}

"""
    write_to_json(path::String, tw::ArrayOrDict)

General functon to write Dict or Array of Dict as tweet as json for better
persistance. The method expect the following parameters:
- path: path to save the file with file name (see the example)
- tw: Array of Dict or Dict object to write as json
# Example
```
julia> tweet = Dict("asdf" => "asdf")
Dict{String,String} with 1 entry:
  "asdf" => "asdf"

julia> tweets = [tweet, tweet]
2-element Array{Dict{String,String},1}:
 Dict("asdf" => "asdf")
 Dict("asdf" => "asdf")

julia> write_to_json("./temp/all_tweets.json",tweet)
File writting was successful!


julia> write_to_json("./temp/single_tweet.json",tweet)
File writting was successful!
```
"""
function write_to_json(path::String, tw::ArrayOrDict)
    try
        open(path, "w") do f JSON.print(f, tw)  end
        print("File writting was successful! \n")
    catch ex
        error("Error while writting file: $ex \n")
    end
end

"""
    read_from_json(path::String)

Given a path of json file the method should be able to read files as Dict type or Array
of Dict. The method expect the following parameters:
- path: path of the json file to load

# Example
```
julia> read_from_json("./temp/all_tweets.json")
File loading successful!
Dict{String,Any} with 1 entry:
  "asdf" => "asdf
```
"""
function read_from_json(path::String)
    try
        tws = nothing
        open(path, "r") do f
            dict_txt = read(f, String)
            tws=JSON.parse(dict_txt)
        end
        print("File loading successful!\n")
        return tws
    catch ex
        error("Error while reading file: $ex")
    end
end
