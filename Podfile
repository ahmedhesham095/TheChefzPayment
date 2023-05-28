# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'TheChefzPayments' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TheChefzPayments
  pod 'Moya'
  pod 'ObjectMapper'
  pod 'Frames', '~> 3.5.0'
  pod 'NVActivityIndicatorView'

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0' 
        end
    end
end

end
