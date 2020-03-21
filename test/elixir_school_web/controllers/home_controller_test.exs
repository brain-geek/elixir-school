defmodule ElixirSchoolWeb.PageControllerTest do
  use ElixirSchoolWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")

    assert conn.status == 302
    assert String.contains?(conn.resp_body, "href=\"/en\"")
  end

  test "GET /en", %{conn: conn} do
    conn = get(conn, "/en")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end
end
