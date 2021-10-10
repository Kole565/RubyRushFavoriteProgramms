require "rspec"

require_relative "../lib/link.rb"

describe "Link" do
	
	it "should be CLASS" do
		
		expect(
			Link.new(:link => "some_link_text").class.name
		).to eq("Link")

	end

	it "should create WITH_NIL_SPECIAL_ARGS" do
		
		expect{
			Link.new(:link => "some_link_text")
		}.not_to raise_error

	end

	it "should create WITH_FULL_ARGS" do
		
		expect{
			Link.new(:link => "some_link_text", :text => "That's a test!")
		}.not_to raise_error

	end

	it "should get BASE_ARGS" do

		test_item = Link.new(:link => "some_link_text")

		expect(
			test_item.link
		).to eq("some_link_text")

	end

	it "should get FULL_ARGS" do

		test_item = Link.new(:link => "some_link_text", :text => "That's a test!")

		expect(
			test_item.link
		).to eq("some_link_text")

		expect(
			test_item.text
		).to eq("That's a test!")

	end

	it "should raise MISSED_ARG_EXCEPTION" do
		
		expect{
			test_item = Link.new()
		}.to raise_error("Argument :link is missed. If you don't want to save link use Memo class.")

	end

end