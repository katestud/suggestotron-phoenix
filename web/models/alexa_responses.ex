defmodule AlexaResponses do

  @error_response "Sorry, I'm not able to process that request."

  def get_venues([]) do
    {"Sorry, there were no more results.", []}
  end
  def get_venues(nil) do
    {"Sorry, there were no results for that category.", []}
  end
  def get_venues(
    %{ request: %{ intent: %{ slots: %{
        "Category" => %{"value" => category} } },
        },
        session: %{ user: %{ userId: user_id } }
      }
    ) do
    category = Suggestotron.Repo.get_by(Suggestotron.Category, name: category)
    |> Suggestotron.Repo.preload(:venues)

    results = case category do
      nil -> []
      record -> category.venues |> Enum.map(fn(v) -> v.name end) |> Enum.shuffle
    end

    get_venues(results)
  end
  def get_venues(search_results) do
    [suggestion | remaining] = search_results
    {construct_suggestion(suggestion), remaining}
  end
  def get_venues(_) do
    @error_response
  end

  def construct_suggestion(venue) do
    suggestion_phrase = [
      "How do you feel about ",
      "Are you in the mood for ",
      "Have you recently been to "
    ]
    |> Enum.shuffle
    |> List.first

    suggestion_phrase <> venue <> "?"
  end

end
