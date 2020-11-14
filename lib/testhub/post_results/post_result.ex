defmodule Testhub.PostResults.PostResult do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results" do
    field :group, :string
    field :name, :string
    field :resultjson, :string

    timestamps()
  end

  @doc false
  def changeset(post_result, attrs) do
    post_result
    |> cast(attrs, [:name, :group, :resultjson])
    |> validate_required([:name, :group, :resultjson])
  end
end
