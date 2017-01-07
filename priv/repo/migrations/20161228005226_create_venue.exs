defmodule Suggestotron.Repo.Migrations.CreateVenue do
  use Ecto.Migration

  def change do
    create table(:venues) do
      add :name, :string
      add :location, :string
      add :description, :text

      timestamps()
    end

  end
end
