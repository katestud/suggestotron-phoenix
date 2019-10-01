defmodule SuggestotronWeb.PageController do
  use SuggestotronWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
