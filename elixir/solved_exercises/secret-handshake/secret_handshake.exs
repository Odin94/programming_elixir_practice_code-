defmodule SecretHandshake do
  use Bitwise, only_operators: true

  @commands [
    {0b1000, "jump"},
    {0b100, "close your eyes"},
    {0b10, "double blink"},
    {0b1, "wink"}
  ]

  @reverse_command_bits 0b10000

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    handshake =
      Enum.reduce(@commands, [], fn bits_command, handshake_acc ->
        add_command(code, bits_command, handshake_acc)
      end)

    cond do
      (code &&& @reverse_command_bits) == @reverse_command_bits -> Enum.reverse(handshake)
      true -> handshake
    end
  end

  defp add_command(code, {bits, command}, handshake) do
    cond do
      (code &&& bits) == bits -> [command | handshake]
      true -> handshake
    end
  end
end
