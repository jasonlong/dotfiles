function dbm
	bin/rake db:migrate; git co -- db/mysql2-structure.sql;
end
