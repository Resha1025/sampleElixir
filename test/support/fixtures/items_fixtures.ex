defmodule SampleElixir.ItemsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SampleElixir.Items` context.
  """

  @doc """
  Generate a item.
  """
  def item_fixture(attrs \\ %{}) do
    {:ok, item} =
      attrs
      |> Enum.into(%{
        item_code: "some item_code",
        item_description: "some item_description",
        item_name: "some item_name",
        price: "120.5"
      })
      |> SampleElixir.Items.create_item()

    item
  end
end
