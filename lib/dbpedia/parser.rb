module Dbpedia
  class Parser
    def self.parse(text)
      labels = []

      text.split("\n").each do |line|
        next if line[0] == '#'

        _,  resource, title = *line.match(/^<([^>]+)>.+"(.+)"@en/)

        resource = ResourceRedirect.lookup(resource) || resource

        labels << { title: title, resource: resource }
      end

      labels
    end

    class ResourceRedirect
      def self.resources
        @resources ||= parse
      end

      def self.lookup(resource)
        resources[resource]
      end

      def self.parse
        Oj.load(File.new(File.join(File.dirname(File.expand_path(__FILE__)), '../../data/dbpedia/redirects.json')).read)
      end
    end
  end
end
