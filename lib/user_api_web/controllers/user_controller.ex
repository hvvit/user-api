defmodule UserApiWeb.UserController do
  use UserApiWeb, :controller
  alias UserApi.MemoryDb.Controller
  alias UserApi.Users.User
  def get_users(conn, _params) do
    json conn, User.get_all_users()
  end

  def get_user(conn, %{"id" => id}) do
    json conn, Controller.get_user( String.to_integer(id))
  end

  def create_user(conn, %{"username" => username, "firstname" => firstname, "lastname" => lastname, "age" => age}) do
    case User.insert_user(username, firstname, lastname, age) do
      {:error, error} -> json conn, error
      {:ok, _} -> json conn, User.get_all_users()
    end
  end

  def delete_user(conn, %{"id" => id}) do
    case User.delete_user(String.to_integer(id)) do
      {:ok, _} -> json conn, User.get_all_users()
      {:error, error} -> json conn, error
    end
  end

end
