defmodule WeatherAggregator.GenServer do
  use GenServer

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  def init(state) do
    # Do the work initially
    state = do_work(state)
    # Schedule work to be performed at some point
    schedule_work()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # Do the work
    state = do_work(state)
    # Reschedule the work
    schedule_work()
    {:noreply, state}
  end

  def get_state do
    GenServer.call(__MODULE__, :get_state)
  end

  def handle_call(:get_state, _from, state) do
    {:reply, state, state}
  end

  def update_state(new_state) do
    IO.inspect("UPDATINNG STATE...")
    GenServer.cast(__MODULE__, {:update_state, new_state})
  end

  def handle_cast({:update_state, new_state}, current_state) do
    IO.inspect("UPDATED!")
    {:noreply, new_state}
  end

  defp schedule_work do
    Process.send_after(self(), :work, 6 * 60 * 60 * 1000)
  end

  defp do_work(state) do
    IO.inspect("AGGREGATING WEATHER NOW...")
    state = WeatherAggregator.Aggregator.run(state)
    IO.inspect("AGGREGATED!")

    state
  end
end
