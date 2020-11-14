defmodule Testhub.Repo.Migrations.CreateTests do
  use Ecto.Migration

  def change do
    create table(:tests) do
      add :name, :string
      add :title, :string
      add :filename, :string

      timestamps()
    end

  end
end
