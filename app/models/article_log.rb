# == Schema Information
#
# Table name: article_logs
#
#  id            :integer          not null, primary key
#  article_id    :integer
#  subscriber_id :integer
#  type          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ArticleLog < ActiveRecord::Base
  belongs_to :article
  belongs_to :subscriber
end