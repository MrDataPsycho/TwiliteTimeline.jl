using TwiliteTimeline
using Documenter

makedocs(;
    modules=[TwiliteTimeline],
    authors="Data Psycho",
    repo="https://github.com/DataPsycho/TwiliteTimeline.jl/blob/{commit}{path}#L{line}",
    sitename="TwiliteTimeline.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://DataPsycho.github.io/TwiliteTimeline.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/DataPsycho/TwiliteTimeline.jl",
)
