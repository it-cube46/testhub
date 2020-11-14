defmodule Testhub.Results.Result do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results" do
    field :group, :string
    field :name, :string
    belongs_to :test, Testhub.Tests.Test
    field :resultjson, :string
    field :response, :string
    field :score, :integer

    timestamps()
  end

  @doc false
  def changeset(result, attrs) do
    result
    |> cast(attrs, [:name, :group, :resultjson, :test_id, :response, :score])
    |> validate_required([:name, :group, :resultjson, :test_id, :response, :score])
  end
end
