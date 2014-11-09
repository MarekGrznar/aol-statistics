$: << File.join(File.dirname(File.absolute_path(__FILE__)), 'lib')

require 'rubygems'
require 'bundler/setup'

require 'aol'

def root
  File.dirname(File.expand_path(__FILE__))
end

namespace :aol do
  desc 'Import Aol Data'
  task :import do
    directory = File.join(root, 'data')

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

    index.import_from(File.join(root, 'data/category_labels_en.ttl'))
  end
end
