class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url

  @@all = []

  def hash_variables(hash)
    hash.each do |key, val|
      instance_variable_set("@#{key}", val)
    end
  end

  def initialize(student_hash)
    hash_variables(student_hash)
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |student|
      new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    hash_variables(attributes_hash)
  end

  def self.all
    @@all
  end
end
