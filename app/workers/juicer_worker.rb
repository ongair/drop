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

    # the sources we will be searching
    sources = Source.active.collect{ |s| s.juicer_id }

    # does this category have specific sources e.g. Tech
    category_sources = category.metadata.try(:split, ',')

    sources = category_sources if !category_sources.blank?

    terms.each do |term|
      # get the first cut of articles

      articles = BBC.get_articles term.strip, sources
      articles.each do |article|

        is_new = Article.find_by(external_id: article["cps_id"]).nil?
        if is_new
          
          new_article = create_article(article, category)
          # find similar articles

          similar_articles = BBC.get_similar_articles article['cps_id']
          similar_articles.each do |art|
            create_article art, category
          end
        end

      end
    end    
  end

  private 

    # Save juicer article to the db
    def create_article juice_article, category
      # sometimes image url is nil
      image = juice_article['image']['src'] if !juice_article['image'].nil?
      
      Article.create! category: category, title: juice_article['title'], external_id: juice_article['cps_id'], url: juice_article['url'],
        image_url: image, summary: juice_article['description'], body: juice_article['body']

      logger.info "Saved article: #{juice_article['title']}"
    end
end