defmodule ElixirTutorial.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirTutorial.Accounts.User


  schema "users" do
    field :name, :string
    field :email, :string
    field :hashed_password, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password, :password_confirmation])
    |> validate_format(:email, ~r/\A[^@\s]+@[^@\s]+\z/)
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_length(:password, min: 6, max: 128)
    |> validate_required([:name, :email, :password, :password_confirmation])
    |> unique_constraint(:name)
    |> unique_constraint(:email)
    |> put_pass_hash
    |> validate_required([:hashed_password])
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, hashed_password: Comeonin.Bcrypt.hashpwsalt(password))
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: false} = changeset), do: changeset
end
