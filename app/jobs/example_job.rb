class ExampleJob < ApplicationJob
  queue_as :default

  def perform(user)
    # example of a job that takes some time.
    puts "Starting Job for #{user.name}"
    sleep 1
    puts "Completed Job for #{user.name}"
  end
end
