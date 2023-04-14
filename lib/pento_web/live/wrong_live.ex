defmodule PentoWeb.WrongLive do
  use Phoenix.LiveView, layout: {PentoWeb.LayoutView, "live.html"}

  def mount(_params, _session, socket) do
    {:ok, assign(socket, score: 0, message: "Make a guess:", time: time())}
  end

  def render(assigns) do
    ~H"""
    <h1>Your score: <%= @score %> </h1>
    <h2>
      <%= @message %>
      It's <%= @time %>
    </h2>
    <h2>
      <%= for n <- 1..10 do %>
      <a href="#" phx-click="guess" phx-value-number= {n}> <%= n %> </a>
      <% end %>
    </h2>
    """
  end

  def handle_event("guess", %{"number" => guess}=data, socket) do
    message = "Your guess: #{guess}. Wrong! Guess aggin."
    score = socket.assigns.score + 1
    now_time = time()
    {:noreply, assign(socket, message: message, score: score, time: now_time)}
  end


  defp time() do
    DateTime.utc_now |> to_string
  end
end
