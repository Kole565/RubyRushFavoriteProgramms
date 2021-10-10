require "sqlite3"

require_relative "../data/get_db_type.rb"

def db_open(options = {})

	current_dir = File.dirname(__FILE__)
	path = "#{current_dir}/../data/#{options[:db_type]}/tests/#{options[:db_name]}.#{get_db_type(options[:db_type])}"
	
	raise "#{options[:db_type]} #{options[:db_name]} database not found" unless File.exist?(path)
	db = SQLite3::Database.open(path)

end

def db_find(options = {})

	if options[:db_type].nil? || options[:db_name].nil?
		exc_msg = "Missing args in db_find: "
		
		exc_msg += ":db_type " if options[:db_type].nil?
		exc_msg += ":db_name " if options[:db_name].nil?

		raise exc_msg
	end
	
	
	db = db_open(options)

	stm = prepare_stm(db, options)

	result = stm.execute!

	stm.close
	db.close

	result
end

def prepare_stm(db, options)	
	
	request = "SELECT rowid, * FROM #{options[:table]} "

	request += "WHERE Type = '#{options[:type]}'; " if options[:filter] == "type"
	request += "WHERE #{options[:colomn]} = '#{options[:value]}'; " if options[:filter] == "value"
	request += "LIMIT #{options[:limit]}; " if !options[:limit].nil?

	request += "ORDER BY rowid DESC "
	
	
	stm = db.prepare(request) if !request.nil?

	stm if !stm.nil?
	
end