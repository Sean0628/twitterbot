class Scraping
  def self.page_urls
    agent = Mechanize.new
    num = 1
    while num <= 100
      page = agent.get("https://www.goodreads.com/quotes?page=#{num}")
      divs = page.search('.quotes .quote')
      divs.each do |quote|
        if quote.at('.quoteText')
          body = quote.at('.quoteText').inner_text
          body =~ /“(.+)”/
          body = $+
        end
        author = quote.at('.quoteText a').inner_text if quote.at('.quoteText a')
        create_quote(body, author)
      end
      num += 1
    end
  end

  def self.create_quote(body, author)
    return unless body.present? && author.present?
    Quote.create!(body: body, author: author)
  end
end
