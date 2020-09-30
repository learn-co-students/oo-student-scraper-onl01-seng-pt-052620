require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = Nokogiri::HTML(URI.open(index_url))
    student_cards = html.css('.student-card')
    students = []

    student_cards.each do |sc|
      students << {
        :name => sc.css('.student-name').text,
        :location => sc.css('.student-location').text,
        :profile_url => sc.css('a')[0]['href']
      }
    end

    return students
  end

  def self.scrape_profile_page(profile_url)
    html = Nokogiri::HTML(URI.open(profile_url))
    links = html.css('.social-icon-container a')

    profile = {
      :profile_quote => html.css('.profile-quote').text,
      :bio => html.css('.bio-block .description-holder').text.strip
    }

    links.each do |link|
      link = link['href']
      case
      when link.include?("twitter")
        profile[:twitter] = link
      when link.include?("linkedin")
        profile[:linkedin] = link
      when link.include?("github")
        profile[:github] = link
      else
        profile[:blog] = link
      end
    end

    return profile
  end

end
