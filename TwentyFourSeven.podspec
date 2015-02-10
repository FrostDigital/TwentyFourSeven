Pod::Spec.new do |spec|
  spec.name         = 'TwentyFourSeven'
  spec.version      = '0.0.1'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = "https://github.com/dommmel/TwentyFourSeven"
  spec.authors      = { "Dominik Heier" => "dommmel@gmail.com" }
  spec.summary      = 'Schedule when your app should be allowed to go idle and when it should not'
  spec.source       = { 
    :git => 'https://github.com/dommmel/TwentyFourSeven.git', 
    :tag => spec.version.to_s 
  }
  spec.source_files = '*.swift'
  spec.ios.deployment_target = '8.0'
  spec.requires_arc = true
  spec.resource_bundle = { 'Settings' => 'ShopHours.plist' }
  spec.dependency 'NSUserDefaults+SettingsBundle', '~> 0.0.2'

end