require 'wechat'
class WechatTokenWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options :queue => :wechat, :retry => false
  recurrence { hourly }

  def perform(last_occurrence, current_occurrence)
    logger.info "Renewing WeChat token"

    client = Wechat::Client.new(Rails.application.secrets.wechat_app_id,Rails.application.secrets.wechat_app_secret, "<dummy>")
    tokens = client.get_token

    Token.create! source: "WeChat", value: tokens.first, expiry: tokens.last.seconds.from_now    

  end
end