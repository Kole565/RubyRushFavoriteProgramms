require_relative "post.rb"

class Memo < Post
	# Unstatic class representing text with additions:
	# Data in array (author, other)

	def initialize(init_args = {})
		super(init_args[:text], init_args[:time])
		
		@author = "anonymous"
		@author = init_args[:author] if !init_args[:author].nil?
		
		raise "Invalid value: :author => #{init_args[:author]}" if @author.class.name != "String"
	end

	def author(capitalize = false)
		return @author if !capitalize
		return @author.capitalize if capitalize
	end

	def to_a
		super + [author]
	end

end