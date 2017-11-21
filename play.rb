require_relative './src/minesweeper'
require_relative './src/operation/open_operation'
require_relative './src/operation/flag_operation'


class Play
	attr_reader :minesweeper

	VALID_OPTIONS = ["o", "f"]

	def initialize
		@minesweeper = Minesweeper.new
	end

	def initialize_minesweeper(layout_blueprints)
		blueprints = layout_blueprints.split(',')

		blueprints.each do |blueprint|
			minesweeper.add_rows(blueprint)
		end

		puts minesweeper.display
	end

	def execute(command)
		mode = operation_mode(command)
		location_point = get_location_point(command)
		exit unless VALID_OPTIONS.include?(mode)

		box = minesweeper.get_box(location_point)

		if mode == "o"
			success = OpenOperation.perform(box)
			unless success
				puts minesweeper.display
				puts "Oops! You stepped on a mine! Game over!"
				exit
			end
		else
			FlagOperation.perform(box)
		end
	end

	def operation_mode(command)
		command.split('').first
	end

	private

	def get_location_point(command)
		command.scan(/\(([^\)]+)\)/).last.join('') # "0,1"
	end

end


play = Play.new

puts "Enter the minefield layout: "

layout_blueprints = gets

# Initialize minesweeper class
play.initialize_minesweeper(layout_blueprints)


all_boxes_opened = play.minesweeper.boxes_opened?

#continue until all locations opened
while !all_boxes_opened
	puts "Enter option: "

	command  = gets

	play.execute(command)

	puts play.minesweeper.display

	all_boxes_opened = play.minesweeper.boxes_opened?
end

puts "Wow! You cleared the minefield! Game over!"
exit


