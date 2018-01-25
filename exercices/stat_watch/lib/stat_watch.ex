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
    [ %{"id": this_id} = row | _ ] = Poison.decode! body, keys: :atoms
    [ now, this_id] |> Enum.join(", ")
  end

  def save_csv(row) do
    filename = "stats.csv"
    unless File.exists? filename do
      File.write!(filename, column_names() <> "\n")
    end

    File.write!(filename, row <> "\n", [:append])
  end

  def column_names() do
    Enum.join ~w(Datetime Subscribers Videos Views), ","
  end
end
