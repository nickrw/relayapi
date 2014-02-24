require 'wiringpi'
require 'relayapi/gpiodriver/base'

module RelayAPI::GPIODriver
  class WiringPiPins < RelayAPI::GPIODriver::Base

    def initialize(*args)
      super *args
      @io = WiringPi::GPIO.new(WiringPi::GPIO.const_get('WPI_MODE_PINS'))
      @io.mode(@pin, OUTPUT)
    end

    def raw_read
      @io.read(@pin)
    end

    def raw_write(value)
      @io.write(@pin, value)
    end

    private

    def pin_high
      1
    end

    def pin_low
      0
    end

  end
end
