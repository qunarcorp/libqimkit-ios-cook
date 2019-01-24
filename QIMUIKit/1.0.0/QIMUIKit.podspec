
Pod::Spec.new do |s|

  s.name         = "QIMUIKit"
  s.version      = "1.0.0"
  s.summary      = "Qunar chat App 6.0+ version QIMCommon"
  s.description  = <<-DESC
                   Qunar QIMCommon解决方案

                   DESC

  s.homepage     = "https://im.qunar.com"
  s.license      = "Copyright 2018 im.qunar.com"
  s.author       = { "Qunar IM" => "qtalk@qunar.com" }

  s.source       = { :git => "https://github.com/qunarcorp/libqimuikit-ios.git", :tag=> s.version.to_s}

  s.ios.deployment_target   = '9.0'

  s.platform     = :ios, "9.0"

  # s.public_header_files = "QIMUIKit/**/*.{h}"
# s.prefix_header_file = "QIMUIKit/QIMUIKit.pch"
  # s.public_header_files = "QIMUIKit/QIMNotificationManager*.{h}", "QIMUIKit/QIMJumpURLHandle*.{h}", "QIMUIKit/QIMFastEntrance*.{h}", "QIMUIKit/QIMAppWindowManager*.{h}", "QIMUIKit/QIMCommonUIFramework*.*{h}", "QIMUIKit/QIMRemoteNotificationManager*.{h}"
  # s.source_files = "QIMUIKit/Application/**/*.{h,m,c}", "QIMUIKit/General/**/*.{h,m,c}", "QIMUIKit/Me/**/*.{h,m,c}", "QIMUIKit/QIMNotificationManager.*", "QIMUIKit/QIMJumpURLHandle.*", "QIMUIKit/QIMFastEntrance.*", "QIMUIKit/QIMAppWindowManager.*", "QIMUIKit/QIMCommonUIFramework.*", "QIMUIKit/QIMRemoteNotificationManager.*"
  # s.vendored_libraries = "QIMCommon/QIMSDKUI/opencore-amr/lib/*.a"
  s.resources = "QIMUIKit/QIMUIKitResources/片段/*", "QIMUIKit/Application/ViewController/Login/QIMLoginViewController.xib", "QIMUIKit/QIMUIKitResources/Audio/*", "QIMUIKit/QIMUIKitResources/Certificate/*", "QIMUIKit/QIMUIKitResources/Fonts/*", "QIMUIKit/QIMUIKitResources/Stickers/*", "QIMUIKit/QIMUIKitResources/QIMUIKit.xcassets", "QIMUIKit/QIMUIKitResources/QIMI18N.bundle"
  s.xcconfig = { 'GCC_PREPROCESSOR_DEFINITIONS' => 'DEBUGLOG=1'}
  s.pod_target_xcconfig = {"HEADER_SEARCH_PATHS" => "\"${PODS_ROOT}/Headers/Private/**\" \"${PODS_ROOT}/Headers/Private/QIMUIKit/**\" \"${PODS_ROOT}/Headers/Public/**\""}
  $debug = ENV['debug']

  # non_arc_files = 'QIMUIKit/General/Verders/CoretText/NSAttributedString+Attributes.*{h}'
  # s.exclude_files = non_arc_files

  s.subspec 'PublicUIHeader'  do |ph|
    ph.public_header_files = "QIMUIKit/QIMNotificationManager*.{h}", "QIMUIKit/QIMJumpURLHandle*.{h}", "QIMUIKit/QIMFastEntrance*.{h}", "QIMUIKit/QIMAppWindowManager*.{h}", "QIMUIKit/QIMCommonUIFramework*.*{h}", "QIMUIKit/QIMRemoteNotificationManager*.{h}"
    ph.source_files = "QIMUIKit/QIMNotificationManager*.{h,m,c,mm}", "QIMUIKit/QIMJumpURLHandle*.{h,m,c,mm}", "QIMUIKit/QIMFastEntrance*.{h,m,c,mm}", "QIMUIKit/QIMAppWindowManager*.{h,m,c,mm}", "QIMUIKit/QIMCommonUIFramework*.*{h,m,c,mm}", "QIMUIKit/QIMRemoteNotificationManager*.{h,m,c,mm}"
  end

  s.subspec 'QIMAppUI' do |app|
    app.public_header_files = "QIMUIKit/Application/**/*.{h}"
    app.source_files = "QIMUIKit/Application/**/*.{h,m,c,mm}"
    app.dependency 'QIMUIKit/PublicUIHeader'
  end

  s.subspec 'QIMGeneralUI' do |generalUI|
    generalUI.public_header_files = "QIMUIKit/General/**/*.{h}"
    generalUI.source_files = "QIMUIKit/General/**/*.{h,m,c,mm}"
    generalUI.dependency 'QIMUIKit/PublicUIHeader'
  end

  s.subspec 'QIMMeUI' do |me|
    me.public_header_files = "QIMUIKit/Me/**/*.{h}"
    me.source_files = "QIMUIKit/Me/**/*.{h,m,c,mm}"
    me.dependency 'QIMUIKit/PublicUIHeader'
  end
    
    s.subspec 'QIMCells' do |cells|
        cells.public_header_files = "QIMUIKit/QTalkMessageBaloon/**/*.{h}"
        cells.source_files = "QIMUIKit/QTalkMessageBaloon/**/*.{h,m,c}"
        cells.resource_bundles = {'QIMSourceCode' => ['QIMUIKit/QTalkMessageBaloon/**/*.{html,js,css}']}
        cells.dependency 'QIMUIKit/PublicUIHeader'
    end
  
    s.subspec 'ImagePicker' do |imagePicker|
        imagePicker.public_header_files = "QIMUIKit/QTalkImagePicker/**/*{h}"
        imagePicker.source_files = "QIMUIKit/QTalkImagePicker/**/*{h,m,c}"
        imagePicker.dependency 'QIMUIKit/PublicUIHeader'
    end

    s.subspec 'QIMMWPhotoBrowser' do |photoBrowser|
        photoBrowser.source_files = ['QIMUIKit/General/Verders/QIMMWPhotoBrowser/**/*{h,m}']
        photoBrowser.frameworks = 'ImageIO', 'QuartzCore', 'AssetsLibrary', 'MediaPlayer'
        photoBrowser.weak_frameworks = 'Photos'

        photoBrowser.dependency 'MBProgressHUD', '~> 0.9'
        photoBrowser.dependency 'DACircularProgress', '~> 2.3'

        # SDWebImage
        # 3.7.2 contains bugs downloading local files
        # https://github.com/rs/SDWebImage/issues/1109
        photoBrowser.dependency 'SDWebImage', '~> 3.7', '!= 3.7.2'
        photoBrowser.dependency 'QIMUIKit/PublicUIHeader'
        photoBrowser.resource = ['QIMUIKit/General/Verders/QIMMWPhotoBrowser/Assets']
    end

    s.subspec 'QIMUIVendorKit' do |vendorkit|
      vendorkit.source_files = ['QIMUIVendorKit/QIMButton/**/*{h,m}', 'QIMUIVendorKit/QIMArrowView/**/*{h,m}', 'QIMUIVendorKit/QIMColorPicker/**/*{h,m,c}', 'QIMUIVendorKit/QIMDaePickerView/**/*{h,m}', 'QIMUIVendorKit/QIMGDPerformanceView/**/*{h,m}', 'QIMUIVendorKit/QIMXMenu/**/*{h,m}', 'QIMUIVendorKit/QIMPopVC/**/*{h,m}']
      vendorkit.resource = ['QIMUIVendorKit/QIMArrowView/QIMArrowCellTableViewCell.xib', 'QIMUIVendorKit/QIMDaePickerView/QIMWSDatePickerView.xib']
    end


    s.subspec 'QIMNote' do |note|
      note.public_header_files = "QIMNoteUI/QTalkTodoList/**/*.{h}", "QIMNoteUI/QTEvernotes/**/*.{h}", "QIMNoteUI/QTPassword/**/*.{h}"
      note.source_files = "QIMNoteUI/**/*.{h,m,c}"
      note.resource = ["QIMNoteUI/CKEditor5.bundle", "QIMNoteUI/QTPassword/EditPasswordView.xib"]
      note.dependency 'QIMUIKit/QIMUIVendorKit'
      note.dependency 'QIMUIKit/PublicUIHeader'
    end

      # 需要创建一个subspec,将mrc的文件添加到subspec中,注意如果需要的话在主spec中设置exclude_files来排除一下,不要让两个Spec都包含 mrc 的文件。
    # s.subspec 'NOARC' do |mrc|
    #     mrc.requires_arc = false
    #     mrc.public_header_files = non_arc_files
    #     mrc.source_files = non_arc_files

    #     mrc.dependency 'QIMUIKit/QIMCells'
    #     mrc.dependency 'QIMUIKit/ImagePicker'
    #     mrc.dependency 'QIMUIKit/QIMMWPhotoBrowser'
    #     mrc.dependency 'QIMUIKit/QIMNote'
    #     mrc.dependency 'QIMUIKit/QIMUIVendorKit'
    # end
    
    s.dependency 'MJRefresh'
    s.dependency 'YLGIFImage'
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
    s.dependency 'MMPickerView'
    s.dependency 'SCLAlertView-Objective-C'
    s.dependency 'MMMarkdown'
    s.dependency 'Toast'

   if $debug
    puts 'debug QIMUIKit'

  else

    puts '线上release QIMUIKit'
    s.dependency 'QIMCommon', '~> 1.beta'
    s.dependency 'QIMGeneralModule', '~> 1.beta'
  end

    s.frameworks = 'UIKit','MessageUI', 'Foundation', 'JavaScriptCore', 'AVFoundation', 'OpenGLES', 'MobileCoreServices', 'AssetsLibrary', 'QuartzCore', 'CoreMotion', 'CoreText'
    s.libraries = 'stdc++', 'bz2', 'resolv', 'icucore', 'xml2'

end
