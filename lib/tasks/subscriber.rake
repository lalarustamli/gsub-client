# frozen_string_literal: true

namespace(:subscriber) do
  desc("Run the subscriber")
  task(run: :environment) do
    # See https://googleapis.dev/ruby/google-cloud-pubsub/latest/index.html

    puts("Subscriber starting...")
    listen

    # Block, letting processing threads continue in the background
    sleep
  end

  private

  def listen
    Rails.application.config.pubsub_client.start_listening
  end
end
