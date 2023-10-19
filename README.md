# README

This repo is meant as an example of the behavior I encountered after upgrading to Rails 7.1.1 in my test suite.  I've tried to find the minimal rails repo that replicates the issue.

The main issue I encountered is related to the `after_create_commit` hook in the `User` model that en-queues a job.  When running the test suite (see `user_test.rb`) the job will occasionally (once every 3-4 runs) fail because the transaction around the test will have been rolled back before the job is able to execute.  This results in an error like the following:

```
Error performing ExampleJob (Job ID: a5c9a3c0-d4ea-482b-bbc2-8e655694035f) from Async(default) in 4.5ms: ActiveJob::DeserializationError (Error while trying to deserialize arguments: Couldn't find User with 'id'=980190963)
```

In the main app I'm working on the result of this happening is that the test suite hangs indefinitely, likely waiting for the job to finish.  This might be related to the rspec setup on that project.  I was not able to replicate that in this repo, although solving the issue shown here, should solve the hanging.

## Instructions to replicate
1. Clone the repo and install the dependencies by running `bundle` in the root folder.
2. Open a terminal window and tail the test log: `tail -f log/test.log`.
3. Run the test suite using `bin/rails test`.  You might have to try it a few times before you see the error in the window with the test logs.

## What I've found
The issue does not occur when including the `ActiveJob::TestHelper` in the test case.  This (based on my understanding) sets the `active_job.queue_adapter` to `:test`.

Another solution is to set the `active_job.queue_adapter` to `:test` in the `environments/test.rb` configuration.

Additionally you can set `ActiveJob::Base.queue_adapter.immediate = true`, which tweaks the AsyncAdapter to perform all the jobs immediately.
