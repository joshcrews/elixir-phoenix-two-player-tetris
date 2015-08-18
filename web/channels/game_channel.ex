defmodule JoshTetris.GameChannel do
  
  use Phoenix.Channel

  def join("game:play", _auth_msg, socket) do
    send(self, :after_join)
    {:ok, socket}
  end

  def handle_in("event", %{"event" => event_name}, socket) do
    # Note: don't use String.to_atom like this folks
    IO.puts "got #{event_name}"
    JoshTetris.Game.handle_input(socket.assigns[:game], String.to_atom(event_name))
    {:noreply, socket}
  end
  

  def handle_info(:after_join, socket) do
    {:ok, game} = JoshTetris.Game.start
    spawn(fn() -> JoshTetris.Websocket.run(game, socket) end)
    socket = assign(socket, :game, game)
    {:noreply, socket}
  end
  
  
end