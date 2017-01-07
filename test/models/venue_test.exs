defmodule Suggestotron.VenueTest do
  use Suggestotron.ModelCase

  alias Suggestotron.Venue

  @valid_attrs %{description: "some content", location: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Venue.changeset(%Venue{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Venue.changeset(%Venue{}, @invalid_attrs)
    refute changeset.valid?
  end
end
