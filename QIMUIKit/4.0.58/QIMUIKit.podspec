
Pod::Spec.new do |s|

  s.name         = "QIMUIKit"
  s.version      = "4.0.58"
  s.summary      = "QIM App UI 9.0+ version"
  s.description  = <<-DESC
                   QIM UI

                   DESC

  s.homepage     = "https://im.qunar.com"
  s.license      = "Copyright 2018 im.qunar.com"
  s.author       = { "Qunar IM" => "qtalk@qunar.com" }

  s.source       = { :git => "https://github.com/qunarcorp/libqimuikit-ios.git", :tag=> s.version.to_s}

  s.ios.deployment_target   = '9.0'

  s.platform     = :ios, "9.0"

  s.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'DEBUGLOG=1'}
  s.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMUIKit/**\" \"${PODS_ROOT}/Headers/Public/**\""}
  $debug = ENV['debug']
  $internal = ENV['internal']

  s.subspec 'PublicUIHeader'  do |ph|
    ph.public_header_files = "QIMUIKit/QIMNotificationManager*.{h}", "QIMUIKit/QIMJumpURLHandle*.{h}", "QIMUIKit/QIMFastEntrance*.{h}", "QIMUIKit/QIMAppWindowManager*.{h}", "QIMUIKit/QIMCommonUIFramework*.*{h}", "QIMUIKit/QIMRemoteNotificationManager*.{h}"
    ph.source_files = "QIMUIKit/QIMNotificationManager*.{h,m,c,mm}", "QIMUIKit/QIMJumpURLHandle*.{h,m,c,mm}", "QIMUIKit/QIMFastEntrance*.{h,m,c,mm}", "QIMUIKit/QIMAppWindowManager*.{h,m,c,mm}", "QIMUIKit/QIMCommonUIFramework*.*{h,m,c,mm}", "QIMUIKit/QIMRemoteNotificationManager*.{h,m,c,mm}"
  end

  s.subspec 'QIMAppUIConfig' do |config|
    config.public_header_files = "QIMUIKit/QIMUIConfig/**/*.{h}"
    config.source_files = "QIMUIKit/QIMUIConfig/**/*.{h,m}"
  end
  
  s.subspec 'QIMAppUI' do |app|
    app.public_header_files = "QIMUIKit/Application/**/*.{h}"
    app.source_files = "QIMUIKit/Application/**/*.{h,m,c,mm}"
    app.dependency 'QIMUIKit/PublicUIHeader'
    app.dependency 'QIMUIKit/QIMAppUIConfig'
    app.dependency  'AlipaySDK-iOS'
    app.xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"$(PODS_ROOT)/AlipaySDK-iOS\""}

  end

  s.subspec 'QIMGeneralUI' do |generalUI|
    generalUI.public_header_files = "QIMUIKit/General/**/*.{h}"
    generalUI.source_files = "QIMUIKit/General/**/*.{h,m,c,mm}"
    generalUI.exclude_files = "QIMUIKit/General/Verders/SDWebImageWebPCoder/Classes/**/*{h,m}", "QIMUIKit/General/Verders/QIMMWPhotoBrowser/**/*{h,m}", "QIMUIKit/General/Verders/QIMSuperPlayer/**/*{h,m}"
    generalUI.dependency 'QIMUIKit/PublicUIHeader'
    generalUI.dependency 'QIMUIKit/QIMAppUIConfig'
  end

  s.subspec 'QIMMeUI' do |me|
    me.public_header_files = "QIMUIKit/Me/**/*.{h}"
    me.source_files = "QIMUIKit/Me/**/*.{h,m,c,mm}"
    me.dependency 'QIMUIKit/PublicUIHeader'
    me.dependency 'QIMUIKit/QIMAppUIConfig'
  end
    
  s.subspec 'QIMUISDK' do |uisdk|
    uisdk.public_header_files = "QIMSDK/QIMSDK/**/*.{h}"
    uisdk.source_files = "QIMSDK/QIMSDK/*.{h,m}"
    uisdk.dependency 'QIMUIKit/QIMAppUIConfig'
  end

  s.subspec 'QIMCells' do |cells|
      cells.public_header_files = "QIMUIKit/QTalkMessageBaloon/**/*.{h}"
      cells.source_files = "QIMUIKit/QTalkMessageBaloon/**/*.{h,m,c}"
      cells.resource_bundles = {'QIMSourceCode' => ['QIMUIKit/QTalkMessageBaloon/**/*.{html,js,css}']}
      cells.dependency 'QIMUIKit/PublicUIHeader'
      cells.dependency 'QIMUIKit/QIMAppUIConfig'
  end

  s.subspec 'ImagePicker' do |imagePicker|
      imagePicker.public_header_files = "QIMUIKit/QTalkImagePicker/**/*{h}"
      imagePicker.source_files = "QIMUIKit/QTalkImagePicker/**/*{h,m,c}"
      imagePicker.dependency 'QIMUIKit/PublicUIHeader'
      imagePicker.dependency 'QIMUIKit/QIMAppUIConfig'
  end

  s.subspec 'QIMMWPhotoBrowser' do |photoBrowser|
      photoBrowser.source_files = ['QIMUIKit/General/Verders/QIMMWPhotoBrowser/**/*{h,m}']
      photoBrowser.frameworks = 'ImageIO', 'QuartzCore', 'AssetsLibrary', 'MediaPlayer'
      photoBrowser.weak_frameworks = 'Photos'
      
      photoBrowser.dependency 'MBProgressHUD', '~> 0.9.2'
      photoBrowser.dependency 'DACircularProgress'
      photoBrowser.dependency 'QIMUIKit/PublicUIHeader'
      photoBrowser.dependency 'QIMUIKit/QIMAppUIConfig'
      
      # SDWebImage
      # 3.7.2 contains bugs downloading local files
      # https://github.com/rs/SDWebImage/issues/1109
      photoBrowser.dependency 'SDWebImage', '~> 5.0'
#      photoBrowser.dependency 'SDWebImageWebPCoder'
      photoBrowser.dependency 'QIMUIKit/PublicUIHeader'
      photoBrowser.resource = ['QIMUIKit/General/Verders/QIMMWPhotoBrowser/Assets']
  end

  s.subspec 'SDWebImageWebPCoder' do |sdwebp|

    sdwebp.source_files = ['QIMUIKit/General/Verders/SDWebImageWebPCoder/Classes/**/*{h,m}']
    sdwebp.xcconfig = {
      'GCC_PREPROCESSOR_DEFINITIONS' => '$(inherited) SD_WEBP=1',
      'USER_HEADER_SEARCH_PATHS' => '$(inherited) $(SRCROOT)/libwebp/src'
    }
    sdwebp.dependency 'SDWebImage/Core', '~> 5.0'

  end

  s.subspec 'QIMSuperPlayer' do |player|

    player.requires_arc = true

    player.dependency 'AFNetworking'
    player.dependency 'SDWebImage'
    player.dependency 'Masonry'
    player.dependency 'MMLayout'

    player.ios.framework    = ['SystemConfiguration','CoreTelephony', 'VideoToolbox', 'CoreGraphics', 'AVFoundation', 'Accelerate']
    player.ios.library = 'z', 'resolv', 'iconv', 'stdc++', 'c++', 'sqlite3'

    player.source_files = 'QIMUIKit/General/Verders/QIMSuperPlayer/SuperPlayer/**/*.{h,m}'
    player.private_header_files = 'QIMUIKit/General/Verders/QIMSuperPlayer/SuperPlayer/Utils/TXBitrateItemHelper.h', 'QIMUIKit/General/Verders/SuperPlayer/Views/SuperPlayerView+Private.h'
    player.resource = 'QIMUIKit/General/Verders/QIMSuperPlayer/SuperPlayer/Resource/*'
    player.vendored_framework = "QIMUIKit/General/Verders/QIMSuperPlayer/Frameworks/TXLiteAVSDK_Player.framework"

    player.frameworks = ["SystemConfiguration", "CoreTelephony", "VideoToolbox", "CoreGraphics", "AVFoundation", "Accelerate"]

    player.libraries = [
    "z",
    "resolv",
    "iconv",
    "stdc++",
    "c++",
    "sqlite3"
    ]

  end

  s.subspec 'QIMUIVendorKit' do |vendorkit|
    vendorkit.source_files = ['QIMUIVendorKit/QIMButton/**/*{h,m}', 'QIMUIVendorKit/QIMArrowView/**/*{h,m}', 'QIMUIVendorKit/QIMColorPicker/**/*{h,m,c}', 'QIMUIVendorKit/QIMDaePickerView/**/*{h,m}', 'QIMUIVendorKit/QIMGDPerformanceView/**/*{h,m}', 'QIMUIVendorKit/QIMXMenu/**/*{h,m}', 'QIMUIVendorKit/QIMPopVC/**/*{h,m}', 'QIMUIVendorKit/QIMPickerView/**/*{h,m}', 'QIMUIVendorKit/QIMUpdateView/**/*{h,m}', 'QIMUIVendorKit/QIMToast/**/*{h,m}']
#    vendorkit.source_files = ['QIMUIVendorKit/QIMButton/**/*{h,m}', 'QIMUIVendorKit/QIMArrowView/**/*{h,m}', 'QIMUIVendorKit/QIMColorPicker/**/*{h,m,c}', 'QIMUIVendorKit/QIMDaePickerView/**/*{h,m}', 'QIMUIVendorKit/QIMGDPerformanceView/**/*{h,m}', 'QIMUIVendorKit/QIMXMenu/**/*{h,m}', 'QIMUIVendorKit/QIMPopVC/**/*{h,m}', 'QIMUIVendorKit/QIMPickerView/**/*{h,m}', 'QIMUIVendorKit/QIMImagePickerController/**/*{h,m}']
    vendorkit.resource = ['QIMUIVendorKit/QIMArrowView/QIMArrowCellTableViewCell.xib', 'QIMUIVendorKit/QIMDaePickerView/QIMWSDatePickerView.xib']
#    vendorkit.resource = ['QIMUIVendorKit/QIMArrowView/QIMArrowCellTableViewCell.xib', 'QIMUIVendorKit/QIMDaePickerView/QIMWSDatePickerView.xib', 'QIMUIVendorKit/QIMImagePickerController/**/*.{bundle}']
    vendorkit.frameworks   = 'Photos'
  end


  s.subspec 'QIMNote' do |note|
    note.public_header_files = "QIMNoteUI/QTalkTodoList/**/*.{h}", "QIMNoteUI/QTEvernotes/**/*.{h}", "QIMNoteUI/QTPassword/**/*.{h}"
    note.source_files = "QIMNoteUI/**/*.{h,m,c}"
    note.resource = ["QIMNoteUI/CKEditor5.bundle", "QIMNoteUI/QTPassword/EditPasswordView.xib"]
    note.dependency 'QIMUIKit/QIMUIVendorKit'
    note.dependency 'QIMUIKit/PublicUIHeader'
    note.dependency 'QIMUIKit/QIMAppUIConfig'

  end

  s.subspec 'QIMRN' do |rn|
    rn.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'QIMRNEnable=1'}
    rn.pod_target_xcconfig = {'OTHER_LDFLAGS' => '$(inherited)'}
    rn.source_files = ['QIMRNKit/rn_3rd/**/*{h,m,c}']
    rn.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Public/QIMRNKit/**\" \"$(PODS_ROOT)/boost-for-react-native\" \"$(PODS_ROOT)/DoubleConversion\""}
    rn.resource = 'QIMRNKit/QIMRNKit.bundle'
    rn.frameworks = 'UIKit', 'Foundation'
     if $debug

     else
        rn.dependency 'QIMReactNativeLibrary', '~> 4.0'
     end
  end
  
  s.subspec 'QIMFlutter' do |flutter|
    
    flutter.source_files = ['QIMFlutter/Src/**/*{h,m,c}']
    #    flutter.xcconfig = {"FRAMEWORK_SEARCH_PATHS" => "\"${PODS_ROOT}/../flutter_service/.ios/Flutter/engine\""}
    if $debug
#      flutter.xcconfig = {"FRAMEWORK_SEARCH_PATHS" => "\"${PODS_ROOT}/../libQIMFlutterLibrary/libQIMFlutterFramework/\""}
    elsif $internal
      flutter.dependency 'QIMFlutterFramework', '~> 4.0'
      flutter.xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"$(PODS_ROOT)/QIMFlutterFramework\""}
    else

    end    
  end
  
  s.subspec 'QIMUIKit-NORN' do |norn|
#    norn.resource = ['QIMUIKit/QIMUIKitResources/片段/*', 'QIMUIKit/Application/ViewController/Login/QIMLoginViewController.xib', 'QIMUIKit/QIMUIKitResources/Audio/*', 'QIMUIKit/QIMUIKitResources/Certificate/*', 'QIMUIKit/QIMUIKitResources/Fonts/*', 'QIMUIKit/QIMUIKitResources/Stickers/*', 'QIMUIKit/QIMUIKitResources/QIMI18N.bundle', 'QIMUIKit/QIMUIKitResources/QIMUIKit.bundle']
    norn.resources = "QIMUIKit/QIMUIKitResources/片段/*", "QIMUIKit/Application/ViewController/Login/QIMLoginViewController.xib", "QIMUIKit/QIMUIKitResources/Audio/*", "QIMUIKit/QIMUIKitResources/Certificate/*", "QIMUIKit/QIMUIKitResources/Fonts/*", "QIMUIKit/QIMUIKitResources/Stickers/*", "QIMUIKit/QIMUIKitResources/QIMI18N.bundle", "QIMUIKit/QIMUIKitResources/QIMUIKit.bundle"
    norn.dependency 'QIMUIKit/PublicUIHeader'
    norn.dependency 'QIMUIKit/QIMAppUIConfig'
    norn.dependency 'QIMUIKit/QIMUISDK'
    norn.dependency 'QIMUIKit/QIMAppUI'
    norn.dependency 'QIMUIKit/QIMGeneralUI'
    norn.dependency 'QIMUIKit/QIMMeUI'
    norn.dependency 'QIMUIKit/QIMCells'
    norn.dependency 'QIMUIKit/ImagePicker'
    norn.dependency 'QIMUIKit/QIMMWPhotoBrowser'
    norn.dependency 'QIMUIKit/SDWebImageWebPCoder'
    norn.dependency 'QIMUIKit/QIMSuperPlayer'
    norn.dependency 'QIMUIKit/QIMUIVendorKit'
    norn.dependency 'QIMUIKit/QIMNote'
    norn.dependency 'QIMUIKit/QIMFlutter'

  end
  
  s.subspec 'QIMUIKit-FULL' do |full|
#    full.resource = ['QIMUIKit/QIMUIKitResources/片段/*', 'QIMUIKit/Application/ViewController/Login/QIMLoginViewController.xib', 'QIMUIKit/QIMUIKitResources/Audio/*', 'QIMUIKit/QIMUIKitResources/Certificate/*', 'QIMUIKit/QIMUIKitResources/Fonts/*', 'QIMUIKit/QIMUIKitResources/Stickers/*', 'QIMUIKit/QIMUIKitResources/QIMI18N.bundle', 'QIMRNKit/QIMRNKit.bundle', 'QIMUIKit/QIMUIKitResources/QIMUIKit.bundle']
    full.resources = "QIMUIKit/QIMUIKitResources/片段/*", "QIMUIKit/Application/ViewController/Login/QIMLoginViewController.xib", "QIMUIKit/QIMUIKitResources/Audio/*", "QIMUIKit/QIMUIKitResources/Certificate/*", "QIMUIKit/QIMUIKitResources/Fonts/*", "QIMUIKit/QIMUIKitResources/Stickers/*", "QIMUIKit/QIMUIKitResources/QIMI18N.bundle", "QIMRNKit/QIMRNKit.bundle", "QIMUIKit/QIMUIKitResources/QIMUIKit.bundle"
    full.dependency 'QIMUIKit/PublicUIHeader'
    full.dependency 'QIMUIKit/QIMAppUIConfig'
    full.dependency 'QIMUIKit/QIMUISDK'
    full.dependency 'QIMUIKit/QIMAppUI'
    full.dependency 'QIMUIKit/QIMGeneralUI'
    full.dependency 'QIMUIKit/QIMMeUI'
    full.dependency 'QIMUIKit/QIMCells'
    full.dependency 'QIMUIKit/ImagePicker'
    full.dependency 'QIMUIKit/QIMMWPhotoBrowser'
    full.dependency 'QIMUIKit/SDWebImageWebPCoder'
    full.dependency 'QIMUIKit/QIMSuperPlayer'
    full.dependency 'QIMUIKit/QIMUIVendorKit'
    full.dependency 'QIMUIKit/QIMNote'
    full.dependency 'QIMUIKit/QIMRN'
    full.dependency 'QIMUIKit/QIMFlutter'

  end
  
  s.dependency 'MJRefresh'
#  s.dependency 'YLGIFImage'
  s.dependency 'SwipeTableView'
  s.dependency 'LCActionSheet'
  s.dependency 'MDHTMLLabel'
  s.dependency 'MMMarkdown'
  s.dependency 'MGSwipeTableCell'
  s.dependency 'NJKWebViewProgress'
  s.dependency 'FDFullscreenPopGesture'
  s.dependency 'AMapSearch'
  s.dependency 'AMapLocation'
  s.dependency 'AMap3DMap'
  s.dependency 'SCLAlertView-Objective-C'
  s.dependency 'MMMarkdown'
#  s.dependency 'Toast'
  s.dependency 'YYKeyboardManager'
  s.dependency 'RTLabel'
#  s.dependency 'SuperPlayer'

  if $debug
    puts 'debug QIMUIKit'
  else
    puts '线上release QIMUIKit'
    s.dependency 'QIMCommon', '~> 4.0'
    s.dependency 'QIMGeneralModule', '~> 4.0'
  end

  s.default_subspec = 'QIMUIKit-FULL'
  s.frameworks = 'UIKit','MessageUI', 'Foundation', 'JavaScriptCore', 'AVFoundation', 'OpenGLES', 'MobileCoreServices', 'AssetsLibrary', 'QuartzCore', 'CoreMotion', 'CoreText'
  s.libraries = 'stdc++', 'bz2', 'resolv', 'icucore', 'xml2'

end
