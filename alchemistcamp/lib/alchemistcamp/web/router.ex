defmodule Alchemistcamp.Web.Router do
  import Glue.Conn

  @template_path "lib/alchemistcamp/web/templates"

  defp get_templates() do
    for t <- Path.wildcard("#{@template_path}/*.eex"),
      do: Path.basename(t, ".eex")
  end

  def call(conn) do
    name = conn.req_path
    content_for(name, conn)
  end

  def render(conn, name) do
    assigns = Enum.to_list conn.assigns
    try do
      body = EEx.eval_file "#{@template_path}/#{name}.eex", assigns
      put_resp_body(conn, body)
    rescue
      e in CompileError ->
        details = Enum.reduce(
          Map.from_struct(e), "",
          fn {k, v}, acc ->
            acc <> "<strong>#{k}:</strong> #{v}<br>"
          end)
        put_resp_body(conn, "<h1>Template Compile Error:</h1><br>#{details}")
    end
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

  defp content_for(other, conn) do
    name = Path.basename(other)

    if Enum.member? get_templates(), name do
      render(conn, name)
    else
      not_found(conn, name)
    end
  end

  defp not_found(conn, route) do
    conn
    |> put_status(404)
    |> put_resp_body("<h1>No page found at #{route}</h1>")
  end


end