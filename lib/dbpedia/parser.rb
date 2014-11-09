module Dbpedia
  class Parser
    def self.parse(text)
      categories = []

      text.split("\n").each do |line|
        next if line[0] == '#'

        _, category = *line.match(/.+"(.+)"@en/)

        categories << category
      end

      categories
    end
  end
end
