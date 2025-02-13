using SimtesOPF
using Documenter

DocMeta.setdocmeta!(SimtesOPF, :DocTestSetup, :(using SimtesOPF); recursive = true)

const page_rename = Dict("developer.md" => "Developer docs") # Without the numbers

function nice_name(file)
  file = replace(file, r"^[0-9]*-" => "")
  if haskey(page_rename, file)
    return page_rename[file]
  end
  return splitext(file)[1] |> x -> replace(x, "-" => " ") |> titlecase
end

makedocs(;
  modules = [SimtesOPF],
  doctest = true,
  linkcheck = false, # Rely on Lint.yml/lychee for the links
  authors = "Luiz Freire  <la.freire96@gmail.com>, Carlos Neto <email>, Lucas Melo <email>",
  repo = "https://github.com/grei-ufc/SimtesOPF.jl/blob/{commit}{path}#{line}",
  sitename = "SimtesOPF.jl",
  format = Documenter.HTML(;
    prettyurls = true,
    canonical = "https://grei-ufc.github.io/SimtesOPF.jl",
    assets = ["assets/style.css"],
  ),
  pages = [
    "Home" => "index.md", "Reference" => "reference.md"
  ],
)

deploydocs(; repo = "github.com/grei-ufc/simtes-opf-jl", push_preview = true)
