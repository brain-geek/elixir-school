defmodule ElixirSchoolWeb.HomeController do
  use ElixirSchoolWeb, :controller

  alias ElixirSchool.HomePage

  def index(conn, _params) do
    redirect(conn, to: "/en")
  end

  def show(conn, %{"lang" => language}) do
    page_data = HomePage.get_home_page_data!(language)

    if is_nil(page_data) do
      conn
        |> put_status(:not_found)
        |> put_view(ElixirSchoolWeb.ErrorView)
        |> render("404.html")
    else
      other_languages = HomePage.list_home_pages()
        |> Enum.map(fn x -> x.language end)
        |> Enum.map(fn x -> {x, ElixirSchoolWeb.Router.Helpers.home_path(conn, :show, x) } end)

      render(conn, "index.html", page_data: page_data, other_languages: other_languages)
    end
  end
end
