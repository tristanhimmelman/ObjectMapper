Pod::Spec.new do |s|
  s.name = 'ObjectMapper'
  s.version = '0.15'
  s.license = 'MIT'
  s.summary = 'JSON Object mapping written in Swift'
  s.homepage = 'https://github.com/Hearst-DD/ObjectMapper'
  s.authors = { 'Tristan Himmelman' => 'tristanhimmelman@gmail.com' }
  s.source = { :git => 'https://github.com/Hearst-DD/ObjectMapper.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = 'true'
  s.source_files = 'ObjectMapper/**/*.swift'
end
