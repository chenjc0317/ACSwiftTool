#
# Be sure to run `pod lib lint ACSwiftTool.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ACSwiftTool'
  s.version          = '2.0.1'
  s.summary          = 'This is an App development tool library based on Swift language.'

  s.description      = <<-DESC
  这是一个 App 开发工具库，基于 Swift 语言。This is an App development tool library based on Swift language.
                       DESC
  s.homepage         = 'https://github.com/chenjc0317/ACSwiftTool'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chenjc0317' => 'chenjc0317@163.com' }
  s.source           = { :git => 'https://github.com/chenjc0317/ACSwiftTool.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'
  s.ios.deployment_target = '11.0'
  s.source_files = 'ACSwiftTool/Classes/**/*'
  
  # dependency
  s.dependency 'HandyJSON'
  s.dependency 'Toast-Swift'
  s.dependency 'MJRefresh'
  s.dependency 'SVProgressHUD'
  
  # s.resource_bundles = {
  #   'ACSwiftTool' => ['ACSwiftTool/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'

end
