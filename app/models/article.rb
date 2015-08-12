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
#

class Article < ActiveRecord::Base
  # also known as cps_id
  validates_uniqueness_of :external_id
  belongs_to :category

  scope :fresh, -> { where(archived: false) }

  paginates_per 10
end
