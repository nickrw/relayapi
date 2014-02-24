module RelayAPI::GPIODriver
  class Base

    def initialize(pin, onishigh=true)
      @on = onishigh
      @pin = pin
      @dummy_value = false
    end

    def raw_read
      @dummy_value ||= bool2hl(false)
    end

    def read
      hl2bool(raw_read)
    end

    def raw_write(value)
      @dummy_value = value
    end

    def write(value)
      raw_write(bool2hl(value)) if read != value
    end

    def toggle
      val = read
      write(!val)
    end

    private

    def pin_high
      '1'
    end

    def pin_low
      '0'
    end

    def hl2bool(hl)
      if @on
        hl == pin_high ? true : false
      else
        hl == pin_high ? false : true
      end
    end

    def bool2hl(bool)
      if @on
        bool == true ? pin_high : pin_low
      else
        bool == true ? pin_low : pin_high
      end
    end

  end
end
