# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  source      :string(255)
#  keywords    :text
#  created_at  :datetime
#  updated_at  :datetime
#  metadata    :text
#  description :text
#

class Category < ActiveRecord::Base
  validates_uniqueness_of :name
  has_many :articles
end
