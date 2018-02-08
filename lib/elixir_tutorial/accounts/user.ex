defmodule ElixirTutorial.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ElixirTutorial.Accounts.User


  schema "users" do
    field :age, :integer
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:name, :age])
    |> validate_required([:name, :age])
    |> unique_constraint(:name)
  end
end
