defmodule MiniMarkdown do

  @test_string """
  # THIS IS A TITLE

I *so* liked this **that** everything
  *is working*
## Goddamint!
++proppperlyyyy++ and --big--!!!!
  """

  def to_html(text \\ @test_string) do
    text
    |> h1
    |> h2
    |> p
    |> big
    |> bold
    |> italics
    |> small
  end


  def italics(text) do
    Regex.replace(~r/\*(.*)\*/, text, "<em>\\1</em>")
  end

  def bold(text) do
    Regex.replace(~r/\*\*(.*)\*\*/, text, "<strong>\\1</strong>")
  end

  def p(text) do
    Regex.replace(~r/(\r\n|\n|\r|^)+([^#<][^\r\n]+)((\r\n|\n|\r)+$)?/, text, "<p>\\2</p>")
  end

  def h1(text) do
    Regex.replace(~r/(\r\n|\n|\r|^)\# +([^#][^\n\r]+)/, text, "<h1>\\2</h1>")
  end

  def h2(text) do
    Regex.replace(~r/(\r\n|\n|\r|^)\#\# +([^##][^\n\r]+)/, text, "<h2>\\2</h2>")
  end

  def small(text) do
    Regex.replace(~r/\-\-(.*)\-\-/, text, "<small>\\1</small>")
  end

  def big(text) do
    Regex.replace(~r/\+\+(.*)\+\+/, text, "<big>\\1</big>")
  end
end