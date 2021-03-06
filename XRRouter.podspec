#
# Be sure to run `pod lib lint XRRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'XRRouter'
  s.version          = '0.1.0'
  s.summary          = 'A Router for iOS APP'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = '多模块路由通讯框架,为组件化提供良好的解决方案'

  s.homepage         = 'https://github.com/wangshuwen1107/XRRouter-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wangshuwen' => 'wnwn7375@outlook.com' }
  s.source           = { :git => 'https://github.com/wangshuwen1107/XRRouter-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'XRRouter/Classes/**/*'
  
  # s.resource_bundles = {
  #   'XRouter' => ['XRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

end
