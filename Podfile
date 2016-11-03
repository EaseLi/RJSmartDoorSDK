# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'RJSmartDoorSDK' do
    #pod 'Bugtags'
    pod 'ENSwiftSideMenu', '~> 0.1.1'
    pod 'Alamofire', '~> 3.0'
    pod 'SwiftyJSON', '2.4.0'
    pod 'SwiftyBeaver’,'~> 0.7'
    pod 'CryptoSwift', ‘0.5.2’
    pod 'ReachabilitySwift’,’2.3.3’ #判断网络环境
    pod 'JDStatusBarNotification’, ‘1.5.3’#消息提醒
    pod 'MJRefresh'
    pod 'SVProgressHUD'
    pod 'SDWebImage', '~>3.8'
    #pod 'NIMSDK’,’2.6.0’ #云信sdk
    pod 'Qiniu', '~> 7.1' #七牛
    pod 'IQKeyboardManagerSwift', '4.0.5'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
