defmodule Suggestotron.VenueController do
  use Suggestotron.Web, :controller

  alias Suggestotron.Venue

  def index(conn, _params) do
    venues = Repo.all(Venue)
    render(conn, "index.html", venues: venues)
  end

  def new(conn, _params) do
    venue = %Venue{}
    changeset = Venue.changeset(%Venue{categories: [%Suggestotron.Category{}]})
    categories = Suggestotron.Repo.all from c in Suggestotron.Category, select: {c.name, c.id}
    render(conn, "new.html", %{changeset: changeset, venue: venue, categories: categories})
  end

  def create(conn, %{"venue" => venue_params}) do
    changeset = Venue.changeset(%Venue{}, venue_params)

    case Repo.insert(changeset) do
      {:ok, _venue} ->
        conn
        |> put_flash(:info, "Venue created successfully.")
        |> redirect(to: venue_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    venue = Repo.get!(Venue, id) |> Repo.preload(:categories)
    render(conn, "show.html", venue: venue)
  end

  def edit(conn, %{"id" => id}) do
    venue = Repo.get!(Venue, id) |> Repo.preload(:categories)
    changeset = Venue.changeset(venue)
    render(conn, "edit.html", venue: venue, changeset: changeset)
  end

  def update(conn, %{"id" => id, "venue" => venue_params}) do
    venue = Repo.get!(Venue, id) |> Repo.preload(:categories)
    changeset = Venue.changeset(venue, venue_params)

    case Repo.update(changeset) do
      {:ok, venue} ->
        conn
        |> put_flash(:info, "Venue updated successfully.")
        |> redirect(to: venue_path(conn, :show, venue))
      {:error, changeset} ->
        render(conn, "edit.html", venue: venue, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    venue = Repo.get!(Venue, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(venue)

    conn
    |> put_flash(:info, "Venue deleted successfully.")
    |> redirect(to: venue_path(conn, :index))
  end
end
