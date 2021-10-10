require "rspec"

require_relative "../lib/task.rb"

describe "Task" do
	
	it "should be CLASS" do
		
		expect(
			Task.new(:due_time => Time.now + 3600).class.name
		).to eq("Task")

	end

	it "should create WITH_NIL_SPECIAL_ARGS" do
		
		expect{
			Task.new(:due_time => Time.now)
		}.not_to raise_error

	end

	it "should create WITH_FULL_ARGS" do
		
		expect{
			Task.new(:due_time => Time.now + 3600, :text => "Task description - name")
		}.not_to raise_error

	end

	it "should return DUE_TIME" do

		current_time = Time.now
		test_item = Task.new(:due_time => current_time + 3600)

		expect(
			test_item.due_time
		).to eq(current_time + 3600)

	end

	it "should raise MISSED_ARG_EXCEPTION" do
		
		expect{
			Task.new()
		}.to raise_error("Argument :due_time is missed. If you don't want task behaviour use Memo class.")

	end

	it "should return ARRAY_TO_A" do

		expect(
			Task.new(:due_time => Time.now + 3600).to_a.class.name
		).to eq("Array")

	end


end