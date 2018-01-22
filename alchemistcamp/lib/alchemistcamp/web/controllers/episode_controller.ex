defmodule Alchemistcamp.Web.EpisodeController do
  use Owl.Controller
  import Glue.Conn

  def show(conn, %{:name => name}) do
    render(conn, name)
  end

end