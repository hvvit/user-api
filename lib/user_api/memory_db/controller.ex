defmodule UserApi.MemoryDb.Controller do

  def get_user(id) do
    case :ets.lookup(:user_table, id) do
      [{^id, value}] -> value
      [] -> %{"error" => "User Id does not exist"}
    end
  end

  def get_users() do
    :ets.select(:user_table, [{{ :"$1" , :"$2" }, [] , [:"$2"]}])
  end

  defp get_last_user() do
    case :ets.last(:user_table) do
      :"$end_of_table" -> 0
      _ -> :ets.last(:user_table)
    end
  end

  defp insert_user(username, firstname, lastname, age) do
    new_id = get_last_user() + 1
    user_struct = %{
      "id" => new_id,
      "username" => username,
      "firstname" => firstname,
      "lastname" => lastname,
      "age" => age
    }
    :ets.insert(:user_table, {new_id, user_struct} )
  end

  def verify_age(age) do
    case is_integer(age) do
      true ->
        case age >= 18 and age <80 do
          true -> {:ok, "verrified"}
          _ -> {:error, "Age should be greater than or equal to 18 and less than 80"}
        end
      _ -> {:error, "Age provided is not an integer"}
    end
  end

  # def post_user(username, firstname, lastname, age) do

  #   case is_integer(age) do
  #     true ->
  #   end

  # end
end
