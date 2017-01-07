defmodule Suggestotron.VenueView do
  use Suggestotron.Web, :view

  def category_list(venue) do
    case venue.id do
      nil -> ''
      _ -> mapped_categories(venue.categories)
    end
  end

  defp mapped_categories(categories) do
    case categories do
      nil -> ''
      _ -> Enum.map(categories, fn(c) -> c.name end ) |> Enum.join(", ")
    end
  end

end
