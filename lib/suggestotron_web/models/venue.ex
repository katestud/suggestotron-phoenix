defmodule Suggestotron.Venue do
  use SuggestotronWeb, :model

  schema "venues" do
    many_to_many :categories, Suggestotron.Category, join_through: "categories_venues", on_replace: :delete, on_delete: :delete_all

    field :name, :string
    field :location, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :location, :description])
    |> put_assoc(:categories, parse_categories(params))
    |> validate_required([:name])
  end

  def parse_categories(params) do
    (params["categories"] || "")
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.reject(& &1 == "")
    |> insert_and_get_all()
  end

  defp insert_and_get_all([]) do
    []
  end
  defp insert_and_get_all(names) do
    maps = Enum.map(names, &%{name: &1})
    Suggestotron.Repo.insert_all Suggestotron.Category, maps, on_conflict: :nothing
    Suggestotron.Repo.all from c in Suggestotron.Category, where: c.name in ^names
  end

end
