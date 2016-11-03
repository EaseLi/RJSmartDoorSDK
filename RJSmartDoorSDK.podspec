Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '8.0'
s.name = "RJSmartDoorSDK"
s.summary = "RJSmartDoorSDK change live."
s.requires_arc = true

s.version = "0.1.2"
# 3
s.license = { :type => "MIT", :file => "LICENSE" }
# 4 - Replace with your name and e-mail address
s.author = { "lizeyan" => "lizeyan@ruijiating.com" }
# For example,
# s.author = { "Joshua Greene" => "jrg.developer@gmail.com" }
# 5 - Replace this URL with your own Github page's URL (from the address bar)
s.homepage = "http://www.ruijiating.com"
# For example,
# s.homepage = "https://github.com/JRG-Developer/RWPickFlavor"
# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/EaseLi/RJSmartDoorSDK.git", :tag => "#{s.version}"}
# For example,
# s.source = { :git => "https://github.com/JRG-Developer/RWPickFlavor.git", :tag => "#{s.version}"}
# 7
s.framework = "UIKit"
s.dependency 'Alamofire', '~> 3.0'
s.dependency 'ENSwiftSideMenu', '~> 0.1.1'
s.dependency 'SwiftyJSON', '2.4.0'
s.dependency 'SwiftyBeaver', '~> 0.7'
s.dependency 'CryptoSwift', '0.5.2'
s.dependency 'ReachabilitySwift', '2.3.3'
s.dependency 'JDStatusBarNotification', '1.5.3'
s.dependency 'MJRefresh'
s.dependency 'SVProgressHUD'
s.dependency 'SDWebImage', '~>3.8'
s.dependency 'Qiniu', '~> 7.1'
s.dependency 'IQKeyboardManagerSwift', '4.0.5'

# 8
s.source_files = "RJSmartDoorSDK/**/*.{swift}"
# 9
s.resources = "RJSmartDoorSDK/**/*.{png,jpeg,jpg,storyboard,xib}"

end
