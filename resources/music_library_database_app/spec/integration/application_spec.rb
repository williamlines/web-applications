require "spec_helper"
require "rack/test"
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }
  context 'GET /albums' do
    it 'should return the list of albums' do
      response = get('/albums')
      expected_response = ('Surfer Rosa
Waterloo
Super Trouper
Bossanova
Lover
Folklore
I Put a Spell on You
Baltimore
Here Comes the Sun
Fodder on My Wings
Ring Ring'
      )
      
      expect(response.status).to eq 200
      expect(response.body).to eq expected_response

    end
    
    it "can create new albums" do
      response = post('/albums', title: 'The Dark Side of the Moon', release_year: '1973', artist_id: '1')
      expect(response.status).to eq 200
      expect(response.body).to eq ''

      response = get('/albums')
      expect(response.body).to include('The Dark Side of the Moon')
    end
  end
  context "GET /artists" do
    it 'Gets a list of artists' do
      response = get('/artists')
      expect(response.status).to eq 200
      expect(response.body).to eq('Pixies
ABBA
Taylor Swift
Nina Simone
Kiasmos'
)
    end
  end
  context "post artist" do
    it "can create a new artist" do
      response = post('/artists', name: 'Pink Floyd', genre: 'Experimental')
      expect(response.status).to eq 200
      expect(response.body).to eq ""

      response = get('/artists')
      expect(response.body).to eq('Pixies
ABBA
Taylor Swift
Nina Simone
Kiasmos
Pink Floyd')

    end
  end
end
