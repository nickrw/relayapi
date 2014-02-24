#!/usr/bin/env ruby

require 'sinatra/base'

class RelayAPI::Web < Sinatra::Base
  get '/' do
    "Try <a href='/api'>/api</a>"
  end
end
