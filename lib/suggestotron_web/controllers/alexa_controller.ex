defmodule SuggestotronWeb.AlexaController do
  use SuggestotronWeb, :controller
  use PhoenixAlexa.Controller, :command
  require Logger

  def launch_request(conn, _request) do
    conn |> return_response("What are you in the mood for?", %{end_session: false})
  end

  def intent_request(conn, "GetVenuesIntent", request) do
    Logger.info "Processing GetVenues"

    {suggested_venue, remaining_venues} = AlexaResponses.get_venues(request)

    conn |> return_response(suggested_venue, remaining_venues)
  end
  def intent_request(conn, "GetDifferentVenueIntent", request) do
    Logger.info "Processing GetDifferentVenues"

    search_results = request.session.attributes["search_results"]
    {suggested_venue, remaining_venues} = AlexaResponses.get_venues(search_results)

    return_response(conn, suggested_venue, remaining_venues)
  end
  def intent_request(conn, _intent, _request) do
    conn |> return_response("Sorry, I didn't understand that request.")
  end

  defp return_response(conn, text) do
    response =
      %Response{}
      |> set_output_speech(%TextOutputSpeech{text: text})
      |> set_should_end_session(true)

    conn |> set_response(response)
  end

  defp return_response(conn, text, []) do
    return_response(conn, text)
  end
  defp return_response(conn, text, %{end_session: false}) do
    response =
      %Response{}
      |> set_output_speech(%TextOutputSpeech{text: text})

    conn |> set_response(response)
  end
  defp return_response(conn, text, search_results) do
    response =
      %Response{}
      |> set_output_speech(%TextOutputSpeech{text: text})
      |> set_session_attributes(%{search_results: search_results})

    conn |> set_response(response)
  end

end
