# frozen_string_literal: true

class HelloKisiJob < ActiveJob::Base
  queue_as(:default)
  retry_on(StandardError, wait: 5.minutes, attempts: 2, queue: :morgue)

  def perform(*args)
    puts("Hello Kisi #{args}")
  end
end
