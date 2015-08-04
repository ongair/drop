require "juicer"
class BBC
	# def get url
	# 	header = {
	# 		"X-Candy-Platform" => "Desktop",
	# 		"X-Candy-Audience" => "International",
	# 		"Accept" => "application/json"
	# 	}
	# 	HTTParty.get(url, {headers: header})
	# end

	# def juicer
	# 	Juicer.new(Rails.application.secrets.juicer_api_key)
	# end

	# def create_articles text="", sections="", product, published_after, category
	# 	articles = juicer.articles({text: text, product: product, published_after: published_after, sections: sections, recent_first: true}) # "BBC News - Africa, BBC Sport - Football"
	# 	if !articles.empty?
 #      articles.each do |article|            
 #        is_new = Article.find_by(external_id: article["cps_id"], source: category.source).nil?

 #        if is_new
 #          metadata = { published: article["published"], product_source: article["source"] }.to_json
 #          Article.create! category: category, source: "Juicer", title: article["title"], external_id: article["cps_id"], article_type: "Web",
 #            url: article["url"], image_url: article["image"]["src"], summary: article["description"], metadata: metadata
 #        end
 #      end
 #    end
	# end

  def self.get_sources
    begin
      url = "#{Rails.application.secrets.juicer_api_url}/sources?apikey=#{Rails.application.secrets.juicer_api_key}"
      return HTTParty.get(url)
    rescue
      raise "Could not retrieve News Sources"
    end
  end
end