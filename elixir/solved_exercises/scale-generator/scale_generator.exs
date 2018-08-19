defmodule ScaleGenerator do
  @notes ~w(C C# D D# E F F# G G# A A# B)
  @flat_notes ~w(C Db D Eb E F Gb G Ab A Bb B)

  @doc """
  Find the note for a given interval (`step`) in a `scale` after the `tonic`.

  "m": one semitone
  "M": two semitones (full tone)
  "A": augmented second (three semitones)

  Given the `tonic` "D" in the `scale` (C C# D D# E F F# G G# A A# B C), you
  should return the following notes for the given `step`:

  "m": D#
  "M": E
  "A": F
  """
  @spec step(scale :: list(String.t()), tonic :: String.t(), step :: String.t()) ::
          list(String.t())
  def step(scale, tonic, step) do
    scale
    |> Enum.find_index(&(&1 == String.capitalize(tonic)))
    |> get_scale_location(get_step_length(step), length(scale))
    |> (&Enum.at(scale, &1)).()
  end

  defp get_scale_location(starting_index, step_length, scale_length),
    do: rem(starting_index + step_length, scale_length)

  defp get_step_length(step) do
    case step do
      0 -> 0
      "m" -> 1
      "M" -> 2
      "A" -> 3
    end
  end

  @doc """
  The chromatic scale is a musical scale with thirteen pitches, each a semitone
  (half-tone) above or below another.

  Notes with a sharp (#) are a semitone higher than the note below them, where
  the next letter note is a full tone except in the case of B and E, which have
  no sharps.

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C C# D D# E F F# G G# A A# B C)
  """
  @spec chromatic_scale(tonic :: String.t()) :: list(String.t())
  def chromatic_scale(tonic \\ "C") do
    tonic
    |> String.upcase()
    |> get_scale(13, get_step_length("m"))
  end

  @doc """
  Wrap around notes to get a list of notes with desired length, starting point (tonic) and step size
  """
  defp get_scale(tonic, length, step_length) do
    @notes
    |> Enum.find_index(&(&1 == tonic))
    |> Stream.unfold(fn i ->
      {Enum.at(@notes, i), get_scale_location(i, step_length, length(@notes))}
    end)
    |> Enum.take(length)
  end

  defp get_flat_scale(tonic, length, step_length) do
    @flat_notes
    |> Enum.find_index(&(&1 == tonic))
    |> Stream.unfold(fn i ->
      {Enum.at(@flat_notes, i), get_scale_location(i, step_length, length(@flat_notes))}
    end)
    |> Enum.take(length)
  end

  @doc """
  Sharp notes can also be considered the flat (b) note of the tone above them,
  so the notes can also be represented as:

  A Bb B C Db D Eb E F Gb G Ab

  Generate these notes, starting with the given `tonic` and wrapping back
  around to the note before it, ending with the tonic an octave higher than the
  original. If the `tonic` is lowercase, capitalize it.

  "C" should generate: ~w(C Db D Eb E F Gb G Ab A Bb B C)
  """
  @spec flat_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def flat_chromatic_scale(tonic \\ "C") do
    tonic
    |> String.capitalize()
    |> get_flat_scale(13, get_step_length("m"))
  end

  @doc """
  Certain scales will require the use of the flat version, depending on the
  `tonic` (key) that begins them, which is C in the above examples.

  For any of the following tonics, use the flat chromatic scale:

  F Bb Eb Ab Db Gb d g c f bb eb

  For all others, use the regular chromatic scale.
  """
  @spec find_chromatic_scale(tonic :: String.t()) :: list(String.t())
  def find_chromatic_scale(tonic) do
    if Enum.member?(~w(F Bb Eb Ab Db Gb d g c f bb eb), tonic) do
      flat_chromatic_scale(tonic)
    else
      chromatic_scale(tonic)
    end
  end

  @doc """
  The `pattern` string will let you know how many steps to make for the next
  note in the scale.

  For example, a C Major scale will receive the pattern "MMmMMMm", which
  indicates you will start with C, make a full step over C# to D, another over
  D# to E, then a semitone, stepping from E to F (again, E has no sharp). You
  can follow the rest of the pattern to get:

  C D E F G A B C
  """
  @spec scale(tonic :: String.t(), pattern :: String.t()) :: list(String.t())
  def scale(tonic, pattern) do
    if Enum.member?(~w(F Bb Eb Ab Db Gb d g c f bb eb), tonic) do
      do_scale(tonic, pattern, @flat_notes)
    else
      do_scale(tonic, pattern, @notes)
    end
  end

  defp do_scale(tonic, pattern, notes) do
    pattern
    |> String.split("", trim: true)
    |> Enum.reduce([step(notes, tonic, 0)], fn step, [head | _tail] = acc ->
      [step(notes, head, step) | acc]
    end)
    |> Enum.reverse()
  end
end
