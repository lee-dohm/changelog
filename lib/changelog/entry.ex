defmodule Changelog.Entry do
  def new(description), do: "* #{description}"

  def new_fix(id, link, description), do: "* [##{id}](#{link}) #{description}"

  def new_pull_request(id, link, username, user_link, descriptions) when is_list(descriptions) do
    entries = Enum.map(descriptions, fn(description) -> "    * #{description}" end)

    ["* [PR ##{id}](#{link}) by [#{username}](#{user_link})" | entries]
  end

  def new_pull_request(id, link, username, user_link, description) do
    "* [PR ##{id}](#{link}) by [#{username}](#{user_link}) - #{description}"
  end
end
