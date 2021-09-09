defmodule NflRushingWeb.PlayerLive.SortComponent do
  use NflRushingWeb, :live_component

  def render(assigns) do
    ~L"""
      <% top = "yds" %>
      <form phx-change="sort">
      <select name="<%= top %>">
        <%= for {key, value} <- ["Total Rushing Yards": "yds", "Total Rushing Yards (desc)": "yds_desc", "Longest Rush": "lng_distance", "Longest Rush (desc)": "lng_distance_desc", "Total Rushing Touchdowns": "td", "Total Rushing Touchdowns (desc)": "td_desc"] do %>

          <option value="<%= value %>" phx-change="sort"  <%= (selected?(top, value)) %> ><%= key %>
        <% end %>
      </select>
    </form>
    """
  end

  def selected?(top, key) do
    case top === key do
      true -> "selected"
      false -> ""
    end
  end
end
