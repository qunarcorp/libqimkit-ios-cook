Pod::Spec.new do |s|
  s.name         = "QIMOpenSSL"
  s.version      = "1.0.4"
  s.summary      = "OpenSSL for iOS"
  s.description  = "QIM Public OpenSSL is an SSL/TLS and Crypto toolkit."
  s.homepage     = "https://im.qunar.com"
  s.license      = "Copyright 2018 im.qunar.com"
  s.source       = { :git => "https://github.com/qunarcorp/libqimopenssl-ios.git", :tag => "#{s.version}"}

  s.author        = { "Qunar IM" => "qtalk@qunar.com" }

  s.ios.deployment_target = '6.0'
  s.source_files        = 'include-ios/openssl/**/*.h'
  s.public_header_files = 'include-ios/openssl/**/*.h'
  s.header_dir          = 'openssl'
  s.preserve_paths      = 'lib-ios/libcrypto.a', 'lib-ios/libssl.a'
  s.vendored_libraries  = 'lib-ios/libcrypto.a', 'lib-ios/libssl.a'

  s.libraries = 'ssl', 'crypto'
  s.requires_arc = false
  s.static_framework = true
end
