require 'azure'
require 'hashie/dash'
require 'addressable/uri'

module Azure
  module Contrib
    module Auth
      class SharedAccessSignature
        class Version20130815 < Hashie::Dash
          property :resource,    default: 'b', required: true
          property :permissions, default: 'r', required: true
          property :start,       default: ''
          property :identifier,  default: ''
          property :expiry, required: true
          property :canonicalized_resource, required: true
          # Do not change this
          property :version, default: '2103-08-15'
        end

        # Create a "canonicalized resource" from the full uri to be signed
        def canonicalized_resource(uri, account = ENV['AZURE_STORAGE_ACCOUNT'])
          path = uri.path # Addressable::URI
          # There is only really one level deep for containers, the remainder is the BLOB key (that looks like a path)
          container = path.split('/').reject {|p| p == ''}.first
          ap string = File.join('/', account, container)
          string
        end

        # When creating the query string from the options, we only include the no-empty fields
        # - this is opposed to the string that gets signed which includes them as blank.
        def create_query_values(options = Version20130815.new)
          # Parts
          parts       = {}
          parts[:st]  = URI.unescape(options[:start]) unless options[:start] == ''
          parts[:se]  = URI.unescape(options[:expiry])
          parts[:sr]  = URI.unescape(options[:resource])
          parts[:sp]  = URI.unescape(options[:permissions])
          parts[:si]  = URI.unescape(options[:identifier]) unless options[:identifier] == ''
          parts[:sig] = URI.unescape( create_signature(options) )

          parts
        end

        def create_signature(options = Version20130815)
          string_to_sign  = []
          string_to_sign << options[:permissions]
          string_to_sign << options[:start]
          string_to_sign << options[:expiry]
          string_to_sign << options[:canonicalized_resource]
          string_to_sign << options[:identifier]

          Azure::Core::Auth::Signer.new.sign(string_to_sign.join("\n").encode(Encoding::UTF_8))
        end

        attr_accessor :uri, :options
        def initialize(uri, options = {}, account =  ENV['AZURE_STORAGE_ACCOUNT'])
          # This is the uri that we are signing
          @uri = Addressable::URI.parse(uri)

          # Create the options hash that will be turned into a query string
          @options = Version20130815.new(options.merge(canonicalized_resource: canonicalized_resource(@uri, account)))
        end

        def sign
          @uri.query_values = create_query_values(@options)
          @uri.to_s
        end

      end
    end
  end
end
