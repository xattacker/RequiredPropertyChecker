Pod::Spec.new do |s|
  s.name = 'RequiredPropertyChecker'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.summary = 'a Swift Combine Related component'
  s.homepage = 'https://github.com/xattacker/RequiredPropertyChecker'
  s.authors = { 'Xattacker' => 'amigo.xattacker@gmail.com' }
  s.source = { :git => 'https://github.com/xattacker/RequiredPropertyChecker.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.requires_arc = true
  s.source_files = 'RequiredPropertyChecker/Sources/*.swift'
end
