# == Schema Information
#
# Table name: categories
#
#  id           :integer          not null, primary key
#  name         :string
#  source       :string
#  keywords     :text
#  created_at   :datetime
#  updated_at   :datetime
#  metadata     :text
#  description  :text
#  parent_id    :integer
#  enabled      :boolean          default(TRUE)
#  image_uid    :string
#  image_name   :string
#  logo         :text
#  subdirectory :string
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

  def self.category_from_url url
    category = nil
    Category.enabled.where.not(subdirectory: nil).each do |cat|      
      cat.subdirectory.split(',').each do |dir|
        filter = /#{Regexp.quote(dir)}/
        if url.match(filter) && category.nil?
          category = cat
        end
      end
    end
    return category
  end
end
