defmodule Suggestotron.CategoryView do
  use SuggestotronWeb, :view

  def render("show.json", %{category: category}) do
    %{category: category_json(category)}
  end

  def category_json(category) do
    %{
      name: category.name,
      venues: Enum.map(category.venues, &venue_json/1)
    }
  end

  def venue_json(venue) do
    %{
      name: venue.name,
      location: venue.location,
      description: venue.description
    }
  end

end
