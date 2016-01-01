defmodule Changelog.Entry do
  alias Changelog.Entry

  defstruct text: "Replace this entry text", indent: 0

  def new(text, indent \\ 0)

  def new(_, indent) when indent < 0 do
    raise ArgumentError, message: "Indent cannot be negative"
  end

  def new(nil, _) do
    raise ArgumentError, message: "Entry text cannot be nil"
  end

  def new(text, indent) when is_binary(text) do
    cond do
      text =~ ~r{^\s*$} -> raise ArgumentError, message: "Entry text cannot be empty or blank"
      true -> %Entry{text: text, indent: indent}
    end
  end

  def new(text, indent) do
    %Entry{text: text, indent: indent}
  end
end
