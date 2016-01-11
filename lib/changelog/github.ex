defmodule Changelog.GitHub do
  @moduledoc """
  Utilities for working with GitHub projects.
  """

  @typedoc "GitHub Issue or Pull Request number"
  @type issue_number :: pos_integer | binary

  @typedoc "Git remote name or URL"
  @type remote_or_url :: atom | binary

  @doc """
  Determines the GitHub Issue URL from the number and remote or repository identifier.

  See `url/1` for the list of acceptable forms for the remote or repository identifier.
  """
  @spec issue_url(issue_number, remote_or_url) :: binary | no_return
  def issue_url(number, remote \\ :origin)

  def issue_url(nil, _), do: raise ArgumentError, message: "Issue number cannot be nil"
  def issue_url(number, remote) when is_integer(number), do: issue_url(Integer.to_string(number), remote)
  def issue_url(number, remote), do: format_issue_url(number, remote, "issues")

  @doc """
  Determines the GitHub PR URL from the number and remote or repository identifier.

  See `url/1` for the list of acceptable forms for the remote or repository identifier.
  """
  @spec pull_url(issue_number, remote_or_url) :: binary | no_return
  def pull_url(number, remote \\ :origin)

  def pull_url(nil, _), do: raise ArgumentError, message: "Pull request number cannot be nil"
  def pull_url(number, remote) when is_integer(number), do: pull_url(Integer.to_string(number), remote)
  def pull_url(number, remote), do: format_issue_url(number, remote, "pull")

  @doc """
  Determines the GitHub URL for the given remote or repository identifier.

  The remote or repository can be specified in any of the following ways:

  * GitHub URL &mdash; `https://github.com/lee-dohm/changelog`
  * GitHub-style `user/repo` specification &mdash; `lee-dohm/changelog`
  * HTTPS clone URL &mdash; `https://github.com/lee-dohm/changelog.git`
  * SSH clone URL &mdash; `git@github.com:lee-dohm/changelog.git`
  * Git remote name as an atom &mdash; `:origin`

  Returns the base GitHub URL associated with the remote or repository.
  """
  @spec url(remote_or_url) :: binary | no_return
  def url(remote \\ :origin)

  def url(nil), do: raise ArgumentError, message: "Remote specification cannot be nil, see documentation for acceptable forms"
  def url(remote) when is_atom(remote), do: resolve_remote(remote) |> parse_remote
  def url(text) when is_binary(text), do: parse_remote(text)

  defp format_base_url(captures), do: "https://github.com/#{captures["user"]}/#{captures["repo"]}"

  defp format_issue_url(number, remote, issue_text) do
    validate_issue_number!(number)

    "#{url(remote)}/#{issue_text}/#{String.replace_leading(number, "#", "")}"
  end

  @https_regex ~r{https://github.com/(?<user>[^/]+)/(?<repo>[^/.]+)(.git)?}
  @ssh_regex ~r{git@github.com:(?<user>[^/]+)/(?<repo>[^/.]+).git}
  @user_repo_regex ~r{(?<user>[^/]+)/(?<repo>[^/.]+)}

  defp parse_remote(text) do
    cond do
      captures = Regex.named_captures(@https_regex, text) -> format_base_url(captures)
      captures = Regex.named_captures(@ssh_regex, text) -> format_base_url(captures)
      captures = Regex.named_captures(@user_repo_regex, text) -> format_base_url(captures)
      true -> raise ArgumentError, message: "Invalid remote specification, see documentation for acceptable forms"
    end
  end

  defp resolve_remote(remote) do
    {:ok, remotes} = Git.remote(resolve_repo, ["-v"])

    name = Atom.to_string(remote)
    [_, url, _] = remotes
                  |> String.split("\n")
                  |> Enum.map(&String.split/1)
                  |> Enum.find(fn([remote_name, _, _]) -> name == remote_name end)

    url
  end

  defp resolve_repo do
    {:ok, path} = Git.rev_parse(%Git.Repository{path: System.cwd}, ["--show-toplevel"])

    %Git.Repository{path: String.strip(path)}
  end

  defp validate_issue_number!(number) do
    number = String.replace_leading(number, "#", "")
             |> String.to_integer

    if number < 1, do: raise ArgumentError, message: "Issue number cannot be less than 1"
  end
end
