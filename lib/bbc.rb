require 'httparty'
class BBC
  include HTTParty

  def self.articles term, sources=nil, cut_off=nil
    url = "#{Rails.application.secrets.juicer_api_url}articles?api_key=#{Rails.application.secrets.juicer_api_key}&"
    url += self.build_params term, sources, cut_off

    Rails.logger.debug "Looking for #{term}"
    Rails.logger.debug "URL: #{url}"

    results = get(url)        
    return self.map_results results
  end

  def self.build_params term, sources=nil, cut_off=nil
    sources ||= Source.to_ids
    cut_off ||= 7.days.ago.utc
    hash = {
      q: term,
      sources: sources,
      recent_first: 'yes',
      lang: 'en',
      published_after: cut_off.beginning_of_day.strftime('%Y-%m-%dT%H:%M:%SZ')
    }
    HTTParty::HashConversions.to_params(hash)
  end

  def self.map_results results
    total = results["total"]
    Rails.logger.debug "Number of results: #{total}"

    raw = results["hits"].collect do |hit|
      {
        description: hit['description'],
        title: hit['title'],
        id: hit['id'],
        image: hit['image'],
        body: hit['body'],
        published: hit['published'],
        url: hit['url']
      }
    end
  end

  def self.get_article id 
    url = "#{Rails.application.secrets.juicer_api_url}articles/#{id}?api_key=#{Rails.application.secrets.juicer_api_key}"
    result =  get(url)
    if !result['id'].nil?
      return {
        description: result['description'],
        title: result['title'],
        id: result['id'],
        image: result['image'],
        body: result['body'],
        published: result['published'],
        url: result['url']
      }
    else
      return nil
    end
  end

  def self.get_similar_articles id, sources=nil
    url = "#{Rails.application.secrets.juicer_api_url}articles?api_key=#{Rails.application.secrets.juicer_api_key}&"
    sources ||= Source.to_ids
    cut_off = 1.year.ago.utc
    hash ={
      'like-ids' => [id],
      'sources' => sources,
      'recent_first' => 'yes',
      'lang' => 'en',
      'published_after' => cut_off.beginning_of_day.strftime('%Y-%m-%dT%H:%M:%SZ')
    }

    url += HTTParty::HashConversions.to_params(hash)

    results = get(url)        
    return self.map_results results
  end

end