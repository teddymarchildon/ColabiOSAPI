#
# Be sure to run `pod lib lint ColabiOSAPI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ColabiOSAPI'
  s.version          = '0.1.0'
  s.summary          = 'Easily accessible iOS methods for accessing Innovation Colab APIs at Duke'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Anybody in the Duke Community can access these APIs when building iOS apps! Just register with the Colab to get an AccessToken, and you're all set. See the demo app for details.
                       DESC

  s.homepage         = 'https://github.com/tmarchildon/ColabiOSAPI'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lucy Zhang and Teddy Marchildon' => 'tmm61@duke.edu' }
  s.source           = { :git => 'https://github.com/tmarchildon/ColabiOSAPI.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ColabiOSAPI/Classes/**/*'
  
  s.swift_version = '3.0'
  
  # s.resource_bundles = {
  #   'ColabiOSAPI' => ['ColabiOSAPI/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
