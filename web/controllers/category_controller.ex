defmodule Suggestotron.CategoryController do
  use Suggestotron.Web, :controller

  plug Addict.Plugs.Authenticated when action in [:index, :new, :create, :delete]

  alias Suggestotron.Category

  def index(conn, _params) do
    categories = Repo.all(Category)
    render(conn, "index.html", categories: categories)
  end

  def new(conn, _params) do
    changeset = Category.changeset(%Category{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"category" => category_params}) do
    changeset = Category.changeset(%Category{}, category_params)

    case Repo.insert(changeset) do
      {:ok, _category} ->
        conn
        |> put_flash(:info, "Category created successfully.")
        |> redirect(to: category_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"name" => name}) do
    category = Repo.get_by!(Category, name: name) |> Repo.preload(:venues)
    render(conn, :show, category: category)
  end

  def delete(conn, %{"name" => name}) do
    category = Repo.get_by!(Category, name: name)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(category)

    conn
    |> put_flash(:info, "Category deleted successfully.")
    |> redirect(to: category_path(conn, :index))
  end
end
