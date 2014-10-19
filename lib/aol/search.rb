module Aol
  class Search
    attr_reader :index

    def initialize
      @index = Aol::Index.new
    end

    def perform
     query = index.analyzers.inject(Hash.new) do |hash, analyzer|
        hash.deep_merge!(analyzer.search)

        hash
      end

      response = index.client.search index: index.name, body: query

      Results.new(response)
    end
  end
end
