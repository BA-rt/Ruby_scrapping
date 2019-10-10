

require 'nokogiri'
require 'open-uri'


def parsing(url)
  Nokogiri::HTML(open(url))
end


def get_town_hall_email(town_hall_url)
  parsing(town_hall_url).xpath("//main/section[2]/div/table/tbody/tr[4]/td[2]").text
end


def get_town_name(town_hall_url)
  parsing(town_hall_url).xpath("//title").text[/ - Commune de (.*?) -/, 1]
end


def get_townhalls_urls(town_halls_register_url)
  parsing(town_halls_register_url).xpath("//a[@class='lientxt']/@href").map { |partial_link| 'http://annuaire-des-mairies.com' + partial_link.text[1..-1]}
end


def go_get_em_all(town_halls_register_url)

  town_halls_urls = get_townhalls_urls(town_halls_register_url)

  town_halls_emails = Array.new

  town_halls_urls.each do |this_city_url|

  town_halls_emails << {get_town_name(this_city_url) => get_town_hall_email(this_city_url)}
  end

  return town_halls_emails
end
