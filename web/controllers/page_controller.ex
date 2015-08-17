defmodule JoshTetris.PageController do
  use JoshTetris.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
