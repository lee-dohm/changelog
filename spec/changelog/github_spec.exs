defmodule GitHubSpec do
  use ESpec

  alias Changelog.GitHub

  let :url, do: "https://github.com/lee-dohm/changelog"

  describe "issue_url" do
    it "returns the Issue URL when given a valid issue number" do
      expect(GitHub.issue_url(42)).to eq "#{url}/issues/42"
    end

    it "returns the Issue URL when given a valid issue number as string" do
      expect(GitHub.issue_url("42")).to eq "#{url}/issues/42"
    end

    it "returns the Issue URL when given a valid issue number with leading hash mark" do
      expect(GitHub.issue_url("#42")).to eq "#{url}/issues/42"
    end

    it "raises an error when given nil" do
      expect(fn -> GitHub.issue_url(nil) end).to raise_exception ArgumentError
    end

    it "raises an error when given zero" do
      expect(fn -> GitHub.issue_url(0) end).to raise_exception ArgumentError
    end

    it "raises an error when given a negative number" do
      expect(fn -> GitHub.issue_url(-5) end).to raise_exception ArgumentError
    end
  end

  describe "pull_url" do
    it "returns the PR URL when given a valid PR number" do
      expect(GitHub.pull_url(42)).to eq "#{url}/pull/42"
    end

    it "returns the PR URL when given a valid PR number as a string" do
      expect(GitHub.pull_url("42")).to eq "#{url}/pull/42"
    end

    it "returns the PR URL when given a valid PR number with leading hash mark" do
      expect(GitHub.pull_url("#42")).to eq "#{url}/pull/42"
    end

    it "raises an error when given nil" do
      expect(fn -> GitHub.pull_url(nil) end).to raise_exception ArgumentError
    end

    it "raises an error when given zero" do
      expect(fn -> GitHub.pull_url(0) end).to raise_exception ArgumentError
    end

    it "raises an error when given a negative number" do
      expect(fn -> GitHub.pull_url(-5) end).to raise_exception ArgumentError
    end
  end

  describe "url" do
    let :https_remote, do: "https://github.com/lee-dohm/changelog.git"
    let :ssh_remote, do: "git@github.com:lee-dohm/changelog.git"

    it "raises an error when given nil" do
      expect(fn -> GitHub.url(nil) end).to raise_exception ArgumentError
    end

    it "raises an error when given an empty string" do
      expect(fn -> GitHub.url("") end).to raise_exception ArgumentError
    end

    it "raises an error when given a blank string" do
      expect(fn -> GitHub.url("     ") end).to raise_exception ArgumentError
    end

    it "returns the repository URL when given an HTTPS remote" do
      expect(GitHub.url(https_remote)).to eq url
    end

    it "returns the repository URL when given the repository URL" do
      expect(GitHub.url(url)).to eq url
    end

    it "returns the repository URL when given the SSH remote" do
      expect(GitHub.url(ssh_remote)).to eq url
    end

    it "returns the repository URL when given the user/repo name" do
      expect(GitHub.url("lee-dohm/changelog")).to eq url
    end

    it "returns the repository URL when given :origin" do
      expect(GitHub.url(:origin)).to eq url
    end
  end
end
