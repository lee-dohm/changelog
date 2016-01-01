defmodule Changelog.Header do
  def new do
    ["# CHANGELOG"]
  end

  def new(description) when is_list(description) do
    ["# CHANGELOG", "" | description]
  end

  def new(description) do
    ["# CHANGELOG", "", description]
  end
end
