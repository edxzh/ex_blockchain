defmodule ExBlockchain.BlockchainTest do
  use ExUnit.Case, async: true
  alias ExBlockchain.Blockchain

  test "generate" do
    blockchain = Blockchain.generate()

    assert length(blockchain.chain) == 1
  end

  test "is_chain_valid?" do
    blockchain = Blockchain.generate()
    blockchain = Blockchain.add_new_block(blockchain)
    blockchain = Blockchain.add_new_block(blockchain)
    blockchain = Blockchain.add_new_block(blockchain)

    assert Blockchain.is_chain_valid?(blockchain.chain)
  end
end
