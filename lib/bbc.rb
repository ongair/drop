require "juicer"
class BBC

  def self.get_sources
    begin
      url = "#{Rails.application.secrets.juicer_api_url}/sources?apikey=#{Rails.application.secrets.juicer_api_key}"
      return HTTParty.get(url)
    rescue
      raise "Could not retrieve News Sources"
    end
  end

  def self.get_articles search_term, products
    client = Juicer.new(Rails.application.secrets.juicer_api_key)
    begin
      return client.articles({ text: search_term, products: products })
    rescue
      # handle execption
    end
  end

end