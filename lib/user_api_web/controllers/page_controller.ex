defmodule UserApiWeb.PageController do
  use UserApiWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
