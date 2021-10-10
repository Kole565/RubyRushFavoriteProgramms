require_relative "../lib/dbinteractor.rb"
require_relative "../lib/memo.rb"
require_relative "../lib/link.rb"
require_relative "../lib/task.rb"

def add_post(options = {})
	# Add post to db
	#
	# Options:
	# :item => class exem (Memo.new, Link.new, etc.)
	# 	Can get in create_item
	# 	If miss look :optparse
	#
	# :items => if lot of items
	#
	# :type => type of db (sql, json, xml etc.)
	# :name => db name (in 'data/:db_type/:db_name')
	# :table => table name (posts)
	#
	# :optparse => hash with options to create item
	
	options[:item] = create_item(options[:optparse]) if options[:item].nil?

	dbi = DBInteractor.new

	case options[:type]
	when "sql"
		
		# Add to local storage
		if !options[:item].nil?
			
			dbi.storage_add(options[:item])

		elsif !options[:items].nil?

			for item in options[:items]
				dbi.storage_add(item)
			end
		
		else
			return
		end
		
		dbi.push(options)

	end

	return 0
	
end

def create_item(options)
	# Create Post child class exem
	#
	# Options:
	# :type - item class name (Memo, Link) - required
	# :text - item text                    - required
	#
	# :author - author, anonymous be default
	# :link - url link

	case options[:type].capitalize
	when "Memo"
		item = Memo.new(options)
	when "Link"
		item = Link.new(options)
	when "Task"
		item = Task.new(options)
	end

	item

end