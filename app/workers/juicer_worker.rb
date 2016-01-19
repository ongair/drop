require 'juicer'
require 'bbc'

class JuicerWorker
  include Sidekiq::Worker
  # include Sidetiq::Schedulable

  sidekiq_options :queue => :data, :retry => false
  # recurrence { daily }

  def perform(category_id)

    category = Category.find(category_id)

    logger.info "Search for articles in #{category.name}"

    terms = category.keywords.split(',')

    terms.each do |term|
      # get the first cut of articles

      articles = BBC.articles term.strip
      articles.each do |article|

        is_new = Article.find_by(external_id: article[:id]).nil?
        if is_new
          
          new_article = Article.create_from_juicer(article, category)
          # find similar articles

          similar_articles = BBC.get_similar_articles new_article.id
          similar_articles.each do |art|
            # create_article art, category
            Article.create_from_juicer(art, category)
          end
        end

      end
    end    
  end

  private 

    # Save juicer article to the db
    def create_article juicer_article, original      
      
      category = Category.category_from_url(juicer_article[:url]) || original      

      article = Article.create! category: category, title: juicer_article[:title], external_id: juicer_article[:id], url: juicer_article[:url],
        image_url: juicer_article[:image], summary: juicer_article[:description], body: juicer_article[:body], published_date: juicer_article[:published]

      Article.shorten_url(article)
      # logger.info "Saved article: #{juice_article['title']}"
    end
end