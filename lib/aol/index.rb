module Aol
  class Index < Es::Index
    def name
      @name ||= :aol
    end

    def type
      @type ||= :query
    end

    def analyzers
      @analyzers ||= [
        Aol::Analyzers::Lowercase,
        Aol::Analyzers::Domain
      ]
    end

    def mappings
      fields = analyzers.inject(Hash.new) do |hash, analyzer|
        hash.deep_merge!(analyzer.mapping)

        hash
      end

      @mappings ||= {
        query: {
          properties: {
            query: {
              type: :multi_field,
              fields: fields
            }
          }
        }
      }
    end

    def import_from(path)
      delete
      create

      queries = Aol::Parser.parse(File.new(path).read, enumerate: true)

      queries.each_slice(10000) do |array|
        client.bulk body: array.map { |query|
          [
            { index: { _index: name, _type: type }},
            { query: query[:query] }
          ]
        }.flatten
      end

      flush
    end
  end
end
