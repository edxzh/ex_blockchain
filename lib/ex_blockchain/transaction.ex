defmodule ExBlockchain.Transation do
  @moduledoc false
  defstruct [:from_address, :to_address, :amount, :timestamp]
end
