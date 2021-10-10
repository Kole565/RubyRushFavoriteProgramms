# Add post(s) to db
require "optparse"

require_relative "../lib/add_post_methods.rb"

options = {}

OptionParser.new do | opts |

	opts.banner = "Usage add_post script"

	opts.on("-h", "--help", "Show help") do
		puts opts
		exit
	end

	# opts.on("--example", "Show example from 'testing' db") do
	# 	options[:example] = true
	# end

	opts.on("-i", "--interactive", "Star interactive session") do
		options[:interactive] = true
	end

	opts.separator "-" * 90

	opts.on("--db_type=TYPE", String, "What type of db to open (only sql now)") do | type |
		options[:db_type] = type
	end

	opts.on("--db_name", "What db file name without extension") do | name |
		options[:db_name] = name
	end

	opts.separator "-" * 90

	opts.on("--table", "Table name in db (if sql)") do | table |
		options[:table] = table
	end
	
	opts.on("--filter", "Filter by name, value or all") do | filter |
		options[:filter] = filter
	end

	opts.on("--type", "Watch '--filter' with type") do | type |
		options[:type] = type
	end

	opts.on("--colomn", "Watch '--filter' with value") do | colomn |
		options[:colomn] = colomn
	end

	opts.on("--value", "Watch '--filter' with value") do | value |
		options[:value] = value
	end

	opts.separator "-" * 90

end.parse!

puts options

# if options[:example]
# 	output = db_find(:db_type => "sql", :db_name => "testing", :table => "posts")

# 	puts output
# 	exit
# end

if options[:interactive]

	
end