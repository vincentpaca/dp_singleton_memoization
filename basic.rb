class YaBasic

  @@instance = YaBasic.new

  def speak
    'Wah lao eh!'
  end

  private_class_method :new

  class << self
    def instance
      @@instance
    end
  end

end
