defmodule ExBlockchain.BlockchainTest do
  use ExUnit.Case, async: true
  alias ExBlockchain.{Blockchain, Block}

  setup do
    blockchain = Blockchain.generate()
    blockchain = Blockchain.mine_block(blockchain, "fake address")
    blockchain = Blockchain.mine_block(blockchain, "fake address")
    blockchain = Blockchain.mine_block(blockchain, "fake address")

    {:ok, blockchain: blockchain}
  end

  test "generate", %{blockchain: blockchain} do
    assert length(blockchain.chain) == 4
  end

  describe "is_chain_valid?" do
    test "valid chain", %{blockchain: blockchain} do
      assert Blockchain.is_blockchain_valid?(blockchain)
    end

    test "invalid chain", %{blockchain: blockchain} do
      random_block = %Block{
        previous_hash: "not_exists_hash",
        timestamp: "timestamp",
        hash: "hash"
      }

      invalid_blokchain = %Blockchain{chain: blockchain.chain ++ [random_block]}

      refute Blockchain.is_blockchain_valid?(invalid_blokchain)
    end
  end

  describe "balance of" do
    test "positive balance", %{blockchain: blockchain} do
      assert Blockchain.balance_of_address(blockchain, "fake address") == 100
      assert Blockchain.balance_of_address(blockchain, "fake address2") == 0

      assert Enum.at(blockchain.pending_transactions, 0).to_address == "fake address"
      assert Enum.at(blockchain.pending_transactions, 0).amount == blockchain.mining_reward
    end
  end
end
