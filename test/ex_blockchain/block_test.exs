defmodule ExBlockchain.BlockTest do
  use ExUnit.Case, async: true

  alias ExBlockchain.Block

  test "generate" do
    block = Block.mine("previous_hash", "timestamp", [], 1)

    assert block.previous_hash == "previous_hash"
    assert block.timestamp == "timestamp"
    assert block.hash == "0dab46987bd8461aa27e5263e087b96d7968b2efe57848300b2f544bf4a40326"
  end
end
