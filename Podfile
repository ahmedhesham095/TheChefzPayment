# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TheChefzPayments' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  source 'https://github.com/CocoaPods/Specs.git'
  
  # Pods for TheChefzPayments
  pod 'Moya'
  pod 'ObjectMapper'
  pod 'Frames', '~> 3.5.0'
  pod 'NVActivityIndicatorView'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        config.build_settings['ENABLE_BITCODE'] = 'YES'
        config.build_settings["DEVELOPMENT_TEAM"] = "MEZL3QN42T"
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            config.build_settings['ENABLE_BITCODE'] = 'YES'
            config.build_settings["DEVELOPMENT_TEAM"] = "MEZL3QN42T"
        end
    end
end

end
