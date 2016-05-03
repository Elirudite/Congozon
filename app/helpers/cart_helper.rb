module CartHelper

	def quantity_check?(product, quantity)
		if product.quantity < quantity
			redirect_to product, notice: "Sorry, only #{product.quantity} left in stock."
			return true
		elsif quantity <= 0
			redirect_to product, notice: "Sorry, this is the euclidean universe... you may be looking for the sass-backwards-verse in the dimension to your left."
			return true
		else
			return false
		end
	end

end
