module Aol
  class Search
    attr_reader :index

    def initialize
      @index = Aol::Index.new
    end

    def perform
      params = index.analyzers.inject(Hash.new) do |hash, analyzer|
        hash[analyzer.name] = {
          terms: {
            field: "query.#{analyzer.name}"
          }
        }

        hash
      end

      response = index.client.search index: index.name, body: { facets: params }

      Results.new(response)
    end
  end
end
