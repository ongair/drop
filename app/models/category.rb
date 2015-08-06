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
#

class Category < ActiveRecord::Base
  validates_uniqueness_of :name
  
  has_many :articles
end
