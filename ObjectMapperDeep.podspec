Pod::Spec.new do |s|
  s.name = 'ObjectMapperDeep'
  s.version = '0.14.2'
  s.license = 'MIT'
  s.summary = 'JSON Object mapping written in Swift, support deep array mapping'
  s.homepage = 'https://github.com/tonyli508/ObjectMapperDeep'
  s.social_media_url = 'https://twitter.com/tonyli508'
  s.authors = { 'Li Jiantang' => 'tonyli508@gmail.com' }
  s.source = { :git => 'https://github.com/tonyli508/ObjectMapperDeep.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.9'
  s.requires_arc = 'true'
  s.source_files = 'ObjectMapper/**/*.swift'
end
