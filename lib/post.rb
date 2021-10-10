require "time"

class Post
	# Unstatic class representing parent of any note:
	# Text
	# Creation time (later - time)

	def initialize(text = nil, time = nil)
		@text = text
		@time = time

		@time = Time.now if time.nil?
	end

	def text
		@text
	end

	def time
		@time
	end

	def to_a
		[time.to_s, text]
	end

end