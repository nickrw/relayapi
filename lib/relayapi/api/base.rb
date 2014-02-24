#!/usr/bin/env ruby

require 'sinatra/base'
require 'json'
require 'relayapi/settings'
require 'relayapi/api/helpers'

class RelayAPI::API::Base < Sinatra::Base

  helpers RelayAPI::API::Helpers

  def initialize
    super
    @settings = RelayAPI::Settings.new
    @settings.devices.each do |id, params|
      dev = device(id)
      dev.write(false)
    end
  end

end
