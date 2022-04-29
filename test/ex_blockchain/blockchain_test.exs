defmodule ExBlockchain.BlockchainTest do
  use ExUnit.Case, async: true

  alias ExBlockchain.Blockchain

  test "generate" do
    blockchain = Blockchain.generate()

    assert length(blockchain.chain) == 1
  end
end
