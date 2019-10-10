

    require 'nokogiri'
    require 'open-uri'


    URL ='https://coinmarketcap.com/all/views/all/'
    page = Nokogiri::HTML(open(URL))

    puts "Premier tableau dans lequel on met les acronymes"

    gets
    acronyme_array = page.xpath("//td[contains(@class, 'col-symbol')]")
    puts acronyme_array
    gets

    puts "Passage en .texte"

    gets
    currencies_array = acronyme_array.map { |currency| currency.text }
    puts currencies_array
    gets

    puts "Deuxième tableau dans lequel on met les valeurs des cryptos"

    gets
    values_array = page.xpath("//a[@class = 'price']")
    puts values_array
    gets

    puts "Suppression des $ et passage en .float"

    gets
    values_array = values_array.map { |link| link.content.delete('$').to_f}
    puts values_array
    gets

    puts "Tableau final et mise en place du hash"

    gets
    crypto_values_array = Array.new
    acronyme_array.each_with_index do |currency, index|
      crypto_hash = {currency => values_array[index]}
      crypto_values_array << crypto_hash
    end

    puts crypto_values_array
