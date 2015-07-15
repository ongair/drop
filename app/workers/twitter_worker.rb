class TwitterWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options :queue => :data, :retry => false
  recurrence { hourly }

  def perform(last_occurrence, current_occurrence)

    logger.info "Searching for twitter trends at #{Time.now}"
  end
end