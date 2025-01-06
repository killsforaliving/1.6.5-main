defmodule Spades.Users.User do
  @moduledoc """
  Represents a user of the system.
  Managed by the "pow" library.
  """
  use Ecto.Schema
  @timestamps_opts [type: :utc_datetime]
  use Pow.Ecto.Schema
  alias Spades.Users.User

  use Pow.Extension.Ecto.Schema,
    extensions: [PowResetPassword, PowEmailConfirmation]

  schema "users" do
    pow_user_fields()
    field(:alias, :string)

    timestamps()
  end

  def changeset(user_or_changeset, attrs) do
    user_or_changeset
    |> pow_changeset(attrs)
    |> pow_extension_changeset(attrs)
    |> Ecto.Changeset.cast(attrs, [:alias])
    |> Ecto.Changeset.validate_required([:alias])
    |> Ecto.Changeset.unique_constraint(:alias)
  end

  @doc """
  to_my_profile/1:
  Given a User object, return a UserProfile map that's delivered
  to the front end via the Profile controller.
  This way, we can customize what fields we send to the frontend.
  This is called a "Profile" in the JS backend (private info about you.)
  """
  def to_my_profile(%User{} = user) do
    %{
      id: user.id,
      alias: user.alias,
      email: user.email,
      inserted_at: user.inserted_at,
      email_confirmed_at: user.email_confirmed_at
    }
  end

  @doc """
  to_public_profile/1:
  Public profile: If getting info about another user, you shouldn't
  be able to see their emails and such
  This is called a "User" in the JS backend (public info about seomeone else.)
  """
  def to_public_profile(%User{} = user) do
    %{
      id: user.id,
      alias: user.alias
    }
  end
end
