class User < ApplicationRecord
  after_create_commit do
    ExampleJob.perform_later(self)
  end
end
