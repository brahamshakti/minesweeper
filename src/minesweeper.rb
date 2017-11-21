require_relative './row'

class Minesweeper
	attr_reader :rows, :boxes_opened

	def initialize
		@rows = []
	end

	def add_rows(box_states)
		# x,y,z location state
		x,y,z = box_states.split('')
		@rows << Row.new(x,y,z)
	end

	def display
		layout_string = ''
		@rows.each do |row|
			layout_string << "#{box_statuses(row.boxes)}\n"
		end
		layout_string
	end

	def box_statuses(boxes)
		boxes.map{|box| box.box_state}.join('')
	end

	def all_boxes
		@rows.map{|row| row.boxes}.flatten
	end

	def boxes_opened?
		all_boxes.all? {|box| box.opened?}
	end

	def get_box(location)
		row, column = box_location(location)
		row = rows.find{|v| rows.index(v).to_s == row}
		row.box(column)
	end

	private

	def box_location(location)
		row_and_column = location.split(',')
		[row_and_column.first, row_and_column.last]
	end

end