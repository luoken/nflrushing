defmodule NflRushing.Repo.Migrations.CreatePlayers do
  use Ecto.Migration

  def change do
    create table(:players) do
      add :player, :string
      add :team, :string
      add :pos, :string
      add :att, :integer
      add :"att/g", :float
      add :yds, :float
      add :avg, :float
      add :"yds/g", :float
      add :td, :integer
      add :lng, :string
      add :"lng/t", :string
      add :lng_distance, :integer
      add :"1st", :integer
      add :"1st%", :float
      add :"20+", :integer
      add :"40+", :integer
      add :fum, :integer
      timestamps()
    end
  end
end
