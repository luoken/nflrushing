defmodule NflRushing.TableTest do
  use NflRushing.DataCase

  alias NflRushing.Table

  describe "players" do
    alias NflRushing.Table.Player

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def player_fixture(attrs \\ %{}) do
      {:ok, player} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Table.create_player()

      player
    end

    test "list_players/0 returns all players" do
      player = player_fixture()
      assert Table.list_players() == [player]
    end

    test "get_player!/1 returns the player with given id" do
      player = player_fixture()
      assert Table.get_player!(player.id) == player
    end

    test "create_player/1 with valid data creates a player" do
      assert {:ok, %Player{} = player} = Table.create_player(@valid_attrs)
    end

    test "create_player/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Table.create_player(@invalid_attrs)
    end

    test "update_player/2 with valid data updates the player" do
      player = player_fixture()
      assert {:ok, %Player{} = player} = Table.update_player(player, @update_attrs)
    end

    test "update_player/2 with invalid data returns error changeset" do
      player = player_fixture()
      assert {:error, %Ecto.Changeset{}} = Table.update_player(player, @invalid_attrs)
      assert player == Table.get_player!(player.id)
    end

    test "delete_player/1 deletes the player" do
      player = player_fixture()
      assert {:ok, %Player{}} = Table.delete_player(player)
      assert_raise Ecto.NoResultsError, fn -> Table.get_player!(player.id) end
    end

    test "change_player/1 returns a player changeset" do
      player = player_fixture()
      assert %Ecto.Changeset{} = Table.change_player(player)
    end
  end
end
