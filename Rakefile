require 'rake'
require 'rspec/core/rake_task'
require_relative 'db/config'
require_relative 'lib/sunlight_legislators_importer'


desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

task :default  => :specs

desc 'Seed the senator'
task "db:seed" do
  SunlightLegislatorsImporter.import(File.dirname(__FILE__) + "/db/data/legislators.csv")
end

desc "Move to Single Table Inheritance"
task "set_type" do
    Legislator.all.each do |legislator|
    if legislator.title == "Rep"
      legislator.type = "Representative"
    elsif legislator.title == "Sen"
      legislator.type = "Senator"
    elsif legislator.title == "Del"
      legislator.type = "Delegate"
    elsif legislator.title == "Com"
      legislator.type = "Commissioner"
    end
    legislator.save
  end
end

task :console do
  exec "irb -r./main.rb"
end
