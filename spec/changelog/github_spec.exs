defmodule GitHubSpec do
  use ESpec

  alias Changelog.GitHub

  describe "url" do
    let :https_remote, do: "https://github.com/lee-dohm/changelog.git"
    let :ssh_remote, do: "git@github.com:lee-dohm/changelog.git"
    let :url, do: "https://github.com/lee-dohm/changelog"

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
