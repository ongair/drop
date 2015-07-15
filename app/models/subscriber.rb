# == Schema Information
#
# Table name: subscribers
#
#  id          :integer          not null, primary key
#  source      :string(255)
#  external_id :string(255)
#  name        :string(255)
#  metadata    :text
#  created_at  :datetime
#  updated_at  :datetime
#

class Subscriber < ActiveRecord::Base
  # validates_uniqueness_of :external_id
  validates :source, presence: true
end
