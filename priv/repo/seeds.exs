# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     NflRushing.Repo.insert!(%NflRushing.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias NflRushing.Repo
alias NflRushing.Table.Player

with {:ok, list} <- File.read("./priv/rushing.json"),
     {:ok, list_of_players} <- Jason.decode(list) do
  Enum.map(list_of_players, fn player ->
    for {key, val} <- player, into: %{}, do: {String.to_atom(String.downcase(key)), val}
  end)
  |> Enum.each(fn player -> Repo.insert!(Player.changeset(%Player{}, player)) end)
end
