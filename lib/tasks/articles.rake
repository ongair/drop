require 'candy'
namespace :articles do
  desc "Load articles from juicer"
  task :load => :environment do

    Category.all.each do |category|
      puts "Running Juicer for #{category.name}"
      JuicerWorker.perform_async(category.id)
    end 
  end

  desc "Load articles from Candy"
  task :load_features => :environment do    
    Candy.load_featured_articles
  end
end