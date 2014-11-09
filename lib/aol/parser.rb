module Aol
  class Parser
    def self.parse(data, enumerate: false)
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
      end

      def each
        CSV.parse(@data, headers: true, col_sep: "\t") do |row|
          yield(
            user_id: row['AnonID'].to_i,
            query: row['Query'].strip.presence,
            searched_at: (Time.parse(row['QueryTime']) rescue nil),
            clicked_url: row['ClickURL'].try(:strip).presence,
            clicked_url_position: row['ItemRank'] ? row['ItemRank'].to_i : nil
          )
        end
      end
    end
  end
end
