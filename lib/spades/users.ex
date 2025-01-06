defmodule Spades.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias Spades.Repo

  alias Spades.Users.User

  @doc """
  Gets a single user by id.
  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %user{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by id.
  Returns nil if that user does not exist.
  """
  def get_user(id), do: Repo.get(User, id)
end
