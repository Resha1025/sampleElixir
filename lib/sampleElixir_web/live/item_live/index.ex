defmodule SampleElixirWeb.ItemLive.Index do
  use SampleElixirWeb, :live_view

  alias SampleElixir.Items
  alias SampleElixir.Items.Item

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Items.subscibe()

    {:ok, stream(socket, :items, Items.list_items())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Item")
    |> assign(:item, Items.get_item!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Item")
    |> assign(:item, %Item{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Items")
    |> assign(:item, nil)
  end

  @impl true
  def handle_info({SampleElixirWeb.ItemLive.FormComponent, {:saved, item}}, socket) do
    {:noreply, stream_insert(socket, :items, item)}
  end

  @impl true
  def handle_info({:item_created, item}, socket) do
    {:noreply, update(socket, :items, fn items -> [item | items] end)}

  end

  def handle_info({:item_updated, item}, socket) do
    {:noreply, update(socket, :items, fn items -> [item | items] end)}

  end

  def handle_info({:item_deleted, item}, socket) do
    {:noreply, update(socket, :items, fn items -> [item | items] end)}

  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    item = Items.get_item!(id)
    {:ok, _} = Items.delete_item(item)

    {:noreply, stream_delete(socket, :items, item)}
  end
end
