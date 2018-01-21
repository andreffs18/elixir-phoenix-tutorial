defmodule Alchemistcamp.Web.Router do
  import Glue.Conn

  def call(conn) do
    content_for(conn.req_path, conn)
  end

  defp content_for("/base", conn) do
    put_resp_body(conn, "<h1>Welcome :base</h1><img src='/images/bg.jpg'>")
  end

  defp content_for("/too", conn) do
    put_resp_body(conn, "<h1>Welcome :too</h1>")
  end

  defp content_for("/contact", conn) do
    put_resp_body(conn, "<h1>Welcome :contact</h1>")
  end

  defp content_for("/secret", conn) do
    put_resp_body(conn, "<h1>Welcome :secret</h1>")
  end

  defp content_for(_, conn) do
    conn
    |> put_status(404)
    |> put_resp_body("<h1>Welcome :wildcard</h1>")
  end

end