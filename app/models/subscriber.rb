# == Schema Information
#
# Table name: subscribers
#
#  id                 :integer          not null, primary key
#  name               :string
#  created_at         :datetime
#  updated_at         :datetime
#  provider           :string
#  uid                :string
#  sign_in_count      :integer
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :string
#  last_sign_in_ip    :string
#

class Subscriber < ActiveRecord::Base
  validates_uniqueness_of :uid
  validates :provider, presence: true  

  has_many :subscriber_categories
  has_many :categories, through: :subscriber_categories

  # track how often they subscribe
  devise :trackable
end
