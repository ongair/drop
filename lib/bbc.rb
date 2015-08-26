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
      raise 'Could not get articles for this category'
    end
  end

  def self.get_articles_by_sources search_term, products    
    begin
      url = "#{Rails.application.secrets.juicer_api_url}articles?apikey=#{Rails.application.secrets.juicer_api_key}"
      cut_off = 30.days.ago.utc
      return HTTParty.get(url, query: { sources: products, q: search_term, published_after: cut_off })['hits']
    rescue
      raise "Could not retrieve articles"
    end
  end


  def self.get_similar_articles cps_id
    client = Juicer.new(Rails.application.secrets.juicer_api_key)
    begin
      
      # get the ids of similar articles
      similar_article_summaries_ids = client.similar_articles(cps_id).collect { |summary| summary['cps_id'] }

      # exclude already saved articles
      similar_article_summaries_ids.reject! { |id| !Article.find_by(external_id: id).nil? }

      # fetch full article metadata from juicer
      return similar_article_summaries_ids.collect { |id| client.article(id) }

    rescue => e
      # handle execption
      raise "Could not get similar articles : #{e}"
    end
  end

end