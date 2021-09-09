defmodule NflRushingWeb.PlayerLive.TableComponent do
  use NflRushingWeb, :live_component

  def render(assigns) do
    ~L"""
    <table>
      <thead>
        <tr>
          <th>Player</th>
          <th>Team</th>
          <th>Pos</th>
          <th>Att</th>
          <th>Att/G</th>
          <th>Yds</th>
          <th>Avg</th>
          <th>Yds/G</th>
          <th>TD</th>
          <th>Lng</th>
          <th>1st</th>
          <th>1st%</th>
          <th>20+</th>
          <th>40+</th>
          <th>FUM</th>
        </tr>
      </thead>
    <tbody id="players">
      <%= for player <- @players do %>

        <tr id="player-<%= player.id %>">
          <td>
           <span> <%= player.player %> </span>
          </td>
          <td>
            <span> <%= player.team %> </span>
          </td>
          <td>
            <span> <%= player.pos %> </span>
          </td>
          <td>
            <span> <%= player.att %> </span>
          </td>
          <td>
            <span> <%= player."att/g" %> </span>
          </td>
          <td>
            <span> <%= player.yds %> </span>
          </td>
          <td>
            <span> <%= player.avg %> </span>
           </td>
          <td>
            <span> <%= player."yds/g" %> </span>
          </td>
          <td>
            <span> <%= player.td %> </span>
          </td>
          <td>
            <span> <%= player.lng %> </span>
          </td>
          <td>
            <span> <%= player."1st" %> </span>
          </td>
          <td>
            <span> <%= player."1st%" %> </span>
          </td>
          <td>
            <span> <%= player."20+" %> </span>
         </td>
          <td>
            <span> <%= player."40+" %> </span>
          </td>
          <td>
            <span> <%= player.fum %> </span>
          </td>
        </tr>
      <% end %>
    </tbody>
    </table>
    """
  end
end
