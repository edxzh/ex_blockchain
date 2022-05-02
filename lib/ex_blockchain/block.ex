defmodule ExBlockchain.Block do
  @moduledoc false
  @enforced_keys [:previous_hash]
  defstruct [:previous_hash, :hash, :timestamp, :data, nounce: 0]
  alias ExBlockchain.Block

  @type t() :: %__MODULE__{
          previous_hash: String.t(),
          hash: String.t(),
          timestamp: String.t()
        }

  @spec generate(String.t(), String.t(), String.t() | nil, Number.t()) :: Block.t()
  def generate(previous_hash, timestamp, data, difficulty \\ 1) do
    {hash, nounce} = calculate_hash(previous_hash, timestamp, data, difficulty)

    %Block{
      previous_hash: previous_hash,
      timestamp: timestamp,
      hash: hash,
      nounce: nounce
    }
  end

  @spec calculate_hash(String.t(), String.t(), String.t(), Integer.t()) ::
          {String.t(), Integer.t()}
  defp calculate_hash(previous_hash, timestamp, data, difficulty, nounce \\ 0) do
    hash = hash_block(previous_hash, timestamp, data, nounce)

    if String.slice(hash, 0..(difficulty - 1)) != String.duplicate("0", difficulty) do
      calculate_hash(previous_hash, timestamp, data, difficulty, nounce + 1)
    else
      {hash, nounce}
    end
  end

  @spec hash_block(String.t(), String.t(), String.t(), Integer.t()) :: String.t()
  defp hash_block(previous_hash, timestamp, data, nounce) do
    :sha256
    |> :crypto.hash(previous_hash <> timestamp <> Jason.encode!(data) <> to_string(nounce))
    |> Base.encode16()
    |> String.downcase()
  end
end
