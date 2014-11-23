$: << File.join(File.dirname(File.absolute_path(__FILE__)), 'lib')

require 'rubygems'
require 'bundler/setup'

require 'aol'

def root
  File.dirname(File.expand_path(__FILE__))
end

desc 'Setup'
task :setup do
  Rake::Task['dbpedia:serialize_redirects'].invoke
end

namespace :aol do
  desc 'Import Aol Data'
  task :import do
    directory = File.join(root, 'data/aol')

    Aol.import_from_directory(directory)
  end

  desc 'Dump statistics'
  task :dump_statistics do
    results = Aol.statistics

    results.facets.each do |name, values|
      puts name

      values.each do |value, count|
        puts "\t#{value}\t#{count}"
      end
    end
  end
end

namespace :dbpedia do
  desc 'Import dbpedia categoris'
  task :import do
    index = Dbpedia::Index.new

    index.import_from(File.join(root, 'data/dbpedia/labels_en.ttl'))
  end

  desc 'Serialize redirects map into JSON'
  task :serialize_redirects do
    redirects = Dbpedia::RedirectsParser.parse(File.new(File.join(root, 'data/dbpedia/redirects_en.ttl')).read)

    File.open(File.join(root, 'data/dbpedia/redirects.json'), 'w') do |file|
      file.write(redirects.to_json)
    end
  end
end
