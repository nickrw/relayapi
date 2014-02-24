#!/usr/bin/env ruby

require 'json'

module RelayAPI::API::Helpers

  def errorresponse(message=nil)
    r = {'success' => false}
    if not message.nil?
      r['message'] = message
    end
    r.to_json
  end

  def successresponse(message=nil)
    r = {'success' => true}
    if not message.nil?
      r['message'] = message
    end
    r.to_json
  end

  def device(id)
    return nil if not @settings.devices.keys.include?(id)
    return @settings.driver.new(@settings.devices[id]['pin'], @settings.devices[id]['highon'])
  end

  def onoff2bool(onoff)
    return true if onoff == 'on'
    return false if onoff == 'off'
    return nil
  end

  def bool2onoff(bool)
    return 'on' if bool == true
    return 'off' if bool == false
    return nil
  end

end
