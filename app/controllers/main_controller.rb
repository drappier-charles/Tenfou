class MainController < ApplicationController
  def index
    AMQP.start(ENV['RABBITMQ_BIGWIG_URL']) do |connection|
      channel = AMQP::Channel.new(connection)
      exchange = channel.fanout(Rails.application.config.amqp_topic)
      exchange.publish("Test /") do
        connection.close{EventMachine.stop}
      end
    end
  end

  def mail
    AMQP.start(ENV['RABBITMQ_BIGWIG_URL']) do |connection|
      channel = AMQP::Channel.new(connection)
      exchange = channel.fanout(Rails.application.config.amqp_topic)
      exchange.publish("Test mail") do
        connection.close{EventMachine.stop}
      end
    end
  end
end
