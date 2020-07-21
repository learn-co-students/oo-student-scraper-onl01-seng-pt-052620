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
    #scraping individual student's profile page to get further info about student
    html = open("#{profile_url}")
    doc = Nokogiri::HTML(html)

    #return values should be key/value pairs that describe a student
    # Twitter URL, LinkedIn URL, GitHub URL, blog URL, profile quote, and bio.
  end

end


# 1] pry(Scraper)> student_array
# => [{:name=>"Ryan Johnson", :location=>"New York, NY", :profile_url=>"students/ryan-johnson.html"}]