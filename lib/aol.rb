require 'rubygems'
require 'csv'
require 'active_support/all'
require 'elasticsearch'

require 'es/index'
require 'dbpedia/parser'
require 'dbpedia/analyzers/lowercase'
require 'dbpedia/index'
require 'aol/parser'
require 'aol/analyzers/lowercase'
require 'aol/analyzers/domain'
require 'aol/analyzers/stemmer'
require 'aol/analyzers/dbpedia_category'
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
