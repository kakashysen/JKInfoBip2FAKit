#
# Be sure to run `pod lib lint JKInfoBip2FAKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKInfoBip2FAKit'
  s.version          = '0.1.2'
  s.summary          = 'Library to use Info Bip 2 Factor Authentication API'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
This is a simple library to use Info Bip 2 Factors Authentication API writed in Objective-C
NOTE: This library is neither associated with nor supported by Infobip. API changes may occur at anytime, so I give no guarantees if something breaks or doesn't work. I will do my best to update this library. Bugfixes, improvements, and pull requests are welcome!
                       DESC

  s.homepage         = 'https://github.com/kakashysen/JKInfoBip2FAKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jose Aponte' => 'joseapontec@gmail.com' }
  s.source           = { :git => 'https://github.com/kakashysen/JKInfoBip2FAKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'http://twitter.com/kakashy'

  s.ios.deployment_target = '7.1'

  s.source_files = 'JKInfoBip2FAKit/Classes/*.{h,m}', 'JKInfoBip2FAKit/Models/*.{h,m}'
  
  # s.resource_bundles = {
  #   'JKInfoBip2FAKit' => ['JKInfoBip2FAKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '3.0.0'
end
