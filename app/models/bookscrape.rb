class BookScraper
  require 'open-uri'
  
  @@all = []

  def self.all
    @@all
  end

  def self.scrape
    @@all unless @@all.empty?

    page = Nokogiri::HTML(open('http://www.alistofbooks.com/'))

    page.css('ul.book-list li').each do |book|
      @@all << book.css('a.book-title').text.strip
    end
  end
end

