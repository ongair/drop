require 'httparty'
require 'sanitize'
class Candy
  include HTTParty

  HEADERS = { 'X-Candy-Platform' => 'Mobile', 'X-Candy-Audience' => 'International', 'Accept' => 'application/json' }

  def self.articles
    headers = { 'X-Candy-Platform' => 'Mobile', 'X-Candy-Audience' => 'International', 'Accept' => 'application/json' }
    base_url = Rails.application.secrets.candy_url
    key = Rails.application.secrets.candy_key

    url = "#{base_url}#{key}"

    response = get(url, headers: headers)

    groups = response['results'].first['groups']
    groups = groups.select { |g| g['type'] == 'container-top-stories' }

    # assuming it is an array
    items = groups.collect{ |g| g['items'] }.flatten
    items.collect{ |a| { title: a['headline'], id: a['assetId'], uri: a['assetUri'], created: a['firstCreated'], updated: a['lastUpdated'], prominence: a['prominence'] } }
  end

  # def self.process_group group
  #   group.collect { |g| g['items'] }
  # end

  def self.article asset_uri
    url = "#{Rails.application.secrets.candy_content_url}#{asset_uri}?api_key=#{Rails.application.secrets.candy_key}"
    
    article = get(url, headers: HEADERS)
    article['results'].first
  end

  def self.nested_hash_value(obj,key)
    if obj.respond_to?(:key?) && obj.key?(key)
      obj[key]
    elsif obj.respond_to?(:each)
      r = nil
      obj.find{ |*a| r=nested_hash_value(a.last,key) }
      r
    end
  end

  def self.load_featured_articles
    articles = self.articles
    articles.each do |summary|
      if Article.find_by(external_id: summary[:id]).nil?        
        full = self.article(summary[:uri])
        body = Sanitize.fragment(full['body']) 
        
        image_tag = full['media']['images']
        image_url = self.nested_hash_value(image_tag, 'href')
        
        article = Article.create! external_id: summary[:id], title: summary[:title], 
          image_url: image_url,
          body: body,
          summary: full['summary'], featured: true, created_at: DateTime.parse(full['lastPublished']), published_date: DateTime.parse(full['lastPublished'])
      end
    end
  end
end