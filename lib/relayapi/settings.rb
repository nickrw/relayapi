require 'relayapi/gpiodriver/sysmanual'

class RelayAPI::Settings

  attr_reader :devices, :driver

  def initialize
    # hard coded devices in Settings.
    # TODO: make this class get/set config in a json blob in the
    # running user's homedir
    @devices = {
      1 => {
        'name' => "Disco Ball",
        'pin' => 17,
        'highon' => false
      }
    }
    @driver = RelayAPI::GPIODriver::SysManual
    true
  end

end
