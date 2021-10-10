# Start interactive session

require_relative "../lib/show_all_methods.rb"

data = Hash.new("")

puts "Interactive sesssion begin. Enter 'exit' to quit"
puts "What a db type? (sql)"

puts "\t0. sql"

while data[:type] == ""
	data[:type] = STDIN.gets.encode("UTF-8").chomp.to_i
end

data[:type] = "sql" if data[:type] == 0


puts "What a db name? ('testing' for example)"

while data[:name] == ""
	data[:name] = STDIN.gets.encode("UTF-8").chomp
end

puts "What a table name? ('posts' for example)"

while data[:table] == ""
	data[:table] = STDIN.gets.encode("UTF-8").chomp
end

puts "What a filter?"

puts "\t0. All"
puts "\t1. Type"
puts "\t2. Colomn value"

while data[:filter] == ""
	data[:filter] = STDIN.gets.encode("UTF-8").chomp.to_i
end

data[:filter] = "all" if data[:filter] == 0
data[:filter] = "type" if data[:filter] == 1
data[:filter] = "value" if data[:filter] == 2

case data[:filter]
when "type"
	puts "What a type? (Memo, Link, Task etc.)"

	data[:post_type] = STDIN.gets.encode("UTF-8").chomp
when "value"
	puts "What a colomn name? (text, author, time etc.)"
	
	data[:colomn] = STDIN.gets.encode("UTF-8").chomp

	puts "What a search value?"
	
	data[:value] = STDIN.gets.encode("UTF-8").chomp
end

puts "What a limit?"

while data[:limit] == ""
	data[:limit] = STDIN.gets.encode("UTF-8").chomp.to_i
end

# puts data

case data[:filter]
when "type"
	output = db_find(
		:db_type => data[:type], :db_name => data[:name], :table => data[:table], 
		:filter => data[:filter], :type => data[:post_type], :limit => data[:limit]
	)
when "value"
	output = db_find(
		:db_type => data[:type], :db_name => data[:name], :table => data[:table], 
		:filter => data[:filter], :colomn => data[:colomn], :value => data[:value], :limit => data[:limit]
	)
else
	output = db_find(:db_type => data[:type], :db_name => data[:name], :table => data[:table], :limit => data[:limit])
end

puts output