# require 'twitter_api'
# namespace :article do
# 	desc "Create Article from Twitter trends"
	
# 	task :create_from_twitter => :environment do
# 		t = TwitterApi.new
# 		trends = []
# 		t.trends("1528488").each do |tr|
# 			trends << {hashtag: tr.name, url: tr.url.to_s}
# 		end
# 		Article.create! title: "Trending in Nairobi, Kenya", metadata: trends.to_json
# 	end
# end

namespace :articles do
  desc 'Load articles from juicer'
  task :load => :environment do

    Category.all.each.do |category|
      puts "Running Juicer for #{category.name}"
      JuicerWorker.perform_async(category.id)
    end 
  end
end