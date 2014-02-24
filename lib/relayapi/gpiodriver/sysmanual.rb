require 'relayapi/gpiodriver/base'

module RelayAPI::GPIODriver
  class SysManual < RelayAPI::GPIODriver::Base

    def initialize(*args)
      super *args
      if ! File.exists? "/sys/class/gpio/gpio#{@pin}"
        IO.write('/sys/class/gpio/export', @pin.to_s)
      end
      if File.exists? "/sys/class/gpio/gpio#{@pin}/direction"
        if IO.read("/sys/class/gpio/gpio#{@pin}/direction").strip != 'out'
          sleep 1
          IO.write("/sys/class/gpio/gpio#{@pin}/direction", 'out')
        end
      end
    end

    def raw_read
      IO.read("/sys/class/gpio/gpio#{@pin}/value").strip
    end

    def raw_write(value)
      IO.write("/sys/class/gpio/gpio#{@pin}/value", value)
    end

  end
end
