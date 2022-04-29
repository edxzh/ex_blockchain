defmodule ExBlockchain.Blockchain do
  @moduledoc false
  @enforced_keys [:chain]
  defstruct [:chain]
  alias ExBlockchain.{Block, Blockchain}

  @type t() :: %__MODULE__{
          chain: [Block.t()]
        }

  @spec generate() :: Blockchain.t()
  def generate do
    %__MODULE__{
      chain: [generate_genesis_block()]
    }
  end

  @spec generate_genesis_block() :: Block.t()
  defp generate_genesis_block do
    Block.generate(genesis_block_previous_hash(), get_timestamp())
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
