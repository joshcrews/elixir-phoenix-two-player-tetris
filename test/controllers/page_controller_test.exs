defmodule JoshTetris.PageControllerTest do
  use JoshTetris.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Tetris"
  end
end
