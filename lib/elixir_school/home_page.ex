defmodule ElixirSchool.HomePage do
  @moduledoc """
  The HomePage context.
  """

  alias ElixirSchool.HomePage.HomePageData

  data_paths = "*/index.md" |> Path.wildcard() |> Enum.sort()
  data_list =
    for data_path <- data_paths do
      @external_resource Path.relative_to_cwd(data_path)
      HomePageData.parse!(data_path)
    end

  @entries data_list

  @doc """
  Returns all home page data entries.

  ## Examples

      iex> list_home_pages()
      [%HomePageData{}, ...]

  """
  def list_home_pages(), do: @entries

  @doc """
  Gets a single home page data given a language.

  Returns nil if the Home page data does not exist.

  ## Examples

      iex> get_home_page_data!('en')
      %HomePageData{}

      iex> get_home_page_data!('asdf')
      nil

  """
  def get_home_page_data!(language) do
    @entries |> Enum.find(fn(x) -> x.language == language end)
  end

end
