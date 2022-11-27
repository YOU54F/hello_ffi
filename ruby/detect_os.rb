module DetectOS
  def self.windows?
    if (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RbConfig::CONFIG['arch']) != nil
      # puts 'detected windows'
      true
    end
  end

  def self.mac_arm?
    if (/darwin/ =~ RbConfig::CONFIG['arch']) != nil and (/arm64/ =~ RbConfig::CONFIG['arch']) != nil
      # puts 'detected macos arm'
      true
    end
  end

  def self.mac?
    if (/darwin/ =~ RbConfig::CONFIG['arch']) != nil
      # puts 'detected macos'
      true
    end
  end

  def self.linux_arm?
    if (/linux/ =~ RbConfig::CONFIG['arch']) != nil and (/arm64/ =~ RbConfig::CONFIG['arch']) != nil
      # puts 'detected linux arm'
      true
    end
  end

  def self.linux?
    if (/linux/ =~ RbConfig::CONFIG['arch']) != nil
      # puts 'detected linux'
      true
    end
  end

  def self.debug?
    if ENV['DEBUG_TARGET'] != nil
      # puts 'detected debug target' + ENV['DEBUG_TARGET']
      true
    end
  end

  def self.get_bin_path
    if debug?
      ENV['DEBUG_TARGET'].to_s
    elsif windows?
      File.expand_path("#{Dir.pwd}/pact_ffi.dll")
    elsif mac_arm?
      File.expand_path("#{Dir.pwd}/libpact_ffi.dylib")
    elsif mac?
      File.expand_path("#{Dir.pwd}/libpact_ffi.dylib")
    elsif linux_arm?
      File.expand_path("#{Dir.pwd}/libpact_ffi.so")
    elsif linux?
      File.expand_path("#{Dir.pwd}/libpact_ffi.so")
    else
      raise "Detected #{RbConfig::CONFIG['arch']}-- I have no idea what to do with that."
    end
  end
  def self.get_os
    if windows?
      'win'
    elsif mac_arm?
      'osxaarch64'
    elsif mac?
      'linux-x8664'
    elsif linux_arm?
      'linux-aarch64'
    elsif linux?
      'linux-x8664'
    else
      raise "Detected #{RbConfig::CONFIG['arch']}-- I have no idea what to do with that."
    end
  end
end

puts DetectOS.get_bin_path
