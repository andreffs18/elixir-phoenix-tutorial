defmodule Alchemistcamp.Web.PageController do
  use Owl.Controller
  import Glue.Conn

  @template_path "lib/alchemistcamp/web/templates"

  def too(conn, _params) do
    render(conn, "too")
  end

  def other(conn, %{:path => path}) do
    name = Path.basename(path)
    name = Path.basename(path)

    if Enum.member? get_templates(), name do
      render(conn, name)
    else
      not_found(conn, name)
    end
  end

  defp get_templates() do
    for t <- Path.wildcard("#{@template_path}/*.eex"),
      do: Path.basename(t, ".eex")
  end

  defp not_found(conn, route) do
    conn
    |> put_status(404)
    |> put_resp_body("<h1>No page found at #{route}</h1>")
  end

end