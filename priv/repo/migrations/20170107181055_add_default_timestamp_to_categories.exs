defmodule Suggestotron.Repo.Migrations.AddDefaultTimestampToCategories do
  use Ecto.Migration

  def change do
    alter table(:categories) do
      modify :inserted_at, :timestamp, default: fragment("NOW()")
      modify :updated_at, :timestamp, default: fragment("NOW()")
    end
  end
end
