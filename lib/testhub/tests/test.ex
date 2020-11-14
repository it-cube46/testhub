defmodule Testhub.Tests.Test do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tests" do
    field :filename, :string
    field :name, :string
    field :title, :string

    has_many :results, Testhub.Results.Result

    timestamps()
  end

  @doc false
  def changeset(test, attrs) do
    test
    |> cast(attrs, [:name, :title, :filename])
    |> validate_required([:name, :title, :filename])
  end
end
