$: << File.join(File.dirname(File.absolute_path(__FILE__)), 'lib')

require 'rubygems'
require 'bundler/setup'

require 'aol'

namespace :aol do
  desc 'Import Aol Data'
  task :import do
    directory = File.join(File.dirname(File.expand_path(__FILE__)), 'data')

    Aol.import_from_directory(directory)
  end

  desc 'Statistics'
  task :statistics do
    results = Aol.statistics

    results.facets
  end
end
