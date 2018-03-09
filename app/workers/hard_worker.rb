class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    Rails.logger.debug(data)
  end
end
