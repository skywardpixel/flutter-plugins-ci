#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint battery.podspec' to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'battery'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for accessing information about the battery.'
  s.description      = <<-DESC
A Flutter plugin to access various information about the battery of the device the app is running on.
Downloaded by pub (not CocoaPods).

This is a modified version for PoC.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :type => 'BSD', :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :http => 'https://github.com/kaichengyan/flutter-plugins-ci/tree/master/packages/battery' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '8.0'

  # Flutter.framework does not contain a i386 slice. Only x86_64 simulators are supported.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'VALID_ARCHS[sdk=iphonesimulator*]' => 'x86_64' }
  s.swift_version = '5.0'

  s.test_spec 'Tests' do |test_spec|
    test_spec.source_files = 'Tests/**/*'
  end
end
