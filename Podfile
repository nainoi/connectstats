source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
target 'ConnectStats' do
  use_frameworks!
  pod 'GoogleMaps', :inhibit_warnings => true
  pod 'Flurry-iOS-SDK/FlurrySDK'
  pod 'GenericJSON'
  pod 'Armchair', '>= 0.3', :inhibit_warnings => true
end
target 'HealthStats' do
  use_frameworks!
  pod 'GoogleMaps', :inhibit_warnings => true
  pod 'Flurry-iOS-SDK/FlurrySDK'
  pod 'GenericJSON'
  pod 'Armchair', '>= 0.3', :inhibit_warnings => true
end
target 'ConnectStatsTestApp' do
  use_frameworks!
  pod 'Flurry-iOS-SDK/FlurrySDK'
  pod 'GoogleMaps', :inhibit_warnings => true
  pod 'CHCSVParser', :inhibit_warnings => true
  pod 'GenericJSON'
end
target 'FitFileExplorer' do
  use_frameworks!
  platform :osx, '10.14'
  pod 'GenericJSON'
  pod 'Armchair', '>= 0.3', :inhibit_warnings => true
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
        end
    end
end
