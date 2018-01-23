defmodule AlchemyMarkdownTest do
  use ExUnit.Case
  doctest AlchemyMarkdown

  test "italic" do
    string = "Something *important*"
    assert AlchemyMarkdown.to_html(string) =~ "<em>important</em>"
  end


  test "big tags" do
    string = "Some ++big++ words!"
    assert AlchemyMarkdown.to_html(string) =~ "<big>big</big> words"
  end

  test "small tags" do
    string = "Some --small-- words!"
    assert AlchemyMarkdown.to_html(string) =~ "<small>small</small> words"
  end

  test "expands hr tags" do
    string1 = "Stuff over the line\n---"
    string2 = "Stuff over the line\n***"
    string3 = "Stuff over the line\n- - -"
    string4 = "Stuff over the line\n*  *  *"


    Enum.map([string1, string2, string3, string4], fn str ->
      assert AlchemyMarkdown.hrs(str) == "Stuff over the line\n<hr />"
    end)
  end

end
