class CartController < ApplicationController

	before_filter :authenticate_user!, except: [:add_to_cart, :view_order]

  def add_to_cart
  	product = Product.find(params[:product_id])

		if product.quantity < params[:quantity].to_i
			redirect_to product, notice: "Sorry, only #{product.quantity} left in stock."
		elsif params[:quantity].to_i <= 0
			redirect_to product, notice: "Sorry, this is the euclidean universe... you may be looking for the sass-backwards-verse in the dimension to your left."
		else
			line_item = LineItem.create(product_id: params[:product_id], quantity: params[:quantity])

			line_item.line_item_total = line_item.quantity * line_item.product.price
			line_item.save

			redirect_to root_path
		end
  end

  def remove_from_cart
  	LineItem.find(params[:id]).destroy
  	redirect_to :back
  end

  def view_order
  	@line_items = LineItem.all
  end

  def checkout
  	line_items = LineItem.all 
  	@order = Order.create(user_id: current_user.id)

  	@order.subtotal = 0

  	line_items.each do |line_item|
  		@order.subtotal += line_item.line_item_total
  		@order.order_items[line_item.product_id] = line_item.quantity
  	end

  	@order.sales_tax = @order.subtotal * 0.07
  	@order.grand_total = @order.subtotal + @order.sales_tax
  	@order.save

  	line_items.each do |line_item|
  		line_item.product.quantity -= line_item.quantity
  		line_item.product.save 
  	end

  	line_items.destroy_all
  end

end
