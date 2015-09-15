# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string
#  source      :string
#  keywords    :text
#  created_at  :datetime
#  updated_at  :datetime
#  metadata    :text
#  description :text
#  parent_id   :integer
#  enabled     :boolean          default(TRUE)
#  image_uid   :string
#  image_name  :string
#  logo        :text
#

class Category < ActiveRecord::Base
  validates_uniqueness_of :name
  
  has_many :articles
  dragonfly_accessor :image
  scope :enabled, -> { where(enabled: true) }

  def image_url
    image.try(:url)
  end

  def self.featured
    category = Category.find_or_create_by!(name: 'Featured', enabled: false)
  end
end
