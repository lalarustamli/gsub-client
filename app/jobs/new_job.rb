# frozen_string_literal: true

class NewJob < ActiveJob::Base
  queue_as(:default)
  retry_on(StandardError, wait: 5.minutes, attempts: 2, queue: :morgue)

  def perform(*args)
    puts("New Job #{args}")
  end
end
