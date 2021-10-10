# Get, return, print items from db
require "optparse"

require_relative "../lib/show_all_methods.rb"

options = {}

OptionParser.new do | opts |

	opts.banner = "Usage show_all script"

	opts.on("-h", "--help", "Show help") do
		puts opts
		exit
	end

	opts.on("--example", "Show example from 'testing' db") do
		options[:example] = true
	end

	opts.separator "-" * 90

	opts.on("--db_type=TYPE", String, "What type of db to open (only sql now)") do | type |
		options[:db_type] = type
	end

	opts.on("--db_name", "What db file name without extension") do | name |
		options[:db_name] = name
	end

	opts.separator "-" * 90

end.parse!

if options[:example]
	output = db_find(:db_type => "sql", :db_name => "testing", :table => "posts", :limit => 10)

	puts output
	exit
end

