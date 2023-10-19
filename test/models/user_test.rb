require "test_helper"

class UserTest < ActiveSupport::TestCase
  # Uncomment to fix the issue.
  # include ActiveJob::TestHelper

  test "something simple" do
    puts "___\n[#{Rails.application.config.active_job.queue_adapter}] something simple..."

    User.create(name: "John Doe", email: "john@example.com")
    assert 2 + 2, 4

    puts "something simple COMPLETE"
  end

  test "something else" do
    puts "___\n[#{Rails.application.config.active_job.queue_adapter}] something else..."

    User.create(name: "Jane Doe", email: "jane@example.com")
    assert 2 + 2, 4

    puts "something else COMPLETE"
  end

  test "without enqueue" do
    puts "___\n[#{Rails.application.config.active_job.queue_adapter}] without enqueue..."

    assert 3 + 3, 6

    puts "without enqueue COMPLETE"
  end
end
