defmodule Testhub.Repo.Migrations.CreateResults do
  use Ecto.Migration

  def change do
    create table(:results) do
      add :name, :string
      add :group, :string
      add :test_id, references(:tests, on_delete: :nothing)
      add :resultjson, :string

      timestamps()
    end

  end
end
