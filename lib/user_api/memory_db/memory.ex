defmodule UserApi.MemoryDb.Memory do

  use GenServer

  def start_link(_), do: GenServer.start_link(__MODULE__, %{}, name: __MODULE__)

  @impl true
  def init(state) do
    :ets.new(:user_table,[:named_table, :public, write_concurrency: true])
    IO.puts("In Memory table intialised")
    {:ok, state}
  end

  @impl true
  def handle_info(:status, state) do
    {:noreply, state}
  end

  def get_users() do
    user_list = :ets.select(:user_table, [{{ :"$1" , :"$2" }, [] , [:"$2"]}])
    case user_list  do
      [] -> {:error, "No users exists"}
      _ -> {:ok, user_list}
    end
  end

  def get_user(id) do
    case :ets.lookup(:user_table, id) do
      [{^id, value}] -> {:ok, value}
      [] -> {:error, "User id does not exist"}
    end
  end

  defp get_last_user() do
    case :ets.last(:user_table) do
      :"$end_of_table" -> 0
      _ -> :ets.last(:user_table)
    end
  end

  def get_new_id() do
    get_last_user() + 1
  end

  def push_user(id , user_struct) do
    :ets.insert(:user_table, {id, user_struct} )
    {:ok, "User Pushed"}
  end

  def delete_user(id) do
    case get_user(id) do
      {:ok, value} -> :ets.delete_object(:user_table, {id, value})
      {:error, _} -> {:error, "User id does not exist"}
    end
  end
end
