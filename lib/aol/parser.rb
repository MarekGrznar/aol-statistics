module Aol
  class Parser
    def self.parse(data, &block)
      queries = []

      CSV.parse(data, headers: true, col_sep: "\t") do |row|
        queries << {
          user_id: row['AnonID'].to_i,
          query: row['Query'].strip.presence,
          searched_at: (Time.parse(row['QueryTime']) rescue nil),
          clicked_url: row['ClickURL'].try(:strip).presence,
          clicked_url_position: row['ItemRank'] ? row['ItemRank'].to_i : nil
        }
      end

      queries
    end
  end
end
