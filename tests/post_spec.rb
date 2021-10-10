require "rspec"
require "time"

require_relative "../lib/post.rb"

describe "Post" do

	it "should be CLASS" do
		test_post = Post.new()

		expect(
			test_post.class.name
		).to eq("Post")
	end
	
	it "should INIT_NIL_ARGS" do

		test_post = Post.new()

		expect(
			test_post.text
		).to eq(nil)

		expect(
			test_post.time.class.name
		).to eq("Time")

	end

	it "should SET_GET_ARGS" do

		test_time = Time.now
		test_post = Post.new("Some text", test_time)

		expect(
			test_post.text
		).to eq("Some text")

		expect(
			test_post.time
		).to eq(test_time)

	end

end