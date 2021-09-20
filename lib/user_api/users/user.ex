defmodule UserApi.Users.User do
  alias UserApi.MemoryDb.Memory

  def get_user_by_id(id) do
    case Memory.get_user(id) do
      {:ok, value} -> value
      {:error, error} -> %{"error" => error}
    end
  end

  def get_user_by_username(username) do
    user_list = Memory.get_users()
    case user_list do
      {:error, _ } -> {:error, "Userlist is empty"}
      {:ok, users} ->
        user = Enum.find(users, fn map -> map["username"] == username end)
        case user do
          nil -> {:error, %{"error" => "username does not exist"}}
          _ -> {:ok, user }
        end
    end
  end

  def get_all_users() do
    case Memory.get_users() do
      {:ok, value} -> value
      {:error, error} -> %{"error" => error}
    end
  end

  defp verify_user_age(age) do
    case is_integer(age) do
      true ->
        case age >= 18 and age <80 do
          true -> {:ok, "verrified"}
          _ -> {:error, "Age should be greater than or equal to 18 and less than 80"}
        end
      _ -> {:error, "Age provided is not an integer"}
    end
  end



  defp create_user_struct(id, username, firstname, lastname, age) do
    user_struct = %{
      "id" => id,
      "username" => username,
      "firstname" => firstname,
      "lastname" => lastname,
      "age" => age
    }
    user_struct
  end

  def insert_user(username, firstname, lastname, age) do
    case get_user_by_username(username) do
      {:error, _ } ->
        case verify_user_age(age) do
          {:ok, _ } ->
            id =  Memory.get_new_id()
            user_struct = create_user_struct(id, username, firstname, lastname, age)
            Memory.push_user(id, user_struct)
          {:error, error} -> {:error, error}
        end
      {:ok, _ } -> {:error , %{"error" => "Username already exists"}}
    end
  end

  def delete_user(id) do
    case Memory.delete_user(id) do
      true -> {:ok, "User deleted"}
      {:error, error} -> error
      _ -> {:error, "cache error"}
    end
  end
end
