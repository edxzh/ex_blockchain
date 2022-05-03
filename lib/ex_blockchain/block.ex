defmodule ExBlockchain.Block do
  @moduledoc false
  @enforced_keys [:previous_hash, :timestamp, :hash, :transactions]
  defstruct [:previous_hash, :hash, :timestamp, :transactions, nounce: 0]
  alias ExBlockchain.{Block, Transaction}

  @type t() :: %__MODULE__{
          previous_hash: String.t(),
          hash: String.t(),
          timestamp: String.t(),
          transactions: list(Transaction.t())
        }

  @spec mine(String.t(), String.t(), list(Transaction.t()), integer()) :: Block.t()
  def mine(previous_hash, timestamp, transactions, difficulty \\ 1) do
    {hash, nounce} = calculate_hash(previous_hash, timestamp, transactions, difficulty)

    %Block{
      previous_hash: previous_hash,
      timestamp: timestamp,
      hash: hash,
      nounce: nounce,
      transactions: transactions
    }
  end

  @spec calculate_hash(String.t(), String.t(), String.t(), integer()) ::
          {String.t(), Integer.t()}
  defp calculate_hash(previous_hash, timestamp, transactions, difficulty, nounce \\ 0) do
    hash = hash_block(previous_hash, timestamp, transactions, nounce)

    if String.slice(hash, 0..(difficulty - 1)) != String.duplicate("0", difficulty) do
      calculate_hash(previous_hash, timestamp, transactions, difficulty, nounce + 1)
    else
      {hash, nounce}
    end
  end

  @spec hash_block(String.t(), String.t(), list(Transaction.t()), integer()) :: String.t()
  defp hash_block(previous_hash, timestamp, transactions, nounce) do
    :sha256
    |> :crypto.hash(
      previous_hash <> timestamp <> Jason.encode!(transactions) <> to_string(nounce)
    )
    |> Base.encode16()
    |> String.downcase()
  end
end
