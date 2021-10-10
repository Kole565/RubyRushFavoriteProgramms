require_relative "post.rb"

class Link < Post
	# Unstatic class representing link with description

	def initialize(init_args = {})
		init_args[:text] = "" if init_args[:text].nil?

		super(init_args[:text], init_args[:time])

		raise "Argument :link is missed. If you don't want to save link use Memo class." if init_args[:link].nil?
		@link = init_args[:link]
	end

	def link
		@link
	end

	def to_a
		super + [link]
	end

end