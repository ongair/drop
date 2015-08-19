# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  source       :string
#  title        :string
#  summary      :text
#  url          :string
#  article_type :string
#  metadata     :text
#  created_at   :datetime
#  updated_at   :datetime
#  category_id  :integer
#  external_id  :string
#  image_url    :string
#  body         :text
#  archived     :boolean          default(FALSE)
#  rating       :integer
#

class Article < ActiveRecord::Base
  # also known as cps_id
  validates_uniqueness_of :external_id
  belongs_to :category

  scope :fresh, -> { where(archived: false).order(created_at: :desc) }
  
  paginates_per 10

  def self.get_articles subscriber, page
    category_ids = subscriber.categories.collect { |c| c.id }
    read_ids = ArticleLog.where(subscriber_id: subscriber.id).collect { |log| log.article_id }
    if !category_ids.empty?
      Article.fresh.where(category_id: category_ids).where.not(id: read_ids).page page
    else
      Article.fresh.where.not(id: read_ids).page page
    end
  end

  def image
    url = image_url
    url = "#{Rails.application.secrets.base_url}/placeholder.png" if url.blank? 
    url
  end
end
