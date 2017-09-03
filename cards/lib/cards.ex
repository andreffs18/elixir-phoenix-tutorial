defmodule Cards do
  @moduledoc """
    Documentation for Cards module.
  """
  
  @doc """
  Returns new deck of cards

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Ace of Clubs", ...]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    suits = ["Spades", "Clubs", "Hearts", "Diamons"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
  From given `deck` of cards, returns a shuffled copy of the same deck

  ## Examples

      iex> deck = ["Ace of Spades", "Two of Spades", "Three of Spades"]
      iex> Cards.shuffle(deck)
      ["Three of Spades", "Ace of Spades", "Two of Spades"]
  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Returns boolean true if given `card` is inside `deck`

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Pikachu")
      false
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Returns hand of `hand_size` cards and remaining cards from given `deck`

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.deal(deck, 1)
      ["Ace of Hearts"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Saves given `deck` into file system with given `filename` in binary format
  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
  Loads previously saved deck by giving its `filename`.
  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _e} -> "File '#{filename}' does not exist"
    end
  end

  @doc """
  By giving a `hand_size` this function returns a new shuffled hand with that amount of cards

  ## Example

      iex> Cards.create_hand(2)
      ["Ace of Spades", "Ten of Hearts"]
  """
  def create_hand(hand_size) do
    {hand, _rest_of_reck} = Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
    hand
  end

end
