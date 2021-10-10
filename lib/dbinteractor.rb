require "sqlite3"

class DBInteractor

	@@db_formats = {
		"sql" => "sqlite3"
	}
		
	def initialize()
		storage_clear
	end

	def storage
		@session_storage
	end

	def storage_add(item)
		@session_storage << item

		return 0
	end

	def storage_get(index = nil)
		
		if index.nil?
			return storage
		end

		return "Item by this index don't exist" if index < 0 || index > storage.size - 1
		@session_storage[index]
	end

	def storage_clear
		@session_storage = []
	end

	# def add_item(args = {})
	# 	return "Item missing" if args[:item].nil?

	# 	item = {}

	# 	item[:class] = args[:item].class.name
	# 	item[:item] = args[:item]

	# 	storage_add(item)

	# 	return "Success"
	# end
	
	def push(options = {})
		# Push @session_storage to db
		db_file_path = db_path(options[:type], options[:name], @@db_formats[options[:type]])

		return "Nothing to push" if storage.size == 0
		return "DB file by #{db_file_path} not exist. Create first" unless File.exist?(db_file_path)
		
		sql_db = open_sql_db(options)
		
		for item in storage
			insert_sql_item(item, sql_db)
		end

		sql_db.close
	end
	
	def pull(options = {})
		# Get data from db, load to local storage
		# Sql mode now
		db_file_path = db_path(options[:type], options[:name], @@db_formats[options[:type]])

		return "DB file by #{db_file_path} not exist. Create first" unless File.exist?(db_file_path)
		
		sql_db = open_sql_db(options)

		data = DBInteractor.get_sql_rows(sql_db)

		sql_db.close

		fill_local_storage(data)
		
		return 0
	end

	def open_sql_db(options = {})
		db_file_path = db_path(options[:type], options[:name], @@db_formats[options[:type]])

		SQLite3::Database.open(db_file_path)
	end

	def db_path(db_type, file_name, file_type)
		current_dir = File.dirname(__FILE__)
		
		path = "#{current_dir}/../data/#{db_type}/tests/#{file_name}.#{file_type}"

		raise "Path #{path} not exist" unless File.exist?(path)
		path
	end

	def self.create_sql_db(file_name)
		current_dir = File.dirname(__FILE__)

		path = "#{current_dir}/../data/sql/tests/#{file_name}.sqlite3"

		db = SQLite3::Database.new(path)
	end

	def set_sql_table(db, table_name = "Posts")
		sql_create_table = 
		"
		CREATE TABLE IF NOT EXISTS #{table_name} (
			Type text,
			CreationTime datetime,
			Text text,
			Author text,
			Link text,
			DueTime datetime
		);
		"
		
		db.execute(sql_create_table)
	end

	def insert_sql_item(item, db, table_name = "Posts")
		class_name = item.class.name
		post_exem = item

		author = ""
		author = post_exem.author if post_exem.respond_to? "author"

		link = ""
		link = post_exem.link if post_exem.respond_to? "link"

		due_time = ""
		due_time = post_exem.due_time if post_exem.respond_to? "due_time"
		
		stm = db.prepare "
			INSERT INTO #{table_name} (Type, CreationTime, Text, Author, Link, DueTime)
			VALUES (?, ?, ?, ?, ?, ?)
		"
		
		stm.bind_params class_name, post_exem.time.to_s, post_exem.text, author, link, due_time.to_s
		stm.execute!

		stm.close

		"Success"
	end

	def self.get_sql_rows(db, table_name = "Posts")
		
		begin
			query = "SELECT rowid, * FROM posts "
			query += "ORDER by rowid DESC "

			stm = db.prepare query

			result = stm.execute!

			stm.close

			return result

		rescue SQLite3::SQLException => exception
			puts "Table #{exception.message.split(" ")[-1]} not found"
		end
	end

	def fill_local_storage(data)
		# Fill session storage data values
		
		for row in data
			item_ar = row[2..]
			item_ar.delete ""
			
			storage_add({:class => row[1], :item => item_ar})
		end
	end

end