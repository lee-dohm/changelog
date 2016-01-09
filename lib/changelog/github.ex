defmodule Changelog.GitHub do
  @moduledoc """
  Utilities for working with GitHub projects.
  """

  @doc """
  Determines the GitHub URL for the given remote or repository identifier.

  The remote or repository can be specified in any of the following ways:

  * GitHub-style `user/repo` specification &mdash; `lee-dohm/changelog`
  * HTTPS clone URL &mdash; `https://github.com/lee-dohm/changelog.git`
  * SSH clone URL &mdash; `git@github.com:lee-dohm/changelog.git`
  * Remote name as an atom &mdash; `:origin`
  """
  def url(remote)

  def url(nil), do: raise ArgumentError, message: "Remote specification cannot be nil, see documentation for acceptable forms"
  def url(text) when is_binary(text), do: parse_remote(text)

  defp construct_url(captures), do: "https://github.com/#{captures["user"]}/#{captures["repo"]}"

  @https_regex ~r{https://github.com/(?<user>[^/]+)/(?<repo>[^/.]+)(.git)?}
  @ssh_regex ~r{git@github.com:(?<user>[^/]+)/(?<repo>[^/.]+).git}
  @user_repo_regex ~r{(?<user>[^/]+)/(?<repo>[^/.]+)}

  defp parse_remote(text) do
    cond do
      captures = Regex.named_captures(@https_regex, text) -> construct_url(captures)
      captures = Regex.named_captures(@ssh_regex, text) -> construct_url(captures)
      captures = Regex.named_captures(@user_repo_regex, text) -> construct_url(captures)
      true -> raise ArgumentError, message: "Invalid remote specification, see documentation for acceptable forms"
    end
  end
end
