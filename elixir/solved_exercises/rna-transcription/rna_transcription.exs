defmodule RNATranscription do
  @transcription_map %{?A => ?U, ?C => ?G, ?T => ?A, ?G => ?C}
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RNATranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna(dna), do: do_to_rna(dna, [])

  defp do_to_rna([], rna), do: Enum.reverse(rna)

  defp do_to_rna([head | tail], rna), do: do_to_rna(tail, [@transcription_map[head] | rna])
end
