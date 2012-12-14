require 'rubygems'
require 'amqp'

namespace :amqp do
  desc "Listener AMQP"
  task :listener => :environment do
    AMQP.start("amqp://127.0.0.1:5672") do |connection|
      channel = AMQP::Channel.new(connection)
      exchangeMessage = channel.fanout(Rails.application.config.amqp_topic)
      channel.queue(Rails.application.config.amqp_queue, :auto_delete => true).bind(exchangeMessage,:routing_key => "message.mail").subscribe do |payload|
        puts "Message : #{payload}"
      end
      #channel.queue(Rails.application.config.amqp_queue, :auto_delete => true).bind(exchangeMessage,:routing_key => "message.mail").subscribe do |payload|
      #  puts "Mail : #{payload}"
      #end
    end
  end
end