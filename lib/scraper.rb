require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    collection = []
    doc = Nokogiri::HTML(open(index_url))
    students = doc.css("div.student-card")
    students.each do |student|
      student_name = student.css("h4.student-name").text
      student_location = student.css("p.student-location").text
      student_link = student.css("a").attribute("href").value
      collection << {:name => "#{student_name}", :location => "#{student_location}", :profile_url => "#{student_link}"}
    end
    collection
  end

  def self.scrape_profile_page(profile_url)
    profile = Nokogiri::HTML(open(profile_url))

    profile_info = {}

    links = profile.css("div.social-icon-container a").map { |link| link['href'] }
    twitter = links.find { |link| link.include?("twitter") }
    linkedin = links.find { |link| link.include?("linkedin") }
    github = links.find { |link| link.include?("github") }
    blog = links.find { |link| !link.include?("twitter") && !link.include?("linkedin") && !link.include?("github") }
    quote = profile.css("div.profile-quote").text
    bio = profile.css("div.description-holder p").text
    unless twitter == nil
      profile_info[:twitter] = twitter
    end
    unless linkedin == nil
      profile_info[:linkedin] = linkedin
    end
    unless github == nil
      profile_info[:github] = github
    end
    unless blog == nil
      profile_info[:blog] = blog
    end
    profile_info[:profile_quote] = quote
    profile_info[:bio] = bio

    profile_info
  end

end