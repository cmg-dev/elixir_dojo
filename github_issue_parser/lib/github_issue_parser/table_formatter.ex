defmodule GithubIssueParser.TableFormatter do

  import Enum, only: [ each: 2, map: 2, map_join: 3, max: 1 ]

  @doc """

  """
  def convert_to_table(rows, heads) do
    data_by_columns = split_into_columns(rows, heads)
    column_width = width_of(data_by_columns)
    format = format_for(column_width)

    puts_one_line_in_coloumns(heads, format)
    IO.puts separator(column_width)
    puts_in_coloumns(data_by_columns, format)
  end

  @doc """

  """
  def split_into_columns(rows, heads) do
    for head <- heads, do:
      for row <- rows, do: printable(row[head])
  end

  @doc """

  """
  def printable(str) when is_binary(str), do: str
  def printable(str), do: to_string(str)

  @doc """

  """
  def width_of(columns) do
    for column <- columns, do: column |> map(&String.length/1) |> max
  end

  @doc """

  """
  def separator(column_width) do
    map_join(column_width, "-+-", fn width -> List.duplicate("-", width) end)
  end

  @doc """

  """
  def format_for(column_width) do
    map_join(column_width, " | ", fn width -> "~-#{width}s" end) <> "~n"
  end

  @doc """
  """
  def puts_in_coloumns(data_by_columns, format) do
    data_by_columns
    |> List.zip
    |> map(&Tuple.to_list/1)
    |> each(&puts_one_line_in_coloumns(&1, format))
  end

  @doc """

  """
  def puts_one_line_in_coloumns(fields, format) do
    :io.format(format, fields)
  end

end
