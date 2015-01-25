class CombineItemsInCart < ActiveRecord::Migration
  def up
		Cart.all.each do |cart|
			sums = cart.line_items.group(:product_id).sum(:quantity)
			sums.each do |product_id, quantity|
				if quantity > 1
						cart.line_items.where(product_id: product_id).delete_all
						item = cart.line_items.build(product_id: product_id)
						item.quantity = quantity
						item.save!	
				end
 			end
  	end
  end

	def down
		Cart.all.each do |cart|
			cart.line_items.each do |item|
				if item.quantity > 1
					item.quantity.times do
						new_item = cart.line_items.build(product_id: item.product_id, cart_id: cart.id, quantity: 1)
						new_item.save!
					end
					item.delete
				end
			end
		end
	end

end
