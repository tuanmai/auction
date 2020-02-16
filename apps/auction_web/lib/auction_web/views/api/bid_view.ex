defmodule AuctionWeb.Api.BidView do
  use AuctionWeb, :view

  def render("bid.json", %{bid: bid}) do
    %{
      type: "bid",
      id: bid.id,
      amount: bid.amount
    }
  end

  def render("bid_with_user.json", %{bid: bid}) do
    %{
      type: "bid",
      id: bid.id,
      amount: bid.amount,
      user: render_one(bid.user, AuctionWeb.Api.UserView, "user.json")
    }
  end
end
