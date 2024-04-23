Pod::Spec.new do |s|
  s.name = 'ObjectMapper'
  s.version = '4.4.2'
  s.license = 'MIT'
  # Ensure developers won't hit CocoaPods/CocoaPods#11402 with the resource
  # bundle for the privacy manifest.
  s.cocoapods_version = '>= 1.12.0'
  s.summary = 'JSON Object mapping written in Swift'
  s.homepage = 'https://github.com/tristanhimmelman/ObjectMapper'
  s.authors = { 'Tristan Himmelman' => 'tristanhimmelman@gmail.com' }
  s.source = { :git => 'https://github.com/tristanhimmelman/ObjectMapper.git', :tag => s.version.to_s }
  s.resource_bundle = {
    "Privacy" => "Sources/Resources/PrivacyInfo.xcprivacy"
  }
  s.watchos.deployment_target = '2.0'
  s.ios.deployment_target = '13.0'
  s.osx.deployment_target = '12.0'
  s.tvos.deployment_target = '9.0'

  s.swift_version = '5.0'

  s.requires_arc = true
  s.source_files = 'Sources/**/*.swift'
end
