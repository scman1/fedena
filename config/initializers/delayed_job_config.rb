Delayed::Worker.destroy_failed_jobs = true
silence_warnings do
  Delayed::Worker.max_attempts = 3
  Delayed::Worker.max_run_time = 5.minutes
end