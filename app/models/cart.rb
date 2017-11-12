class Cart < ActiveRecord::Base
  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user
  belongs_to :current_cart

  def total
    self.line_items.each.sum { |l| l.item.price * l.quantity }
  end

  def add_item(item_id)
    lineitem = self.line_items.find_by(item_id: item_id)
    if lineitem # does the item already exist as a line_item in the cart?
      lineitem.quantity += 1 # find the matching line_item and increase quantity by 1
    else
      lineitem = self.line_items.build(item_id: item_id)
    end
    lineitem
  end

  def checkout_cart
    self.update_inventory
    self.update(status: "submitted")
  end

  def update_inventory
    self.line_items.each do |l|
      l.item.inventory -= l.quantity
      l.item.save
    end
  end

end
