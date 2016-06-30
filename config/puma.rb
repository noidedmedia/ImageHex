if ENV.fetch("RAILS_ENV") { "development" } != "development"
  threads_count = Integer(ENV["RAILS_MAX_THREADS"] || 5)
  workers Integer(ENV['WEB_CONCURRENCY'] || 2)
  threads threads_count, threads_count

  preload_app!

  rackup DefaultRackup
  port ENV['PORT'] || 3000
  environment ENV['RACK_ENV']

  on_worker_boot do
    ActiveRecord::Base.establish_connection
  end

end
