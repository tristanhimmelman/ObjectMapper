Pod::Spec.new do |s|
  s.name         = "Nimble"
  s.version      = "2.0.0-rc.3"
  s.summary      = "A Matcher Framework for Swift and Objective-C"
  s.description  = <<-DESC
                   Use Nimble to express the expected outcomes of Swift or Objective-C expressions. Inspired by Cedar.
                   DESC
  s.homepage     = "https://github.com/Quick/Nimble"
  s.license      = { :type => "Apache 2.0", :file => "LICENSE.md" }
  s.author       = "Quick Contributors"
  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"
  s.source       = { :git => "https://github.com/Quick/Nimble.git", :tag => "v#{s.version}" }

  s.source_files = "Nimble", "Nimble/**/*.{swift,h,m}"
  s.weak_framework = "XCTest"
  s.requires_arc = true
  s.pod_target_xcconfig = { 'ENABLE_BITCODE' => 'NO', 'OTHER_LDFLAGS' => '-weak-lswiftXCTest', 'FRAMEWORK_SEARCH_PATHS' => '$(inherited) "$(PLATFORM_DIR)/Developer/Library/Frameworks"' }
end
