defmodule ElixirSchoolWeb.PageController do
  use ElixirSchoolWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
