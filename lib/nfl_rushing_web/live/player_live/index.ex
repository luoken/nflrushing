defmodule NflRushingWeb.PlayerLive.Index do
  use NflRushingWeb, :live_view

  alias NflRushing.Table
  alias NflRushing.Table.Player

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, :players, list_players())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "The Score")
    |> assign(:player, nil)
  end

  @impl true
  def handle_event("search", %{"search" => %{"search_phrase" => search}}, socket) do
    {:noreply, assign(socket, :players, filter_players(search))}
  end

  @impl true
  def handle_event("sort", %{"lng_distance_desc" => field}, socket) do
    {:noreply, assign(socket, :players, sort_players(field, socket))}
  end

  @impl true
  def handle_event("sort", %{"yds_desc" => field}, socket) do
    {:noreply, assign(socket, :players, sort_players(field, socket))}
  end

  @impl true
  def handle_event("sort", %{"td_desc" => field}, socket) do
    {:noreply, assign(socket, :players, sort_players(field, socket))}
  end

  @impl true
  def handle_event("sort", %{"lng_distance" => field}, socket) do
    {:noreply, assign(socket, :players, sort_players(field, socket))}
  end

  @impl true
  def handle_event("sort", %{"yds" => field}, socket) do
    {:noreply, assign(socket, :players, sort_players(field, socket))}
  end

  @impl true
  def handle_event("sort", %{"td" => field}, socket) do
    {:noreply, assign(socket, :players, sort_players(field, socket))}
  end

  @impl true
  def handle_event("save", _, %{assigns: %{players: players}} = socket) do
    save(players)
    {:noreply, assign(socket, :players, players)}
  end

  @impl true
  def handle_event("reset", _, socket) do
    {:noreply, assign(socket, :players, list_players())}
  end

  defp list_players do
    Table.list_players()
  end

  defp sort_players(field, socket)
       when field in ["yds", "yds_desc", "lng_distance", "lng_distance_desc", "td", "td_desc"] do
    case String.contains?(field, "_desc") do
      true ->
        String.trim(field, "_desc")
        |> String.to_atom()
        |> Table.sort_players(socket, :desc)

      false ->
        String.to_atom(field)
        |> Table.sort_players(socket, :asc)
    end
  end

  defp filter_players(filter) do
    Table.filter_players(filter)
  end

  defp save(players) do
    file_name = "./players.json"
    {:ok, file} = File.open(file_name, [:write])

    IO.binwrite(file, "[")

    encoded_players =
      Enum.map(players, fn player ->
        player
        |> Map.from_struct()
        |> Map.drop([:__meta__, :inserted_at, :lng_distance, :"lng/t", :updated_at, :id])
        |> Jason.encode!()
      end)
      |> Enum.join(",")

    IO.binwrite(file, encoded_players)
    IO.binwrite(file, "]")

    File.close(file)

    players
  end
end
