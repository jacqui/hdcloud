#!/usr/bin/env ruby
require 'httparty'

gem 'httparty', '~> 0.5.2'
require 'httparty'

module HDCloud
  class HDCloudError < StandardError
    attr_reader :data

    def initialize(data)
      @data = data
      super
    end
  end

  class Unauthorized      < HDCloudError; end
  class General           < HDCloudError; end

  class Unavailable   < StandardError; end
  class NotFound      < StandardError; end
end

directory = File.expand_path(File.dirname(__FILE__))

require File.join(directory, 'hdcloud', 'base')
