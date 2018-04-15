class Scraping
  def self.page_urls
    agent = Mechanize.new
    num = 1
    while num <= 100 do
      page = agent.get("https://www.goodreads.com/quotes?page=#{num}")
      divs = page.search(".quotes .quote")
      divs.each do |quote|
        if page.get(".quote .quoteText")
          body   = quote.get(".quote .quoteText").inner_text
          body   =~ /“(.+)”/
          body   = $+
        end
        if page.get(".quote .quoteText a")
          author = page.get(".quote .quoteText a").inner_text
        end
        save_quote(body, author)
      end
    end
  end

  def self.save_quote(body, author)
    Quote.save!(body: body, author: author)
  end
end
