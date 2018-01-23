defmodule MinimalTodo do

  def main do
    filename = IO.gets("Name of .csv to load:  ")
      |> String.trim
      |> read
      |> parse


  end

  def read(filename) do
    case File.read(filename) do
      {:ok, body} -> body
      {:error, reason} -> IO.puts ~s(Could not open the file "#{filename}"\n)
                          IO.inspect reason
                          main()
    end
  end

  def parse(body) do
    [header | lines] = String.split(body, ~r{(\r\n|\n|\r)})
    titles = tl String.split(header, ",")
    parse_lines(lines, titles)

  end

  def parse_lines(lines, titles) do
    Enum.reduce(lines, %{}, fn line, build ->
      [name | fields] = String.split(line, ",")
      if Enum.count(fields) == Enum.count(titles) do
        line_data = Enum.zip(titles, fields) |> Enum.into(%{})
        Map.merge(build, %{name => line_data})
      else
        build
      end
    end)
  end

end