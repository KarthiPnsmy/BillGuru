class Payment < ActiveRecord::Base
   belongs_to :reminder

  def self.send_notifications
    logger.info "hi this is from whenever gem -------->"
    logger.info Time.now.tologger_s
  end
end
