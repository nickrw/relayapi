#!/usr/bin/env ruby

module RelayAPI::API

  def self.versions
    [
      {
        'name' => 'latest',
        'path' => '/api',
        'class' => RelayAPI::API::V1
      },
      {
        'name' => 'v1',
        'path' => '/api/v1',
        'class' => RelayAPI::API::V1
      }
    ]
  end

end

require 'relayapi/api/v1'
