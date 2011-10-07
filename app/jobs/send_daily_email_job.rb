class SendDailyEmailJob
  @queue = :admin
  
  def self.perform
    AdminEmailer.daily_report.deliver
  end
  
end