require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TaskManagement
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configure cron with a hash that has a unique key for each recurring job
    config.active_job.queue_adapter = :good_job
    config.good_job.enable_cron = true
    config.good_job.cron = {
      # Every 15 minutes, enqueue `ExampleJob.set(priority: -10).perform_later(42, "life", name: "Alice")`
      urgent_task: { # each recurring job must have a unique key
        cron: "@midnight", # cron-style scheduling format by fugit gem
        class: "UrgentTaskJob", # name of the job class as a String; must reference an Active Job job class
      }
    }
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  end
end
