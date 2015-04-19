require 'dragonfly/swift_data_store/version'
require 'openstack'
require 'dragonfly'

Dragonfly::App.register_datastore(:swift) { Dragonfly::SwiftDataStore }

module Dragonfly
  class SwiftDataStore
    def initialize(opts = {})
      %i(username api_key auth_url container).each do |p|
        fail OptionParser::MissingArgument, "#{p} should be passed to swift configuration hash" unless opts.key?(p)
      end

      fail OptionParser::MissingArgument, 'authtenant or authtenant_name or authtenant_id should passed to swift configuration hash' unless opts.key?(:authtenant) || opts.key?(:authtenant_name) || opts.key?(:authtenant_id)

      @container = opts.delete(:container)
      @connection_params = opts.merge(service_type: 'object-store')
    end

    # Store the data AND meta, and return a unique string uid
    def write(content, _opts = {})
      object_uuid = uuid
      metadata = Hash[content.meta.map { |key, value| [key, value.to_s] }]
      container.create_object(object_uuid, { metadata: metadata, content_type: content.mime_type }, content.data)
      object_uuid
    end

    # Retrieve the data and meta as a 2-item array
    def read(uid)
      object = container.object(uid)
      [
        object.data,     # can be a String, File, Pathname, Tempfile
        object.metadata  # the same meta Hash that was stored with write
      ]
    rescue OpenStack::Exception::ItemNotFound
      nil         # return nil if not found
    end

    def destroy(uid)
      container.delete_object(uid)
    rescue OpenStack::Exception::ItemNotFound
      nil
    end

    def url_for(uid, options = {})
      object = container.object(uid)
      URI::HTTP.build(scheme: options[:scheme] || connection.connection.service_scheme,
                      host: connection.connection.service_host,
                      path: "#{connection.connection.service_path}/#{object.container.name}/#{object.name}").to_s
    rescue OpenStack::Exception::ItemNotFound
      nil
    end

    private

    def container
      @_container ||= connection.container(@container)
    end

    def connection
      @_connection ||= OpenStack::Connection.create(@connection_params)
    end

    def uuid
      "#{Time.now.strftime '%Y/%m/%d/%H/%M/%S'}/#{rand(1000)}"
    end
  end
end
