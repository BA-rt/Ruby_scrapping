
require_relative '../lib/mairies_christmas'

val_oise = 'http://annuaire-des-mairies.com/val-d-oise.html'
mairie_chaussy = 'http://annuaire-des-mairies.com/95/chaussy.html'


describe 'parsing' do
  it 'création fichier HTML' do
    expect(parsing(val_oise).class).to eq(Nokogiri::HTML::Document)
  end
end


describe 'get_town_hall_email' do
  it 'nil ?' do
    expect(get_town_hall_email(mairie_chaussy).class).not_to eq(nil)
  end

  it 'string ?' do
    expect(get_town_hall_email(mairie_chaussy).class).to eq(String)
  end

  it '@ ?' do
    expect(get_town_hall_email(mairie_chaussy).include?('@')).to eq(true)
  end

  it 'bonne adresse mail ?' do
    expect(get_town_hall_email(mairie_chaussy)).to eq('mairie.chaussy@wanadoo.fr')
  end
end


describe 'get_town_name' do
  it 'nil ?' do
    expect(get_town_name(mairie_chaussy).class).not_to eq(nil)
  end

  it 'string ?' do
    expect(get_town_name(mairie_chaussy).class).to eq(String)
  end

  it 'majuscule ?' do
    expect(get_town_name(mairie_chaussy).upcase == get_town_name(mairie_chaussy).upcase).to eq(true)
  end

  it 'bonne commune ?' do
    expect(get_town_name(mairie_chaussy)).to eq('CHAUSSY')
  end
end


describe 'get_townhalls_urls' do
  it 'nil ?' do
    expect(get_townhalls_urls(val_oise).class).not_to eq(nil)
  end

  it 'tableau ?' do
    expect(get_townhalls_urls(val_oise).class).to eq(Array)
  end

  it 'de la bonne taille ?' do
    expect(get_townhalls_urls(val_oise).length).to eq(185)
  end

  it 'contient au moins une bonne commune' do
    expect(get_townhalls_urls(val_oise).include?('http://annuaire-des-mairies.com/95/chaussy.html')).to eq(true)
  end
end
