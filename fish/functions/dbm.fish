# Defined via `source`
function dbm --wraps='bin/rake db:migrate; git co -- db/schema.rb' --description 'alias dbm=bin/rake db:migrate; git co -- db/schema.rb'
    bin/rake db:migrate && git co -- db/schema.rb
end
