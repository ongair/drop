class WhatsappWorker
  include Sidekiq::Worker

  sidekiq_options :queue => :whatsapp, :retry => false

  def perform(phone_number, message)

    url = Rails.application.secrets.ongair_url 
    token = Rails.application.secrets.ongair_token 

    response = HTTParty.post(url, body: { token: token, phone_number: phone_number, text: message, thread: true }, debug_output: $stdout)
  end

end