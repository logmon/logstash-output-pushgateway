# encoding: utf-8
require "logstash/outputs/base"
require "logstash/namespace"
require "net/http"

# An pushgateway output that does nothing.
class LogStash::Outputs::Pushgateway < LogStash::Outputs::Base
  config_name "pushgateway"
  config :host , validate: :string, default: 'pushgateway'
  config :port , validate: :number, default: 9091
  config :path , validate: :string, default: '/metrics/job'
  config :job  , validate: :string, default: 'logevent'
  config :attrs, validate: :array , default: ['instance']
  config :key  , validate: :string

  public
  def register
    @http = Net::HTTP.new @host, @port
  end # def register

  public
  def receive(event)
    if value = event.get(@key)
      attr_str = @attrs.sort.map do |attr|
        v = event.get(attr)
        v.nil? ? nil : sprintf('%s="%s"', attr.split('.').last, v)
      end.compact.join(',')

      metric = sprintf("%s{%s}", @key.split('.').last, attr_str)

      body = sprintf("%s %s\n", metric, value)

      @http.post "#{@path}/#{@job}", body
      body
    else
      "Event received"
    end
  end # def event
end # class LogStash::Outputs::Pushgateway
