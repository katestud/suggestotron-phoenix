defmodule Suggestotron.Repo.Migrations.AddUniqueIndexToVenueNames do
  use Ecto.Migration

  def change do
    create unique_index(:venues, [:name])
  end
end
