defmodule JoshTetris.GameChannel do
  
  use Phoenix.Channel

  def join("game:play", _auth_msg, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_in("event", %{"event" => event_name}, socket) do
    {your_game, _} = socket.assigns[:games]
    # Note: don't use String.to_atom like this folks
    JoshTetris.Game.handle_input(your_game, String.to_atom(event_name))
    {:noreply, socket}
  end
  

  def handle_info(:after_join, socket) do
    {my_game, opponent_game} = JoshTetris.AvailablePlayerRegistry.get_me_a_partner

    games = {my_game, opponent_game}

    spawn(fn() -> JoshTetris.Websocket.run(games, socket) end)
    socket = assign(socket, :games, games)

    {:noreply, socket}
  end
  
  
end