defmodule SampleElixir.ItemsTest do
  use SampleElixir.DataCase

  alias SampleElixir.Items

  describe "items" do
    alias SampleElixir.Items.Item

    import SampleElixir.ItemsFixtures

    @invalid_attrs %{item_code: nil, item_name: nil, item_description: nil, price: nil}

    test "list_items/0 returns all items" do
      item = item_fixture()
      assert Items.list_items() == [item]
    end

    test "get_item!/1 returns the item with given id" do
      item = item_fixture()
      assert Items.get_item!(item.id) == item
    end

    test "create_item/1 with valid data creates a item" do
      valid_attrs = %{item_code: "some item_code", item_name: "some item_name", item_description: "some item_description", price: "120.5"}

      assert {:ok, %Item{} = item} = Items.create_item(valid_attrs)
      assert item.item_code == "some item_code"
      assert item.item_name == "some item_name"
      assert item.item_description == "some item_description"
      assert item.price == Decimal.new("120.5")
    end

    test "create_item/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Items.create_item(@invalid_attrs)
    end

    test "update_item/2 with valid data updates the item" do
      item = item_fixture()
      update_attrs = %{item_code: "some updated item_code", item_name: "some updated item_name", item_description: "some updated item_description", price: "456.7"}

      assert {:ok, %Item{} = item} = Items.update_item(item, update_attrs)
      assert item.item_code == "some updated item_code"
      assert item.item_name == "some updated item_name"
      assert item.item_description == "some updated item_description"
      assert item.price == Decimal.new("456.7")
    end

    test "update_item/2 with invalid data returns error changeset" do
      item = item_fixture()
      assert {:error, %Ecto.Changeset{}} = Items.update_item(item, @invalid_attrs)
      assert item == Items.get_item!(item.id)
    end

    test "delete_item/1 deletes the item" do
      item = item_fixture()
      assert {:ok, %Item{}} = Items.delete_item(item)
      assert_raise Ecto.NoResultsError, fn -> Items.get_item!(item.id) end
    end

    test "change_item/1 returns a item changeset" do
      item = item_fixture()
      assert %Ecto.Changeset{} = Items.change_item(item)
    end
  end
end
