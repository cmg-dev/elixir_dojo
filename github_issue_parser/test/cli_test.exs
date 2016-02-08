defmodule CliTest do
  use ExUnit.Case

  import GithubIssueParser.CLI, only:
        [ sort_descending: 1,
          sort_ascending: 1,
          convert_to_list_of_hashdicts: 1 ]

  # Sorting descending
  test "Sort 1, 3, 2 to 3, 2, 1" do
    the_list = create_fake_at_list([1, 3, 2])
    the_expectes_list = create_fake_at_list([3, 2, 1])
    assert sort_descending(the_list) == the_expectes_list
  end

  test "Sort longer list to descending order" do
    the_list = create_fake_at_list([1, 3, 2, 5, 8, 6, 9, 7, 4, 0])
    the_expectes_list = create_fake_at_list([9, 8, 7, 6, 5, 4, 3, 2, 1, 0])
    assert sort_descending(the_list) == the_expectes_list
  end

  # Sorting ascending
  test "Sort 1, 3, 2 to 1, 2, 3" do
    the_list = create_fake_at_list([1, 3, 2])
    the_expectes_list = create_fake_at_list([1, 2, 3])
    assert sort_ascending(the_list) == the_expectes_list
  end

  test "Sort longer list to ascending order" do
    the_list = create_fake_at_list([1, 3, 2, 5, 8, 6, 9, 7, 4, 0])
    the_expectes_list = create_fake_at_list([0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
    assert sort_ascending(the_list) == the_expectes_list
  end

  @doc """
    This function mocks the list we expect as HTTP response.
  """
  defp create_fake_at_list(list_of_values) do
    data = for value <- list_of_values,
                do: [{"created_at", value}, {"dont_care", "xxx"}]
    convert_to_list_of_hashdicts( data )
  end
end
