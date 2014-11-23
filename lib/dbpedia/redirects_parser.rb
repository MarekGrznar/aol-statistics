module Dbpedia
  class RedirectsParser
    def self.parse(text)
      redirects = Hash.new

      text.split("\n").each do |line|
        _, source, origin = *line.match(/^<([^>]+)> <http:\/\/dbpedia.org\/ontology\/wikiPageRedirects> <([^>]+)>/)

        redirects[source] = origin
      end

      redirects
    end
  end
end
