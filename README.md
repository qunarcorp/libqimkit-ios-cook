# QTalk IM SDK
## 概述
提供im通讯能力，包含单聊、群聊，通知推送。支持发送文本、图片、表情、语音、文件、地理位置….支持音视频通话。
## 项目结构

* QIMCommonCategories (扩展类组件)
* QIMDataBase (数据库组件，依赖sqlite3)
* QIMOpenSSL (UI模块)

## 集成

### CocoaPods
1. Add `source 'https://github.com/qunarcorp/libqimkit-ios-cook.git'`
2. Add `pod 'QIMDataBase'` to your Podfile.
3. Add `pod 'QIMOpenSSL'` to your Podfile.
4. Add `pod 'QIMCommonCategories'` to your Podfile.
5. Run `pod install` or `pod update`.

## 问题反馈

-   qchat@qunar.com（邮件）
