defmodule JoshTetris.Game.Interaction do
  alias JoshTetris.Game.State
  alias JoshTetris.Shapes

  def handle_input(original_state, event) do
    new_state = do_handle_input(original_state, event)
    cond do
      valid?(new_state) -> new_state
      :else             -> original_state
    end
  end

  def do_handle_input(state, :move_right) do
    %State{state | x: state.x + 1}
  end

  def do_handle_input(state, :move_left) do
    %State{state | x: state.x - 1}
  end

  def do_handle_input(state, :rotate_cw) do
    %State{state | rotation: rem(state.rotation + 1, 4)}
  end

  def do_handle_input(state, :sink_piece) do
    sink_piece(state)
  end
  
  def do_handle_input(state, _), do: state

  def sink_piece(state) do
    original_state = state
    lower_shape_state = %State{state | y: state.y + 1}
    cond do
      valid?(lower_shape_state) -> sink_piece(lower_shape_state)
      :else                                 -> original_state
    end
  end
  

  def valid?(%State{x: x}) when x < 0, do: false
  def valid?(%State{y: y}) when y > 19, do: false

  def valid?(%State{}=state) do
    !past_bottom_of_board?(state) &&
    !past_right_side_of_board?(state) &&
    !collision_with_board?(state)
  end

  def collision_with_board?(state) do
    Enum.any?(State.cells_for_shape(state), fn(coords) -> State.cell_at(state, coords) != 0 end)
  end
  
  def past_right_side_of_board?(state) do
    width = Shapes.width(state.current, state.rotation)
    state.x + width >= 11
  end

  def past_bottom_of_board?(state) do
    height = Shapes.height(state.current, state.rotation)
    state.y + height >= 21
  end
  
end