require 'candy'
namespace :articles do
  desc "Load articles from juicer"
  task :load => :environment do

    Category.enabled.each do |category|
      puts "Running Juicer for #{category.name}"
      JuicerWorker.perform_async(category.id)
    end 
  end

  desc "Load articles from Candy"
  task :load_features => :environment do    
    Candy.load_featured_articles
  end

  desc "Shorten articles"
  task :shorten => :environment do
    bitly = Bitly.new(Rails.application.secrets.bitly_login, Rails.application.secrets.bitly_key)
    Article.fresh.each do |article|
      if article.shortened_url.blank?
        url = "#{Rails.application.secrets.base_url}#/articles/#{article.id}"
        u = bitly.shorten(url)
        article.shortened_url = u.short_url
        article.save!

        puts "Shortened #{url} to #{u.short_url}"
      end
    end
  end

  desc "Patch categories"
  test :patch_categories => :environment do
    Category.where(name: 'Sports').update_all(subdirectory: 'sport')
    Category.where(name: 'Entertainment').update_all(subdirectory: 'entertainment')
    Category.where(name: 'Science').update_all(subdirectory: 'science,technology')
  end
end