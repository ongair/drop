# == Schema Information
#
# Table name: articles
#
#  id           :integer          not null, primary key
#  source       :string(255)
#  title        :string(255)
#  summary      :text
#  url          :string(255)
#  article_type :string(255)
#  metadata     :text
#  created_at   :datetime
#  updated_at   :datetime
#  category_id  :integer
#  external_id  :string(255)
#  image_url    :string(255)
#

class Article < ActiveRecord::Base
  validates_uniqueness_of :external_id
  belongs_to :category
end
