class ParseLibrary
  @@library = []
  def self.read_library(file)
    library = File.read(file)
    @books = library.split("\n")
    @books.each_with_index { |x,y| @books[y] = x.split(", by ") }
    @books.delete_if(&:empty?)
  end
  def self.format_data
    @books.each {|x| @@library.push({title: x[0], authors: x.last(x.size - 1)})}
    @@library.map { |x| x[:authors][0].split(", ") }
    @@library
  end
  def self.run_parser(file)
    ParseLibrary.read_library(file)
    ParseLibrary.format_data
  end
end

class Book
  def initialize(title, authors)
    @title = title
    @author = []
  end
  def add_author
  end
end

p ParseLibrary.run_parser('./library.txt')
