class Box
	attr_accessor :state, :mine

	FLAG	= "f"
	OPEN	= "o"
	MINE    = "m"

	def initialize(state)
		@mine = true if state == MINE
		@state = state
		@is_closed = true
	end

	def box_state
		return "x" if @is_closed
		@state
	end

	def has_mine?
		return true if mine
	end

	def perform(operation)
		@is_closed = false
		operation.eql?(FLAG) ? add_flag : open_mine
	end

	def add_flag
		@state = FLAG
	end

	def open_mine
		has_mine? ? @state = MINE : @state = OPEN
		@state != MINE
	end

	def opened?
		if has_mine?
			@state == FLAG
		else
			@state == OPEN && @state != FLAG
		end
	end

end