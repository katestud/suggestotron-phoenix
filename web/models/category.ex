defmodule Suggestotron.Category do
  use Suggestotron.Web, :model

  schema "categories" do
    many_to_many :venues, Suggestotron.Venue, join_through: "categories_venues"

    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end

  defimpl Phoenix.Param do
    def to_param(%{name: name}) do
      to_string(name)
    end
  end
end
