Pod::Spec.new do |s|
  s.name         = "SimpleCocoaAnalytics"
  s.version      = "0.1.0"
  s.summary      = "A simple set of classes of using Google Analytics to track your OS X app."
  s.homepage     = "https://github.com/stephenlind/SimpleCocoaGoogleAnalytics"
  s.license      = { :type => "MIT", :file => "LICENSE.md" }
  s.author       = { "stephenlind" => "" }
  s.source       = { :git => "https://github.com/stephenlind/SimpleCocoaGoogleAnalytics.git",
                     :tag => "#{s.version}" }
  s.platform     = :osx
  s.source_files = "SimpleCocoaAnalytics/Analytics*.{h,m}"
  s.requires_arc = true
end
