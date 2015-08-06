# == Schema Information
#
# Table name: subscriber_categories
#
#  id            :integer          not null, primary key
#  subscriber_id :integer
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class SubscriberCategory < ActiveRecord::Base
  belongs_to :subscriber
  belongs_to :category
end
