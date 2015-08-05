# == Schema Information
#
# Table name: sources
#
#  id         :integer          not null, primary key
#  name       :string
#  active     :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  juicer_id  :string
#

class Source < ActiveRecord::Base
  scope :active, -> { where(active: true) }
end
