module Aol
  class Parser
    def self.parse(data, enumerate: false, **options)
      queries = []
      enumerator = Enumerator.new(data)

      return enumerator if enumerate

      enumerator.each do |query|
        queries << query
      end

      queries
    end

    class Enumerator
      include Enumerable

      def initialize(data)
        @data = data
        @dbpedia = Dbpedia::Index.new
      end

      def each
        CSV.parse(@data, headers: true, col_sep: "\t") do |row|
          query = {
            user_id: row['AnonID'].to_i,
            query: row['Query'].strip.presence,
            searched_at: (Time.parse(row['QueryTime']) rescue nil),
            clicked_url: row['ClickURL'].try(:strip).presence,
            clicked_url_position: row['ItemRank'] ? row['ItemRank'].to_i : nil
          }

          labels = @dbpedia.search(query[:query])['hits']['hits']

          query[:dbpedia_resource] = labels.empty? ? :none : labels[0...1].map { |e| e['_source']['resource'] }

          yield(query)
        end
      end
    end
  end
end
