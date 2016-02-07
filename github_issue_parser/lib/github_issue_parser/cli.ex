defmodule GithubIssueParser.CLI do

  @default_count 4

  @moduledoc """
  This module implements the basic mechanism for fetching the issues from a github projekt, using the url like
  [this](https://api.github.com/repos/user/project/issues)
  """

  def run(argv) do
    argv
    |> parse_args
    |> process

  end

  @doc """
  bla bla
  """
  def parse_args(argv) do
    parse = OptionParser.parse(argv, switches: [ help:  :boolean],
                                     aliases:  [ h:     :help   ] )

    case parse do
      { _, [ user, projekt, count ], _ }
      -> { user, projekt, String.to_integer(count) }

      { _, [ user, projekt ], _ }
      -> { user, projekt, @default_count }

      { [ help: :true ], _, _ }
      -> :help

      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: issues <user> <project> [count | @{@default_count}]
    """
    System.halt(0)
  end

  def process({user, project, _count}) do
    GithubIssueParser.GithubIssues.fetch(user, project)
  end
end
