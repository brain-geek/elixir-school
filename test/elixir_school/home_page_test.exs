defmodule ElixirSchool.HomePageTest do
  use ExUnit.Case

  alias ElixirSchool.HomePage
  alias ElixirSchool.HomePage.HomePageData

  describe "list_home_pages/0" do
    test "returns all home_pages" do
      all_pages = HomePage.list_home_pages()
      assert length(all_pages) >= 25

      english_language = Enum.find(all_pages, fn x -> x.language == "en" end)
      assert(english_language.title == "Elixir School")
      assert(english_language.version == "2.0.0")
      assert(english_language.content |> String.contains?("We welcome and encourage you to join us"))
    end
  end

  describe "get_home_page_data!/1" do
    test "returns nil when unknown language passed" do
      assert HomePage.get_home_page_data!("asdfg") == nil
    end

    test "returns the home_page_data with given EN language" do
      page_data = HomePage.get_home_page_data!("en")

      assert %HomePageData{title: "Elixir School", version: "2.0.0"} = page_data
      assert(page_data.content |> String.contains?("We welcome and encourage you to join us"))
    end

    test "returns the home_page_data with given UK language" do
      page_data = HomePage.get_home_page_data!("uk")

      assert %HomePageData{title: "Elixir School", version: "2.0.0"} = page_data
      assert(page_data.content |> String.contains?("Ми запрошуємо і заохочуємо вас приєднуватися та продовжувати"))
    end
  end
end
