require 'spec_helper'

describe Dbpedia::RedirectsParser do
  describe '.parse' do
    it 'parses redirects' do
      redirects = Dbpedia::RedirectsParser.parse(fixture('dbpedia/redirects.txt').read)

      expect(redirects['http://dbpedia.org/resource/AccessibleComputing']).to eql('http://dbpedia.org/resource/Computer_accessibility')
    end
  end
end
