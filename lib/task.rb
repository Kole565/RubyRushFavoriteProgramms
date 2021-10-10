require "date"

require_relative "post.rb"

class Task < Post
	# Unstatic class representing task with due time

	def initialize(init_args = {})
		init_args[:text] = "" if init_args[:text].nil?

		super(init_args[:text], init_args[:time])

		raise "Argument :due_time is missed. If you don't want task behaviour use Memo class." if init_args[:due_time].nil? 
		
		if init_args[:due_time].class.name == "String"
			begin
				Date.strptime(init_args[:due_time], "%d.%m.%Y")
			rescue ArgumentError
				raise "Time #{init_args[:due_time]} are invalid"
			end
		end
		
		@due_time = init_args[:due_time]
	end

	def due_time
		@due_time
	end

	def to_a
		super + [due_time.to_s]
	end

end