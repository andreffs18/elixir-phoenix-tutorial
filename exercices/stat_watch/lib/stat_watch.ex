defmodule StatWatch do

  def run() do
    fetch_data()
    |> save_csv
  end

  def stats_url do
    "https://min-api.cryptocompare.com/data/price?fsym=ETH&tsyms=BTC,USD,EUR"
  end

  def fetch_data do
    now = DateTime.to_string(%{DateTime.utc_now | microsecond: {0, 0}})
    %{body: body} = HTTPoison.get! stats_url()
    data = Poison.decode! body, keys: :atoms
    Enum.join [now, data[:BTC], data[:EUR], data[:USD]], ","
  end

  def save_csv(row, name \\ ["stats"]) do
    filename = "#{name}.csv"
    unless File.exists? filename do
      File.write!(filename, column_names() <> "\n")
    end

    File.write!(filename, row <> "\n", [:append])
  end

  def column_names() do
    Enum.join ~w(DATE BTC EUR USD), ","
  end
end
