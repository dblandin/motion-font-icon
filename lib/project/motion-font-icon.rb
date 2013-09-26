class Motion
  class FontIconConfig
    attr_accessor :icon_mapper, :font
  end

  class FontIcon < UILabel
    DEFAULT_ICON_SIZE = 14.0

    class << self
      def configure
        yield config if block_given?
      end

      def config
        @config ||= FontIconConfig.new
      end
    end

    def initWithFrame(frame)
      super.tap do |label|
        label.textAlignment = NSTextAlignmentCenter
      end
    end

    def layoutSubviews
      raise ArgumentError, '`font` must be set via FontIcon.configure or FontIcon#configure' if config.font.nil?

      self.font = UIFont.fontWithName(config.font, size: DEFAULT_ICON_SIZE)
    end

    def icon=(icon)
      self.text = config.icon_mapper ? config.icon_mapper.call(icon) : icon
    end

    def font_size=(size)
      @font_size = size

      reset_font
    end

    private

    def configure
      yield config if block_given?
    end

    def config
      @config ||= self.class.config
    end

    def reset_font
      self.font = UIFont.fontWithName('dscovr', size: font_size || DEFAULT_ICON_SIZE)
    end
  end
end

