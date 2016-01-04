defmodule Changelog.Entry do
  alias Changelog.Entry

  defstruct text: "Replace this entry text", indent: 0

  def new(text, indent \\ 0)

  def new(_, indent) when indent < 0 do
    raise ArgumentError, message: "Indent cannot be negative"
  end

  def new(text, indent) do
    if is_blank(text), do: raise ArgumentError, message: "text cannot be blank"

    %Entry{text: text, indent: indent}
  end

  defp is_blank(text) do
    cond do
      is_nil(text)      -> true
      text =~ ~r{^\s*$} -> true
      true              -> false
    end
  end
end
