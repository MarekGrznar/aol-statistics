require 'spec_helper'

describe Dbpedia::Parser do
  describe '.parse' do
    it 'parses titles from wikipedia articles' do
      labels = Dbpedia::Parser.parse(fixture('dbpedia/labels.txt').read)

      expect(labels.size).to eql(9)

      label = labels.first

      expect(label).to eql(title: 'AccessibleComputing', resource: 'http://dbpedia.org/resource/Computer_accessibility')
    end
  end
end
