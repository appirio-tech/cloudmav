Delayed::Worker.backend = :mongoid
Delayed::Worker.logger = Rails.logger
Delayed::Worker.destroy_failed_jobs = true
Delayed::Worker.delay_jobs = !Rails.env.test?

