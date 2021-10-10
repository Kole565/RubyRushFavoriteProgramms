require "rspec"

require_relative "../lib/show_all_methods.rb"
require_relative "../lib/add_post_methods.rb"

describe "add_post methods" do
	
	it "should ADD_MIN_POST" do
		
		expect(
			add_post(:optparse => {:type => "Memo",	:text => "Add post testing"}, :type => "sql", :name => "add_post_testing")
		).to eq(0)

	end

	it "should ADD_FULL_POST" do
		
		expect(
			add_post(:optparse => {:type => "Link",	:text => "Great searcher", :link => "https://www.google.com"}, :type => "sql", :name => "add_post_testing")
		).to eq(0)

		expect(
			db_find(:db_type => "sql", :db_name => "add_post_testing", :table => "posts", :filter => "value", :colomn => "Text", :value => "Great searcher")[0][5]
		).to eq("https://www.google.com")

	end

	it "should raise INVALID_TIME_EXCEPTION" do

		expect{
			add_post(:optparse => {:type => "Task",	:text => "TASK", :due_time => "07.13.2021"}, :type => "sql", :name => "add_post_testing")
		}.to raise_error("Time 07.13.2021 are invalid")

	end
	
end