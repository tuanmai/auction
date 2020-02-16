defmodule AuctionTest do
  use ExUnit.Case
  alias Auction.{Repo, Item}
  import Ecto.Query
  doctest Auction

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "list_items/0" do
    setup do
      {:ok, item_1} = Repo.insert(%Item{title: "Title 1"})
      {:ok, item_2} = Repo.insert(%Item{title: "Title 2"})
      {:ok, item_3} = Repo.insert(%Item{title: "Title 3"})
      %{items: [item_1, item_2, item_3]}
    end

    test "returns all items in database", %{items: items} do
      assert items == Auction.list_items
    end 
  end

  describe "get_item/1" do
    setup do
      {:ok, item_1} = Repo.insert(%Item{title: "Title 1"})
      {:ok, item_2} = Repo.insert(%Item{title: "Title 2"})
      %{items: [item_1, item_2]}
    end

    test "returns item with id", %{items: items} do
      item = items |> Enum.at(1)
      assert item == Auction.get_item(item.id)
    end
  end

  describe "insert_item/1" do
    test "adds item to database" do
      query_count = from i in Item, select: count(i.id)
      before_count = Repo.one(query_count)
      Auction.insert_item(%{title: "Test item"})
      assert Repo.one(query_count) == before_count + 1
    end

    test "adds item into database with correct data" do
      attrs = %{title: "Test title", description: "bla bla"}
      {:ok, item} = Auction.insert_item(attrs)
      assert item.title == attrs.title
      assert item.description == attrs.description
    end

    test "returns error when wrong data" do
      {:error, _changeset} = Auction.insert_item(%{foo: "bar"})
    end
  end
end
