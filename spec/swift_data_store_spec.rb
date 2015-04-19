require 'spec_helper'
require 'dragonfly/spec/data_store_examples'
require 'dragonfly/swift_data_store'

describe Dragonfly::SwiftDataStore do
  # To run these tests, put a file ".swift_spec.yml"
  # in the dragonfly root dir, like this:
  # username: XXXX,
  # api_key: XXXX,
  # authtenant: XXXX,
  # auth_url: XXXX
  # container: XXXX
  before(:each) do
    file = File.expand_path('../../.swift_spec.yml', __FILE__)
    config = YAML.load_file(file)
    @data_store = Dragonfly::SwiftDataStore.new(config)
  end

  it_should_behave_like 'data_store'
end
