$: << File.join(File.dirname(File.absolute_path(__FILE__)), 'lib')

require 'rubygems'
require 'bundler/setup'

require 'aol'

namespace :aol do
  desc 'Import Aol Data'
  task :import do
    Aol.import
  end

  desc 'Statistics'
  task :statistics do
    results = Aol.statistics

    results.facets
  end
end
