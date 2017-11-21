# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"

# An pushgateway output that does nothing.
class LogStash::Outputs::Pushgateway < LogStash::Outputs::Base
  config_name "pushgateway"

  public
  def register
  end # def register

  public
  def receive(event)
    return "Event received"
  end # def event
end # class LogStash::Outputs::Pushgateway
