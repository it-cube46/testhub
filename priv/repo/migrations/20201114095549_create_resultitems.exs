defmodule Testhub.Repo.Migrations.CreateResultitems do
  use Ecto.Migration

  def change do
    create table(:resultitems) do
      add :responce, :string
      add :valid, :integer
      add :score, :integer
      add :result_id, references(:results, on_delete: :nothing)

      timestamps()
    end

    create index(:resultitems, [:result_id])
  end
end
