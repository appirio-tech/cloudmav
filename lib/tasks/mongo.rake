namespace :mongo do
  namespace :copy do
  
    def db_copy_load_config
      YAML.load_file(Rails.root.join("config/heroku.yml")).symbolize_keys
    end
    
    def db_copy_config
      @@config_heroku ||= db_copy_load_config
    end
    
    def get_mongohq_url(env)
      db_copy_config[env]["config"]["MONGOHQ_URL"]
    end
    
    def parse_mongodb_url(url)
      uri = URI.parse(url)
      [ uri, uri.path.gsub("/", "") ]
    end
 
    namespace :production do
      desc "Copy production data to staging"
      task :to_staging => :environment do
        Rake::Task["mongo:copy:copyDatabase"].execute({ from: get_mongohq_url(:production), to: get_mongohq_url(:staging) })
      end
      desc "Copy production data to local"
      task :to_local => :environment do
        Rake::Task["mongo:copy:copyDatabase"].execute({ from: get_mongohq_url(:production), to: "mongodb://localhost:27017/development" })
      end
    end
 
    namespace :staging do
      desc "Copy staging data to local"
      task :to_local => :environment do
        Rake::Task["mongo:copy:copyDatabase"].execute({ from: get_mongohq_url(:staging), to: "mongodb://localhost:27017/development" })
      end
    end

    namespace :local do
      desc "Copy local data to production"
      task :to_production => :environment do
        Rake::Task["mongo:copy:copyDatabase"].execute({ to: get_mongohq_url(:staging), from: "mongodb://localhost:27017/codemav" })
      end
    end
    
    desc "MongoDB database to database copy"
    task :copyDatabase, [:from, :to] => :environment do |t, args|
      from, from_db_name = parse_mongodb_url(args[:from])
      to, to_db_name = parse_mongodb_url(args[:to])
      # mongodump
      tmp_db_dir = File.join(Dir.tmpdir, 'db/' + from.host + "_" + from.port.to_s)
      tmp_db_name_dir = File.join(tmp_db_dir, from_db_name)
      FileUtils.rm_rf tmp_db_name_dir if File.directory? tmp_db_name_dir
      system "mongodump -h %s:%s -d %s -u %s -p%s -o %s" % [ from.host, from.port, from_db_name, from.user, from.password, tmp_db_dir ]
      puts "[#{Time.now}] connecting to #{to_db_name} on #{to.host}:#{to.port} as #{to.user}"
      # clear target database
      to_conn = Mongo::Connection.new(to.host, to.port)
      puts "[#{Time.now}] opening #{to_db_name} on #{to.host}:#{to.port}"
      puts "[#{Time.now}] dropping collections in #{to_db_name} on #{to.host}:#{to.port}"
      to_db = to_conn.db(to_db_name)
      to_db.authenticate(to.user, to.password) unless (to.user.nil? || to.user.blank?)
      to_db.collections.select { |c| c.name !~ /system/ }.each do |c|
        puts " [#{Time.now}] dropping #{c.name}"
        c.drop
      end
      # mongorestore
      if to.user.nil?
        system "mongorestore -h %s:%s -d %s %s" % [ to.host, to.port, to_db_name, tmp_db_name_dir ]
      else
        system "mongorestore -h %s:%s -d %s -u %s -p%s %s" % [ to.host, to.port, to_db_name, to.user, to.password, tmp_db_name_dir ]
      end
      puts "[#{Time.now}] mongo:copy complete"
    end
  
  end
end

