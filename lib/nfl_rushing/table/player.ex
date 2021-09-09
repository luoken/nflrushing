defmodule NflRushing.Table.Player do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :integer, autogenerate: false}
  schema "players" do
    field :player, :string
    field :"1st", :integer
    field :"1st%", :float
    field :"20+", :integer
    field :"40+", :integer
    field :"att/g", :float
    field :att, :integer
    field :avg, :float
    field :fum, :integer
    field :lng, :string
    field :lng_distance, :integer
    field :"lng/t", :string, default: ""
    field :pos, :string
    field :td, :integer
    field :team, :string
    field :yds, :float
    field :"yds/g", :float

    timestamps()
  end

  @doc false
  def changeset(player, attrs) do
    attrs = sanitize(attrs)

    player
    |> cast(attrs, [
      :player,
      :team,
      :pos,
      :att,
      :"att/g",
      :yds,
      :avg,
      :"yds/g",
      :td,
      :lng,
      :"lng/t",
      :lng_distance,
      :"1st",
      :"1st%",
      :"20+",
      :"40+",
      :fum
    ])
    |> validate_required([
      :player,
      :team,
      :pos,
      :att,
      :"att/g",
      :yds,
      :avg,
      :"yds/g",
      :td,
      :lng,
      :"1st",
      :"1st%",
      :"20+",
      :"40+",
      :fum
    ])
  end

  def sanitize(changes) do
    changes
    |> Enum.reduce(%{}, fn
      {:lng, value}, acc ->
        handle_lng(acc, value)

      {:yds, value}, acc when is_binary(value) ->
        Map.put(acc, :yds, String.to_integer(remove_commas(value)))

      {key, value}, acc ->
        Map.put(acc, key, value)
    end)
  end

  defp remove_commas(value) do
    String.replace(value, ",", "")
  end

  defp handle_lng(acc, value) when is_binary(value) do
    case String.contains?(value, "T") do
      true ->
        Map.put(acc, :"lng/t", "T")
        |> Map.put(:lng_distance, String.to_integer(remove_t(value)))
        |> Map.put(:lng, value)

      false ->
        Map.put(acc, :lng, value)
        |> Map.put(:lng_distance, String.to_integer(value))
    end
  end

  defp handle_lng(acc, value) when is_integer(value) do
    Map.put(acc, :lng, Integer.to_string(value))
    |> Map.put(:lng_distance, value)
  end

  defp remove_t(string) do
    String.replace(string, "T", "")
  end
end
