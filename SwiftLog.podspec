Pod::Spec.new do |s|
  s.name         = "SwiftLog"
  s.version      = "1.0.0"
  s.summary      = "Simple and easy logging in Swift."
  s.homepage     = "https://github.com/daltoniam/SwiftLog"
  s.license      = 'Apache License, Version 2.0'
  s.author       = {'Dalton Cherry' => 'http://daltoniam.com'}
  s.source       = { :git => 'https://github.com/daltoniam/SwiftLog.git',  :tag => "#{s.version}"}
  s.social_media_url = 'http://twitter.com/daltoniam'
  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.source_files = '*.swift'
end
