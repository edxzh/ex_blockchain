defmodule ExBlockchain.Block do
  @moduledoc false
  @enforced_keys [:previous_hash]
  defstruct [:previous_hash, :hash, :timestamp]
  alias ExBlockchain.Block

  @type t() :: %__MODULE__{
          previous_hash: String.t(),
          hash: String.t(),
          timestamp: String.t()
        }

  @spec generate(String.t(), String.t()) :: Block.t()
  def generate(previous_hash, timestamp) do
    %Block{
      previous_hash: previous_hash,
      timestamp: timestamp,
      hash: calculate_hash(previous_hash, timestamp)
    }
  end

  @spec calculate_hash(String.t(), String.t()) :: String.t()
  defp calculate_hash(previous_hash, timestamp) do
    :sha256
    |> :crypto.hash(previous_hash <> timestamp)
    |> Base.encode16()
    |> String.downcase()
  end
end
