defmodule JoshTetris.Websocket do
  @render_interval 100

  def run(game_pair, socket) do
    :timer.send_interval(@render_interval, self, :tick)
    loop(game_pair, socket)
  end
  
  def loop(game_pair, socket) do
    receive do
      :tick ->
        {your_game, opponent_game} = game_pair
        Phoenix.Channel.push socket, "tetris:your_state", JoshTetris.Game.get_state(your_game)
        Phoenix.Channel.push socket, "tetris:opponent_state", JoshTetris.Game.get_state(opponent_game)
      _ -> :ok    
    end
    loop(game_pair, socket)
  end
  
end