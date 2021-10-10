# Start interactive session

require_relative "../lib/add_post_methods.rb"

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

puts "What a item type? (Memo, Link, Task etc.)"

while data[:post_type] == ""
	data[:post_type] = STDIN.gets.encode("UTF-8").chomp
end

puts "What's a text?"

while data[:text] == ""
	data[:text] = STDIN.gets.encode("UTF-8").chomp
end

case data[:post_type].capitalize
when "Memo"
	puts "Who is author?"

	while data[:author] == ""
		data[:author] = STDIN.gets.encode("UTF-8").chomp
	end

when "Link"
	puts "What's a link?"

	while data[:link] == ""
		data[:link] = STDIN.gets.encode("UTF-8").chomp
	end

when "Task"
	puts "What's a due_time? (in 20.05.2012 format)"

	while data[:due_time] == ""
		data[:due_time] = STDIN.gets.encode("UTF-8").chomp
	end
end

puts data
add_post(:optparse => {:type => data[:post_type],:text => data[:text], :author => data[:author], :link => data[:author], :due_time => data[:due_time]}, :type => data[:type],	:name => data[:name], :table => data[:table])

puts "Post saved"