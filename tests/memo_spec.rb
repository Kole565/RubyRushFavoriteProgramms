require "rspec"
require "time"

require_relative "../lib/memo.rb"

describe "Memo" do

	it "should be CLASS" do
		test_memo = Memo.new()

		expect(
			test_memo.class.name
		).to eq("Memo")
	end
	
	it "should INIT_NIL_ARGS" do
		
		test_memo = Memo.new()

		expect(
			test_memo.text
		).to eq(nil)

		expect(
			test_memo.author
		).to eq("anonymous")

	end

	it "should SET_GET_BASE_ARGS" do
		
		test_memo = Memo.new(:author => "Some_name_404")

		expect(
			test_memo.text
		).to eq(nil)

		expect(
			test_memo.author
		).to eq("Some_name_404")

	end

	it "should SET_GET_PARENT_ARGS" do
		
		test_time = Time.now
		test_memo = Memo.new(
			:text => "Memories", :author => "Some_name_404", :time => test_time
		)

		expect(
			test_memo.time
		).to eq(test_time)

		expect(
			test_memo.text
		).to eq("Memories")

		expect(
			test_memo.author
		).to eq("Some_name_404")

	end

	it "should GET_CAPITALIZE_AUTHOR" do

		test_memo = Memo.new()

		expect(
			test_memo.author(true)
		).to eq("Anonymous")

	end

	it "should raise INVALID_INIT_ARGS" do
		
		test_not_used_args_memo = Memo.new(:some_left_arg => "Some value")

		expect{
			test_invalid_args_memo = Memo.new(:author => [1, 2, 3])
		}.to raise_error("Invalid value: :author => [1, 2, 3]")


	end

end