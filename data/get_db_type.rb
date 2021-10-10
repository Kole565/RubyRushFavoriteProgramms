def get_db_type(type = "sql")
	# Return db file name end by type

	case type
	when "sql"
		return "sqlite3"
	end

end