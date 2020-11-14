defmodule Testhub.ResultItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "resultitems" do
    field :responce, :string
    field :score, :integer
    field :valid, :integer
    field :result_id, :id

    timestamps()
  end

  @doc false
  def changeset(result_item, attrs) do
    result_item
    |> cast(attrs, [:responce, :valid, :score])
    |> validate_required([:responce, :valid, :score])
  end
end
