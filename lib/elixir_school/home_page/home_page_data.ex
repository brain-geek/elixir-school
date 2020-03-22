defmodule ElixirSchool.HomePage.HomePageData do
  @enforce_keys [:language, :content, :title, :version]
  defstruct language: nil, content: nil, title: nil, version: nil

  def parse!(path) do
    # Get the first path segment from the path
    language = path |> Path.split() |> List.first

    contents = parse_contents(File.read!(path))

    struct!(__MODULE__, [language: language] ++ contents)
  end

  def parse_contents(raw_content) do
    {:ok, ast, []} = Earmark.as_ast(raw_content)

    # Parse existing format of headers
    [{"hr", [{"class", "thin"}], []} | ast] = ast
    [{"p", [], [metadata]} | ast] = ast
    [{"hr", [{"class", "thin"}], []} | final_ast] = ast

    # Produce HTML from markdown
    html_content = Earmark.Transform.transform(final_ast)
    contents = metadata
      |> String.split("\n")
      |> Enum.map(fn(x) -> x
      |> String.split(": ") end)
      |> Enum.map(fn[a,b] -> {String.to_atom(a), b} end)
      |> Keyword.drop([:layout])

    Keyword.new(contents) ++ [content: html_content]
  end
end
