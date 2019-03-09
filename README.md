# Suggestotron

This application was built as a personal project to help me optimize my time in downtown Durham. It's Tuesday, and you want to go out for dinner, but you're not sure what you want? Ask Suggestotron! The project includes a few components:
* GUI where users (me) can add their favorite spots in downtown Durham, with tags.
* Alexa integration that allows users to ask Suggestotron where they should go. Example flow:
  * User: Alexa, open Suggestotron
  * Alexa: What are you in the mood for?
  * User: Pizza
  * Alexa: How about you try pie pushers?
  * User: No, try again.
  * Alexa: What about Pizzeria Toro?
  * User: Sounds good.

If you'd like to run the project locally:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `npm install`
  * Start Phoenix endpoint with `mix phoenix.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

I've deployed this project to Heroku for my use case, but it's not available for public use.
