require 'spec_helper'

describe Aol::Parser do
  describe '.parse' do
    it 'parses input AOL query log' do
      data = fixture('aol/sample.txt')

      queries = described_class.parse(data)

      expect(queries.size).to eql(35)

      expect(queries[0]).to eql(
        user_id: 142,
        query: 'rentdirect.com',
        searched_at: Time.parse('2006-03-01 07:17:12'),
        clicked_url: nil,
        clicked_url_position: nil,
        dbpedia_category: :none
      )

      expect(queries[6]).to eql(
        user_id: 142,
        query: 'westchester.gov',
        searched_at: Time.parse('2006-03-20 03:55:57'),
        clicked_url: 'http://www.westchestergov.com',
        clicked_url_position: 1,
        dbpedia_category: :none
      )

      expect(queries[-2]).to eql(
        user_id: 217,
        query: 'p; .; p;\' p; \' ;\' ;\';',
        searched_at: Time.parse('2006-03-09 12:09:27'),
        clicked_url: nil,
        clicked_url_position: nil,
        dbpedia_category: :none
      )
    end

    it 'searches for relevant dbpedia category' do
      data = fixture('aol/sample.txt')
      dbpedia = double(:dbpedia, search: { 'hits' => { 'hits' => [] } })

      allow(dbpedia).to receive(:search).with('rentdirect.com').and_return({ 'hits' => { 'hits' => [{'_source' => { 'category' => 'Rentdirect.com Rentals' }}]}})
      allow(Dbpedia::Index).to receive(:new).and_return(dbpedia)

      queries = described_class.parse(data)

      expect(queries.size).to eql(35)

      expect(queries[0]).to eql(
        user_id: 142,
        query: 'rentdirect.com',
        searched_at: Time.parse('2006-03-01 07:17:12'),
        clicked_url: nil,
        clicked_url_position: nil,
        dbpedia_category: ['Rentdirect.com Rentals']
      )
    end
  end
end
