defmodule SampleElixir.Items.Item do
  use Ecto.Schema
  import Ecto.Changeset

  schema "items" do
    field :item_code, :string
    field :item_name, :string
    field :item_description, :string
    field :price, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(item, attrs) do
    item
    |> cast(attrs, [:item_code, :item_name, :item_description, :price])
    |> validate_required([:item_code, :item_name, :item_description, :price])
  end
end
