defmodule GithubIssueParser.GithubIssues do
  @github_url Application.get_env(:issues, :github_url)
  @access_token Application.get_env(:api, :access_token)

  @user_agent [{ "User-agent", "RequestIssues christoph.gnip@gmail.com"}]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues?access_token=#{@access_token}"
  end

  @doc """

  """
  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    { :ok, :jsx.decode(body) }
  end

  @doc """
  This handles every other status code, which will be an error for us.
  """
  def handle_response({:ok, %HTTPoison.Response{status_code: ___, body: body}}) do
    IO.puts "response was :error #{body}"
    { :error, :jsx.decode(body) }
  end
end
