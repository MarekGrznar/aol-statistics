module Es
  class Index
    attr_accessor :client, :name, :type, :settings, :mappings, :analyzers

    def client
      @client ||= Elasticsearch::Client.new
    end

    def analyzers
      @analyzers ||= []
    end

    def settings
      @settings ||= analyzers.inject(Hash.new) do |hash, analyzer|
        hash.deep_merge!(analyzer.settings)

        hash
      end
    end

    def exists?
      client.indices.exists index: name
    end

    def create
      client.indices.create index: name, type: type, body: { settings: settings, mappings: mappings }

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
