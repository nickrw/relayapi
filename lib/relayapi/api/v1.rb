#!/usr/bin/env ruby

require 'relayapi/api/base'
require 'json'

class RelayAPI::API::V1 < RelayAPI::API::Base

  get '/' do
    content_type :json
    pfx = request.fullpath.sub(/\/?(\?.*)?$/,'')
    {
      'endpoints' => {
        "#{pfx}/devices" => { 'methods' => ['GET'] },
        "#{pfx}/devices/:id" => { 'methods' => ['GET'] },
        "#{pfx}/devices/:id/:state" => { 'methods' => ['PUT']}
      },
      'versions' => RelayAPI::API.versions.map { |version|
        {'name' => version['name'], 'path' => version['path']}
      }
    }.to_json
  end

  get '/devices/?' do
    content_type :json
    {
      'devices' =>
        @settings.devices.map {|key, value| 
          dev = device(key)
          state = bool2onoff(dev.read)
          {
            'id' => key,
            'name' => value['name'],
            'path' => request.fullpath.sub(/\?.*$/,'').sub(/\/?$/, "/#{key}"),
            'state' => state
          }
        }
    }.to_json
  end

  get '/devices/:id/?' do
    content_type :json
    id = params[:id].to_i
    dev = device(id)
    return errorresponse("Invalid device id provided") if dev.nil?
    {
      'id' => id,
      'name' => @settings.devices[id]['name'],
      'path' => request.fullpath.sub(/\?.*$/,''),
      'state' => bool2onoff(dev.read)
    }.to_json
  end

  put '/devices/:id/:state/?' do
    content_type :json
    id = params[:id].to_i
    dev = device(id)
    return errorresponse("Invalid device id provided") if dev.nil?
    if not ['on', 'off'].include?(params[:state])
      return errorresponse("Invalid state provided. Expecting 'on' or 'off'.")
    end
    state = onoff2bool(params[:state])
    if dev.read == state
      return errorresponse("Device is already #{params[:state]}")
    end
    dev.write(state)
    successresponse("Device turned #{params[:state]}")
  end

end
