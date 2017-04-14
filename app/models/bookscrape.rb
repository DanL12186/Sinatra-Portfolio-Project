class BookScraper

def scrape
  page = Nokogiri::HTML(open('http://www.alistofbooks.com/'))

  page.css('ul.book-list li').each do |book|
    @@books << book.css('a.book-title').text.strip
    end
  end
end
