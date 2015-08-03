# == Schema Information
#
# Table name: subscribers
#
#  id          :integer          not null, primary key
#  source      :string
#  external_id :string
#  name        :string
#  created_at  :datetime
#  updated_at  :datetime
#  provider    :string
#  uid         :string
#

class Subscriber < ActiveRecord::Base
  # validates_uniqueness_of :external_id
  validates :source, presence: true
end
