defmodule ElixirSchool.HomePageDataTest do
  use ExUnit.Case

  alias ElixirSchool.HomePage.HomePageData

  describe "parse!/1" do
    test "reads content and processes it as markdown" do
      data = HomePageData.parse!("en/index.md")

      assert(data.content |> String.contains?("We welcome and encourage you to join us"))
      assert(data.content |> String.contains?("<a href=\"/vi/\""))
    end

    test "it sets correct language for parsed file" do
      assert(HomePageData.parse!("en/index.md").language == "en")
      assert(HomePageData.parse!("uk/index.md").language == "uk")
      assert(HomePageData.parse!("pt/index.md").language == "pt")
    end

    test "it parses title and version" do
      assert(HomePageData.parse!("en/index.md").title == "Elixir School")
      assert(HomePageData.parse!("en/index.md").version == "2.0.0")

      assert(HomePageData.parse!("pl/index.md").title == "Elixir School")
      assert(HomePageData.parse!("pl/index.md").version == "1.0.0")
    end
  end
end
