require 'azure'
require "azure/contrib/version"


module Azure
  module Contrib
    # Your code goes here...
  end
end

require "azure/contrib/auth/shared_access_signature"
require File.join(File.dirname(__FILE__), 'blob_service')