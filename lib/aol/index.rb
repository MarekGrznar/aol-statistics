module Aol
  class Index
    attr_accessor :client, :name, :settings, :mappings, :analyzers

    def client
      @client ||= Elasticsearch::Client.new(log: true)
    end

    def analyzers
      @analyzers ||= [
        Aol::Analyzers::Lowercase,
        Aol::Analyzers::Domain
      ]
    end

    def name
      @name ||= :aol
    end

    def settings
      @settings ||= analyzers.inject(Hash.new) do |hash, analyzer|
        hash.deep_merge!(analyzer.settings)

        hash
      end
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

      queries = Aol::Parser.parse(File.new(path).read)

      queries.each do |query|
        client.index index: name, type: :query, body: { query: query[:query] }
      end
    end

    def exists?
      client.indices.exists index: name
    end

    def create
      client.indices.create index: name, type: :query, body: { settings: settings, mappings: mappings }

      flush
    end

    def delete
      client.indices.delete index: name if exists?
    end

    def flush
      client.indices.flush index: name
    end
  end
end
