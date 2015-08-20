defmodule JoshTetris.AvailablePlayerRegistry do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: :player_registry)
  end

  def get_me_a_partner do
    GenServer.call(:player_registry, {:find_or_create_a_partner})
  end
  

  # Callbacks

  def handle_call({:find_or_create_a_partner}, _from, nil) do
    {:ok, my_game} = JoshTetris.Game.start
    {:ok, opponent_game} = JoshTetris.Game.start
    game_pair = {my_game, opponent_game}
    {:reply, game_pair, game_pair}
  end

  def handle_call({:find_or_create_a_partner}, _from, {opponent_game, my_game}) do
    game_pair = {my_game, opponent_game}
    {:reply, game_pair, nil}
  end
  
end