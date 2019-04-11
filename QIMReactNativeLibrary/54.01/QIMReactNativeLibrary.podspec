# coding: utf-8
require "json"

folly_compiler_flags = '-DFOLLY_NO_CONFIG -DFOLLY_MOBILE=1 -DFOLLY_USE_LIBCPP=1'

Pod::Spec.new do |s|

  s.name         = "QIMReactNativeLibrary"
  s.version      = "54.01"
  s.summary      = "Qunar chat App 6.0+ version QIMCommon"
  s.description  = <<-DESC
                   Qunar QIMCommon解决方案

                   DESC

  s.homepage     = "https://im.qunar.com"
  s.license      = "Copyright 2018 im.qunar.com"
  s.author        = { "Qunar IM" => "qtalk@qunar.com" }

  s.source       = { :git => "https://github.com/qunarcorp/QIMReactNativeLibrary.git", :tag=> s.version.to_s}

  s.ios.deployment_target   = '8.0'

  s.platform     = :ios, "8.0"
  s.header_dir = "React"

  s.pod_target_xcconfig     = { "CLANG_CXX_LANGUAGE_STANDARD" => "c++14" }

  s.subspec "yoga" do |yoga|
    yoga.header_dir           = "yoga"
    yoga.requires_arc = false
    yoga.compiler_flags = [
    '-fno-omit-frame-pointer',
    '-fexceptions',
    '-Wall',
    '-Werror',
    '-std=c++1y',
    '-fPIC'
    ]
    # Set this environment variable when not using the `:path` option to install the pod.
    # E.g. when publishing this spec to a spec repo.
    source_files = 'ReactCommon/yoga/**/*.{cpp,h}'
    source_files = File.join('ReactCommon/yoga', source_files) if ENV['INSTALL_YOGA_WITHOUT_PATH_OPTION']
    yoga.source_files = source_files
  end

  s.subspec "Core" do |ss|
    ss.dependency  'QIMReactNativeLibrary/yoga'
    ss.source_files         = "react-native/React/**/*.{c,h,m,mm,S,cpp}"
    ss.exclude_files        = "**/__tests__/*",
                              "IntegrationTests/*",
                              "react-native/React/DevSupport/*",
                              "react-native/React/Inspector/*",
                              "ReactCommon/yoga/*",
                              "react-native/React/Cxx*/*",
    ss.ios.exclude_files    = "react-native/React/**/RCTTV*.*"
    ss.header_dir           = "React"
    ss.framework            = "JavaScriptCore"
    ss.libraries            = "stdc++"
    ss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)/ReactCommon\"" }
  end

  s.subspec "CxxBridge" do |ss|
    ss.dependency             "Folly", "2016.09.26.00"
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.dependency             'QIMReactNativeLibrary/cxxreact'
    ss.compiler_flags       = folly_compiler_flags
    ss.private_header_files = "react-native/React/Cxx*/*.h"
    ss.source_files         = "react-native/React/Cxx*/*.{h,m,mm}"
  end

  s.subspec "DevSupport" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.dependency             'QIMReactNativeLibrary/RCTWebSocket'
    ss.source_files         = "react-native/React/DevSupport/*",
                              "react-native/React/Inspector/*"
  end

  s.subspec "jschelpers" do |ss|
    ss.dependency             "Folly", "2016.09.26.00"
    ss.dependency             'QIMReactNativeLibrary/PrivateDatabase'
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "ReactCommon/jschelpers/*.{cpp,h}"
    ss.private_header_files = "ReactCommon/jschelpers/*.h"
    ss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)/ReactCommon\"" }
    ss.framework            = "JavaScriptCore"
  end

  s.subspec "jsinspector" do |ss|
    ss.source_files         = "ReactCommon/jsinspector/*.{cpp,h}"
    ss.private_header_files = "ReactCommon/jsinspector/*.h"
    ss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)/ReactCommon\"" }
  end

  s.subspec "PrivateDatabase" do |ss|
    ss.source_files         = "ReactCommon/privatedata/*.{cpp,h}"
    ss.private_header_files = "ReactCommon/privatedata/*.h"
    ss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)/ReactCommon\"" }
  end

  s.subspec "cxxreact" do |ss|
    ss.dependency             'QIMReactNativeLibrary/jschelpers'
    ss.dependency             'QIMReactNativeLibrary/jsinspector'
    ss.dependency             'boost-for-react-native', "1.63.0"
    ss.dependency             "Folly", "2016.09.26.00"
    ss.compiler_flags       = folly_compiler_flags
    ss.source_files         = "ReactCommon/cxxreact/*.{cpp,h}"
    ss.exclude_files        = "ReactCommon/cxxreact/SampleCxxModule.*"
    ss.private_header_files = "ReactCommon/cxxreact/*.h"
    ss.pod_target_xcconfig  = { "HEADER_SEARCH_PATHS" => "\"$(PODS_TARGET_SRCROOT)/ReactCommon\" \"$(PODS_ROOT)/boost-for-react-native\" \"$(PODS_ROOT)/DoubleConversion\" \"$(PODS_ROOT)/Folly\"" }
  end

  s.subspec "ART" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/ART/**/*.{h,m}"
  end

  s.subspec "RCTActionSheet" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/ActionSheetIOS/*.{h,m}"
  end

  s.subspec "RCTAnimation" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/NativeAnimation/{Drivers/*,Nodes/*,*}.{h,m}"
    ss.header_dir           = "RCTAnimation"
  end

  s.subspec "RCTBlob" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/Blob/*.{h,m,mm}"
    ss.preserve_paths       = "react-native/Libraries/Blob/*.js"
  end

  s.subspec "RCTGeolocation" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/Geolocation/*.{h,m}"
  end

  s.subspec "RCTImage" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.dependency             'QIMReactNativeLibrary/RCTNetwork'
    ss.source_files         = "react-native/Libraries/Image/*.{h,m}"
  end

  s.subspec "RCTNetwork" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/Network/*.{h,m,mm}"
  end

  s.subspec "RCTSettings" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/Settings/*.{h,m}"
  end

  s.subspec "RCTText" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/Text/**/*.{h,m}"
  end

  s.subspec "RCTVibration" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/Vibration/*.{h,m}"
  end

  s.subspec "RCTWebSocket" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.dependency             'QIMReactNativeLibrary/RCTBlob'
    ss.dependency             'QIMReactNativeLibrary/fishhook'
    ss.source_files         = "react-native/Libraries/WebSocket/*.{h,m}"
  end

  s.subspec "fishhook" do |ss|
    ss.header_dir           = "fishhook"
    ss.source_files         = "react-native/Libraries/fishhook/*.{h,c}"
  end

  s.subspec "RCTLinkingIOS" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/LinkingIOS/*.{h,m}"
  end

  s.subspec "RCTTest" do |ss|
    ss.dependency             'QIMReactNativeLibrary/Core'
    ss.source_files         = "react-native/Libraries/RCTTest/**/*.{h,m}"
    ss.frameworks           = "XCTest"
  end


  s.subspec "RNSVG" do |ss|
    ss.source_files     = 'react-native-svg/ios/**/*.{h,m}'
    ss.requires_arc     = true
    ss.dependency       'QIMReactNativeLibrary/Core'
  end

  s.subspec "react-native-image-picker" do |ss|
    ss.source_files  = "react-native-image-picker/ios/*.{h,m}"
    ss.dependency       'QIMReactNativeLibrary/Core'
  end

  s.subspec "RNVectorIcons" do |ss|
    ss.source_files   = 'react-native-vector-icons/RNVectorIconsManager/**/*.{h,m}'
    ss.resources      = "react-native-vector-icons/Fonts/*.ttf"
    ss.preserve_paths = "react-native-vector-icons/**/*.js"
    ss.dependency       'QIMReactNativeLibrary/Core'
  end

  s.default_subspecs = 'Core', 'CxxBridge', 'DevSupport', 'jschelpers', 'jsinspector', 'PrivateDatabase', 'cxxreact', 'ART', 'RCTActionSheet', 'RCTAnimation', 'RCTBlob', 'RCTGeolocation', 'RCTImage', 'RCTNetwork', 'RCTSettings', 'RCTText', 'RCTVibration', 'RCTWebSocket', 'RCTLinkingIOS', 'RNSVG', 'react-native-image-picker', 'RNVectorIcons' 

end
