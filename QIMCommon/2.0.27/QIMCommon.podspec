Pod::Spec.new do |s|

  s.name         = "QIMCommon"
  s.version      = "2.0.27"
  s.summary      = "Qunar chat App 9.0+ version QIMCommon"
  s.description  = <<-DESC
                   Qunar QIMPubCommon解决方案

                   DESC

  s.homepage     = "https://im.qunar.com"
  s.license      = "Copyright 2018 im.qunar.com"
  s.author        = { "Qunar IM" => "qtalk@qunar.com" }

  s.source       = { :git => "https://github.com/qunarcorp/libQIMCommon-iOS.git", :tag=> s.version.to_s}

  s.ios.deployment_target   = '9.0'
  s.resource_bundles = {'QIMCommonResource' => ['QIMCommon/QIMKitCommonResource/*.{png,aac,caf,pem,wav}']}

  s.platform     = :ios, "9.0"
  
  s.subspec 'QIMPrivatePBCommon' do |pbcommon|
    pbcommon.source_files = 'QIMCommon/QIMPrivatePBCommonFramework/Headers/**/*.{h,m,c}'
    pbcommon.vendored_libraries = ['QIMCommon/QIMPrivatePBCommonFramework/Frameworks/libQIMPrivatePBCommon.a']
    pbcommon.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\""}
  end
  
  s.subspec 'Base' do |base|
    $lib = ENV['use_lib']
    $debug = ENV['debug']
    if $lib
      
      puts '---------QIMCommonSDK二进制-------'
      base.source_files = 'ios_libs/Headers/**/*.h'
      base.vendored_libraries = ['ios_libs/Frameworks/libQIMCommon.a']
      base.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\""}
      
      else
      
      puts '---------QIMCommonSDK源码-------'
      base.public_header_files = "QIMCommon/QIMKit/**/*.{h}", "QIMCommon/QIMDB/**/*.{h}"
      
      base.source_files = "QIMCommon/Source/**/*.{h,m,c}", "QIMCommon/QIMKit/**/*.{h,m,c}", "QIMCommon/QIMDB/**/*.{h,m,mm}"
      base.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'DEBUGLOG=1'}
      base.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\" \"${PODS_ROOT}/Headers/Public/QIMCommon/**\""}
    end
  end
  s.requires_arc = false
  s.requires_arc = ['QIMCommon/Source/**/*', "QIMCommon/QIMKit/**/*.{h,m,c}"]
  if $debug
    puts 'debug QIMPubCommon依赖第三方库'
    s.dependency 'QIMOpenSSL'
    s.default_subspecs = 'Base'

  else
  
    puts '线上release QIMPubCommon依赖第三方库'
    s.dependency 'QIMOpenSSL'
    s.dependency 'QIMKitVendor', '~> 2.0'
    s.dependency 'QIMDataBase', '~> 2.0'
    s.default_subspecs = 'Base', 'QIMPrivatePBCommon'
  end
  
  s.dependency 'ASIHTTPRequest'
  s.dependency 'YYCache'
  s.dependency 'YYModel'
  s.dependency 'ProtocolBuffers'
  s.dependency 'CocoaAsyncSocket'
  s.dependency 'UICKeyChainStore'
  s.dependency 'YYDispatchQueuePool'
  # 避免崩溃
  s.dependency 'AvoidCrash'
  
  s.dependency 'CocoaLumberjack'
  s.dependency 'WCDB'

  s.frameworks = 'Foundation', 'CoreTelephony', 'SystemConfiguration', 'AudioToolbox', 'AVFoundation', 'UserNotifications', 'CoreTelephony','QuartzCore', 'CoreGraphics', 'Security'
  s.libraries = 'stdc++', 'bz2'

end
