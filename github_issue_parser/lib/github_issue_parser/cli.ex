defmodule GithubIssueParser.CLI do

  import GithubIssueParser.TableFormatter

  @default_count 4

  @moduledoc """
  This module implements the basic mechanism for fetching the issues from a github projekt, using the url like
  [this](https://api.github.com/repos/user/project/issues)
  """
  def main(argv) do
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

  @doc """

  """
  def process({user, project, count}) do
    GithubIssueParser.GithubIssues.fetch(user, project)
    |> decode_respose
    |> convert_to_list_of_hashdicts
    |> sort_descending
    |> Enum.take(count)
    |> convert_to_table(["number", "created_at", "title"])
  end

  @doc """

  """
  def decode_respose({:ok, body}) do
    body
  end

  @doc """

  """
  def decode_respose({:error, error}) do
    {_, message} = List.keyfind(error, "message", 0)
    IO.puts "Error fetching from Github: #{message}"
    System.halt(2)
  end

  @doc """

  """
  def convert_to_list_of_hashdicts(list) do
    list
    |> Enum.map(&Enum.into(&1, HashDict.new))
  end

  @doc """

  """
  def sort_descending(list) do
    Enum.sort(list,
      fn i1, i2 ->
      i1["created_at"] >= i2["created_at"] end)
  end

  @doc """

  """
  def sort_ascending(list) do
    Enum.sort(list,
      fn i1, i2 ->
      i1["created_at"] <= i2["created_at"] end)
  end
end
