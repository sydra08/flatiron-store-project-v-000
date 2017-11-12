class LineItemsController < ApplicationController
  before_action :authenticate_user!

  def create
    current_user.set_current_cart if !current_user.current_cart
    line_item = current_user.current_cart.add_item(params[:item_id])
    # need to do current_user.current_cart for when you're not creating a new one
    if line_item.save
      redirect_to cart_path(current_user.current_cart), notice: "Successfully added to your cart"
    else
      redirect_to store_path, notice: "Your item could not be added"
    end
  end
end
