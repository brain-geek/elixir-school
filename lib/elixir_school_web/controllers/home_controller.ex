defmodule ElixirSchoolWeb.HomeController do
  use ElixirSchoolWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/en")
  end

  def show(conn, _params) do
    render(conn, "index.html")
  end
end
