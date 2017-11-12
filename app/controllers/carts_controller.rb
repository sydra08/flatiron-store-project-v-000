class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find_by(id: params[:id])
  end

  def checkout
    cart = Cart.find_by(id: params[:id])
    cart.checkout_cart
    current_user.update(current_cart: nil) #only make current_cart nil for user
    redirect_to cart_path(cart), notice: "Your order has been submitted"
  end
end
