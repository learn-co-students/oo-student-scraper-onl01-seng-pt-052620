require 'open-uri'
require 'nokogiri'
require 'pry'


class Scraper

  def self.scrape_index_page(index_url)
    index = Nokogiri::HTML(open(index_url))
    index_arr = []

    index.css('.student-card').each do |student|
      index_arr << {
        :name => student.css('.card-text-container .student-name').text,
        :location => student.css('.card-text-container .student-location').text,
        :profile_url => student.css('a').attribute('href').value
      }
    end
    index_arr
  end


  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))
    profile_hash = {}

    social_links = profile.css('.social-icon-container a').collect { |social| social.attribute('href').value }
    social_links.each do |link|
      if link.include?('twitter')
        profile_hash[:twitter] = link
      elsif link.include?('linkedin')
        profile_hash[:linkedin] = link
      elsif link.include?('github')
        profile_hash[:github] = link
      elsif link.include?('.com')
        profile_hash[:blog] = link
      end
    end
    profile_hash[:profile_quote] = profile.css('.profile-quote').text
    profile_hash[:bio] = profile.css('.description-holder p').text

    profile_hash
  end

end

