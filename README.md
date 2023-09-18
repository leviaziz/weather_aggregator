# WeatherAggregator

WeatherAggregator is a weather forecast aggregator application. For now, it is implemented for two cities using two free weather APIs. Application first starts with fetching the required temperature and humiditiy data from two sources, aggregates the data and saves it to genserver state. 

REST API endpoints are also implemented. It contains two GET enpoints providing sumamry and detail information, and a POST endpoint which triggers to fetch new data and update the state.

Note: For now system contains past days' data as well if application is working for multiple days. We can amend the existing logic, once it is clear.
## How to run the project?

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Run `source .env` to set environment variables 
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
