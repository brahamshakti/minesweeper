require_relative "./box"

class Row

	def initialize(x,y,z)
		@x = Box.new(x)
		@y = Box.new(y)
		@z = Box.new(z)
	end

	def box(index)
		boxes[index.to_i]
	end

	def boxes
		[@x, @y, @z]
	end
end