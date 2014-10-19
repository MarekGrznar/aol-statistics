require 'rubygems'
require 'csv'
require 'active_support/all'
require 'elasticsearch'

require 'aol/parser'
require 'aol/analyzers/lowercase'
require 'aol/analyzers/domain'
require 'aol/index'
require 'aol/search'
require 'aol/results'

module Aol
  def self.import_from_directory(directory)
    index = Aol::Index.new

    index.delete
    index.create

    Dir["#{directory}/**/*.txt"].each do |path|
      index.import_from(path)
    end
  end

  def self.statistics
    search = Aol::Search.new

    search.perform
  end
end
