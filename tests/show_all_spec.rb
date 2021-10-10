require "rspec"

require_relative "../lib/show_all_methods.rb"

describe "show_all methods" do
	
	it "should return ALL_POSTS" do

		output = db_find(:db_type => "sql", :db_name => "testing", :table => "posts")

		expect(
			output.class.name
		).to eq("Array")

		expect(
			output.size
		).to be > 0
		
	end

	it "should return MEMO_ONLY" do
		
		output = db_find(:db_type => "sql", :db_name => "testing", :table => "posts", :filter => "type", :type => "Memo")

		expect(
			output.class.name
		).to eq("Array")

		expect(
			output.size
		).to be > 0

		for memo in output

			expect(
				memo[1]
			).to eq "Memo"

		end
		
	end

	it "should return LIMITED_POSTS" do

		output = db_find(:db_type => "sql", :db_name => "testing", :table => "posts", :limit => 10)

		expect(
			output.class.name
		).to eq("Array")

		expect(
			output.size
		).to be == 10
		
		
	end

	it "should raise DB_FILE_MISSED_EXCEPTION" do
		
		expect{
			db_find(:db_type => "sql", :db_name => "missing_db")
		}.to raise_error("sql missing_db database not found")

	end

	it "should raise DB_FIND_MISSING_ARGS_EXCEPTION" do
		
		expect{
			db_find()
		}.to raise_error("Missing args in db_find: :db_type :db_name ")

	end

end