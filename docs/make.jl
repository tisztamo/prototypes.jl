using Documenter, Prototypes

makedocs(
    modules = [Prototypes],
    format = Documenter.HTML(; prettyurls = get(ENV, "CI", nothing) == "true"),
    authors = "Schaffer Krisztian",
    sitename = "Prototypes.jl",
    pages = Any["index.md"]
    # strict = true,
    # clean = true,
    # checkdocs = :exports,
)

deploydocs(
    repo = "github.com/tisztamo/Prototypes.jl.git",
    push_preview = true
)
