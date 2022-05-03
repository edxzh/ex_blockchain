defmodule ExBlockchain.Blockchain do
  @moduledoc false
  @enforced_keys [:chain, :difficulty, :pending_transactions, :mining_reward]
  defstruct chain: [], pending_transactions: [], difficulty: 2, mining_reward: 50
  alias ExBlockchain.{Block, Blockchain, Transaction}

  @type t() :: %__MODULE__{
          chain: [Block.t()]
        }

  @spec generate() :: Blockchain.t()
  def generate do
    %__MODULE__{
      chain: [generate_genesis_block()],
      difficulty: 2,
      pending_transactions: [],
      mining_reward: 50
    }
  end

  @spec get_latest_block(Blockchain.t()) :: Block.t()
  defp get_latest_block(blockchain) do
    List.last(blockchain.chain)
  end

  @spec mine_block(Blockchain.t(), String.t()) :: Blockchain.t()
  def mine_block(blockchain, reward_address) do
    latest_block = get_latest_block(blockchain)

    new_block =
      Block.mine(
        latest_block.hash,
        get_timestamp(),
        blockchain.pending_transactions,
        blockchain.difficulty
      )

    transaction_of_reward = %Transaction{
      from_address: nil,
      to_address: reward_address,
      amount: blockchain.mining_reward,
      timestamp: get_timestamp()
    }

    %Blockchain{
      blockchain
      | chain: blockchain.chain ++ [new_block],
        pending_transactions: [transaction_of_reward]
    }
  end

  @spec is_blockchain_valid?(Blockchain.t()) :: Boolean.t()
  def is_blockchain_valid?(blockchain) do
    is_chain_valid?(blockchain.chain)
  end

  @spec is_chain_valid?(List.t()) :: Boolean.t()
  defp is_chain_valid?([previous_block, current_block | rest]) do
    if previous_block.hash == current_block.previous_hash do
      is_chain_valid?([current_block | rest])
    else
      false
    end
  end

  defp is_chain_valid?(_), do: true

  @spec generate_genesis_block() :: Block.t()
  defp generate_genesis_block do
    Block.mine(genesis_block_previous_hash(), get_timestamp(), [])
  end

  @spec genesis_block_previous_hash() :: String.t()
  defp genesis_block_previous_hash, do: String.duplicate("0", 64)

  @spec get_timestamp() :: String.t()
  defp get_timestamp do
    :second
    |> System.os_time()
    |> to_string()
  end
end
