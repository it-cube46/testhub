defmodule Testhub.TestsApi.TestApi do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests" do
    field :filename, :string
    field :name, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(test_api, attrs) do
    test_api
    |> cast(attrs, [:name, :title, :filename])
    |> validate_required([:name, :title, :filename])
  end
end
