# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/outputs/pushgateway"
require "logstash/codecs/plain"
require "logstash/event"
require "pry"
require "pry-nav"

describe LogStash::Outputs::Pushgateway do
  let(:sample_event) do
    LogStash::Event.new.tap do |e|
      e.set('attr1', 'a1')
      e.set('attr2', 'a2')
      e.set("sum"  , 1111)
    end
  end
  let(:output){ LogStash::Outputs::Pushgateway.new }

  before do
    output.instance_variable_set '@path', '/path1'
    output.instance_variable_set '@job', 'job1'
    output.instance_variable_set '@key', 'sum'
    output.instance_variable_set '@attrs', ['attr1','attr2']

    output.register

    http = Object.new
    allow(http).to receive(:post).with('/path1/job1',anything)
    output.instance_variable_set '@http', http
  end

  describe "receive message" do
    subject { output.receive(sample_event) }

    it "returns a pushgateway body" do
      expect(subject).to eq("sum{attr1=\"a1\",attr2=\"a2\"} 1111\n")
    end
  end
end
