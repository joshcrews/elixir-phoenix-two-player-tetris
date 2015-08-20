defmodule JoshTetris.AvailablePlayerRegistryTest do
  use ExUnit.Case, async: true

  setup do
    {:error, {:already_started, registry}} = JoshTetris.AvailablePlayerRegistry.start_link
    {:ok, registry: registry}
  end

  test "creates a partner game for me if empty" do
    {my_game, opponent_game} = JoshTetris.AvailablePlayerRegistry.get_me_a_partner
    {second_my_game, second_opponent_game} = JoshTetris.AvailablePlayerRegistry.get_me_a_partner
    
    assert second_my_game = opponent_game
  end
  
end