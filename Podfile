# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TheChefzPayments' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  source 'https://github.com/CocoaPods/Specs.git'
  
  # Pods for TheChefzPayments
  pod 'Moya' , '~> 12.0'
  pod 'ObjectMapper'
  pod 'Frames', '~> 3.5.0'
  pod 'NVActivityIndicatorView'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'
        end
    end
end

end
