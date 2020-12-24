defmodule Sup do

  @host 'ftp.elixircasts.io'
  @username 'hello@elixircasts.io'
  @password 'i<3elixir'

  def download(filename) do
    case authenticated_client() do
      {:ok, pid} ->
        :ftp.cd(pid, 'classified')
        :ftp.recv(pid, filename)
        :ftp.close(pid)
      {:error, msg} ->
        msg
    end

    def upload(filename) do
      case authenticated_client() do
        {:ok, pid} ->
          :ftp.send(pid, filename)
          :ftp.close(pid)
        {:error, msg} ->
          msg
      end
    end

  end


  def authenticated_client do
    with {:ok, pid} <- :ftp.open(@host),
          :ok <- :ftp.user(pid, @username, @password) do
      {:ok, pid}
    else
        _ -> {:error, "Unable to authenticate"}
    end
  end
end
