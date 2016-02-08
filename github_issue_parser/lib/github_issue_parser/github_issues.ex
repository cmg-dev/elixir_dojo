defmodule GithubIssueParser.GithubIssues do
  @user_agent [{ "User-agent", "RequestIssues christoph.gnip@5minds.com"}]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
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
    { :error, :jsx.decode(body) }
  end
end
