defmodule Alchemistcamp.Web.Router do
  use Owl.Router
  alias Alchemistcamp.Web.{EpisodeController, PageController}

  get <<"/episode/", name::binary>>, EpisodeController, :show, %{name: name}

  get "/too", PageController, :too
  get "/contact", PageController, :contact
  get "/secret", PageController, :secret

  get other, PageController, :other, %{path: other}

end