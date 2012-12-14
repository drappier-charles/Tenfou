class MainController < ApplicationController
  def index

    AMQP.start("amqp://127.0.0.1:5672") do |connection|
      channel = AMQP::Channel.new(connection)
      exchange = channel.fanout(Rails.application.config.amqp_topic)
      exchange.publish("Test publish") do
        connection.close{EventMachine.stop}
      end
    end
  end
end
