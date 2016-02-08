defmodule CliTest do
  use ExUnit.Case


  #dasda
  import GithubIssueParser.CLI, only: [ sort_descending: 1, convert_to_list_of_hashdicts: 1 ]
  test "test_name" do
    the_list = create_fake_at_list([1, 3, 2])
    the_expectes_list = create_fake_at_list([1, 2, 3])
    assert sort_descending(the_list) == the_expectes_list
  end

  defp create_fake_at_list(list_of_values) do
    data = for value <- list_of_values,
                do: [{"created_at", value}, {"dont_care", "xxx"}]
    convert_to_list_of_hashdicts( data )
  end
end
