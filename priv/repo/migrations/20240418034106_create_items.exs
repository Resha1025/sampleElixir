defmodule SampleElixir.Repo.Migrations.CreateItems do
  use Ecto.Migration

  def change do
    create table(:items) do
      add :item_code, :string
      add :item_name, :string
      add :item_description, :string
      add :price, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
