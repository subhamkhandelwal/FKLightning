#
# Be sure to run `pod lib lint FKLightning.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FKLightning"
  s.version          = "0.1.2"
  s.summary          = "This library is to find weighted internet speed."
  s.description      = "One can use this pod to calculate and use weighted internet speed."
  s.homepage         = "https://github.com/subhamkhandelwal/FKLightning"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Subham Khandelwal" => "subhamkhandelwal@yahoo.co.in" }
  s.source           = { :git => "https://github.com/subhamkhandelwal/FKLightning.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files      = 'Example/Classes/*.{m,h}'
  s.resource_bundles = {
    'FKLightning' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
