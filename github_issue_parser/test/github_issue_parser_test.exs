defmodule GithubIssueParserTest do
  use ExUnit.Case
  #doctest GithubIssueParser

  import GithubIssueParser.CLI, only: [ parse_args: 1 ]

  test "Parse the alternatives of the :help" do
    assert parse_args(["--h",     "anything"]) == :help
    assert parse_args(["--help",  "anything"]) == :help
    assert parse_args(["--help",  ["cmg-dev", "beginning-git", "99"]]) == :help
  end

  test "Provide all three arguments, expect a tpule of them" do
    assert parse_args(["cmg-dev", "beginning-git", "99"])
      == {"cmg-dev", "beginning-git", 99}
  end

  test "Provide only two Arguments, expect default count" do
    assert parse_args(["cmg-dev", "beginning-git"])
      == {"cmg-dev", "beginning-git", 4}
  end
end
