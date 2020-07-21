require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    #scraping index page that lists all the students 
    # index_url = https://learn-co-curriculum.github.io/student-scraper-test-page/index.html
    html = open("#{index_url}")
    doc = Nokogiri::HTML(html)

    student_array = []

    # :name = doc.css(".student-name").first.text
    # :location = doc.css(".student-location").first.text
    # :profile_url = doc.css("a").attribute("href")first.value

    doc.css(".student-card").each_with_index do |student, index|
      student_array[index] = {
          :name => student.css(".student-name").text,
          :location => student.css(".student-location").text,
          :profile_url => student.css("a").attribute("href").value
      }
    end 
    student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)

      profile_page_info = {
        :twitter => doc.css(".social-icon-container a")[0].attribute("href").value,
        :linkedin => doc.css(".social-icon-container a")[1].attribute("href").value,
        :github => doc.css(".social-icon-container a")[2].attribute("href").value,
        :blog => doc.css(".social-icon-container a")[3].attribute("href").value,
        :profile_quote => doc.css(".profile-quote").text,
        :bio => doc.css(".description-holder p").text
      }
  end 

end
