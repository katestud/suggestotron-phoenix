defmodule Suggestotron.Repo.Migrations.CreateJoinTableBetweenVnuesAndCategories do
  use Ecto.Migration

  def change do
    create table(:categories_venues, primary_key: false) do
      add :category_id, references(:categories)
      add :venue_id, references(:venues)
    end
  end
end
