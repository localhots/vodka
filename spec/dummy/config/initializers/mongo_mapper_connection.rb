config = YAML::load_file(Rails.root + 'config/mongoid.yml')[Rails.env]['sessions']['default']
host, port = *config['hosts'].first.split(?:)
MongoMapper.connection = Mongo::Connection.new(host, port)
MongoMapper.database = config['database']
