require 'juicer'
require 'bbc'

class JuicerWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options :queue => :data, :retry => false
  recurrence { minutely }

  def perform(last_occurrence, current_occurrence)

    logger.info "Searching for juicer data at #{Time.now}"

    # juicer = Juicer.new(Rails.application.secrets.juicer_api_key)

    b = BBC.new

    Category.where(source: "Juicer").each do |category|
      logger.info "Category is #{category.name}"

      products = JSON.parse(category.metadata)
      keywords = JSON.parse(category.keywords)

      keywords.each do |keyword|
        logger.info "Searching for keyword #{keyword}"

        articles = juicer.articles({ text: keyword, product: products, published_after: Time.now.beginning_of_month, recent_first: true })
        logger.info "Got #{articles.length} articles"
        if !articles.empty?

          articles.each do |article|            
            is_new = Article.find_by(external_id: article["cps_id"], source: "Juicer").nil?

            if is_new
              metadata = { published: article["published"], product_source: article["source"] }.to_json
              Article.create! category: category, source: "Juicer", title: article["title"], external_id: article["cps_id"],
                url: article["url"], image_url: article["image"]["src"], summary: article["description"], metadata: metadata
            end
          end

        end        
      end
      metadata = JSON.parse(category.metadata)
      keywords = JSON.parse(category.keywords)
      b.create_articles keywords, metadata["sections"], metadata["sources"], Time.now.beginning_of_month, category
    end
  end
end