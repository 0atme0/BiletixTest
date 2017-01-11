source 'https://github.com/CocoaPods/Specs.git'
use_frameworks!

target ‘biletixTest’ do
pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => '3.5.0'
pod 'SwiftyJSON', '~> 2.3'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod 'AlamofireImage'

end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '2.3'
        end
    end
end
