require "rspec"
require "sqlite3"

require_relative "../lib/dbinteractor.rb"
require_relative "../lib/memo.rb"
require_relative "../lib/link.rb"
require_relative "../lib/task.rb"

describe "DBInteractor" do

	it "should be CLASS" do
		
		db = DBInteractor.new()

		expect(
			db.class.name
		).to eq("DBInteractor")

	end
	
	it "should CREATE_SESSION_STORAGE" do
		
		db = DBInteractor.new()

		expect(
			db.storage
		).to eq([])

	end

	it "should ADD_POST_TO_STORAGE" do
		
		dbi = DBInteractor.new()
		test_memo = Memo.new(:text => "Text")
		
		expect(
			dbi.storage_add(test_memo)
		).to eq(0)

		expect(
			dbi.storage
		).to eq([test_memo])

	end

	it "should GET_POST_FROM_STORAGE" do
		
		dbi = DBInteractor.new()
		test_memo = Memo.new(:text => "Text")
		
		expect(
			dbi.storage_add(test_memo)
		).to eq(0)

		expect(
			dbi.storage_get(0)
		).to eq(test_memo)

		expect(
			dbi.storage_get(1)
		).to eq("Item by this index don't exist")

		expect(
			dbi.storage_get(-1)
		).to eq("Item by this index don't exist")

	end

	it "should CLEAR_LOCAL_STORAGE" do
		
		dbi = DBInteractor.new()
		test_memo = Memo.new(:text => "Text")

		dbi.storage_add(test_memo)
		dbi.storage_clear
		
		expect(
			dbi.storage
		).to eq([])

	end

	it "should CREATE_SQL_DB" do
		
		sql_db = DBInteractor.create_sql_db("testing")

		expect(
			sql_db.class.name
		).to eq("SQLite3::Database")

		sql_db.close
	end

	it "should SET_SQL_TABLE" do
		
		dbi = DBInteractor.new()
		sql_db = dbi.open_sql_db(:type => "sql", :name => "testing")

		expect(
			sql_db.class.name
		).to eq("SQLite3::Database")
		
		dbi.set_sql_table(sql_db)

		sql_db.close
	end

	it "should PUSH_PULL_SQL_MEMO" do
		
		dbi = DBInteractor.new()
		test_item = Memo.new(:text => "Text")

		dbi.storage_add(test_item)

		expect(
			dbi.push(:type => "sql", :name => "testing", :data => dbi.storage).closed?
			# Type = sql => path = data/sql/db_name.sql
		).to eq(true)

		dbi.storage_clear
		
		expect(
			dbi.pull(:type => "sql", :name => "testing")
		).to eq(0)

		expect(
			dbi.storage_get(0)
		).to eq({:class => "Memo", :item => test_item.to_a})

	end

	it "should PUSH_PULL_SQL_LINK" do
		DBInteractor.create_sql_db("testing_link")
		dbi = DBInteractor.new()
		
		sql_db = dbi.open_sql_db(:type => "sql", :name => "testing_link")
				
		dbi.set_sql_table(sql_db)

		sql_db.close
		

		test_item = Link.new(:text => "Google search", :link => "https://www.google.com/")

		dbi.storage_add(test_item)

		expect(
			dbi.push(:type => "sql", :name => "testing_link", :data => dbi.storage).closed?
			# Type = sql => path = data/sql/db_name.sql
		).to eq(true)

		dbi.storage_clear
		
		expect(
			dbi.pull(:type => "sql", :name => "testing_link")
		).to eq(0)

		expect(
			dbi.storage_get(0)
		).to eq({:class => "Link", :item => test_item.to_a})

	end

	it "should PUSH_PULL_SQL_TASK" do
		DBInteractor.create_sql_db("testing_task")
		dbi = DBInteractor.new()
		
		sql_db = dbi.open_sql_db(:type => "sql", :name => "testing_task")
				
		dbi.set_sql_table(sql_db)

		sql_db.close
		

		test_item = Task.new(:text => "Do Stuff", :due_time => Time.now + (3600 * 24))

		dbi.storage_add(test_item)

		expect(
			dbi.push(:type => "sql", :name => "testing_task", :data => dbi.storage).closed?
			# Type = sql => path = data/sql/db_name.sql
		).to eq(true)

		dbi.storage_clear
		
		expect(
			dbi.pull(:type => "sql", :name => "testing_task")
		).to eq(0)

		expect(
			dbi.storage_get(0)
		).to eq({:class => "Task", :item => test_item.to_a})

	end

end