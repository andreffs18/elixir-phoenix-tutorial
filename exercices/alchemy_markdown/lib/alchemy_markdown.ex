defmodule AlchemyMarkdown do

  def to_html(markdown) do
    Earmark.as_html!((markdown || ""), %Earmark.Options{smartypants: false})
    |> small
    |> big
    |> hrs
  end

  def small(text) do
    Regex.replace(~r/\-\-(.*)\-\-/, text, "<small>\\1</small>")
  end

  def big(text) do
    Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
  end

  def hrs(text) do
    Regex.replace(~r/([-*])( *\1 *)+\1/, text, "<hr />")
  end

end
