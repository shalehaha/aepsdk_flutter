Pod::Spec.new do |s|
  s.name             = 'flutter_aepedgeconsent'
  s.version          = '1.0.0'
  s.summary          = 'Adobe Experience Platform Consent Collection support for Flutter apps.'
  s.homepage         = 'https://aep-sdks.gitbook.io/docs/'
  s.license          = { :file => '../LICENSE' }
  s.author           = 'Adobe Mobile SDK Team'
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'AEPEdgeConsent', '~> 1.0'
  s.platform = :ios, '10.0'
  s.static_framework = true

end
