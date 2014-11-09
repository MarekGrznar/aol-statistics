module Dbpedia
  class Index < Es::Index
    def name
      @name ||= :dbpedia
    end

    def type
      @type ||= :category
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
            category: {
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

      queries = DBpedia::Parser.parse(File.new(path).read, enumerate: true)

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
