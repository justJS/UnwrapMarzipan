# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'

target 'Unwrap' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # There isn't a lot we can do about warnings in these pods, so silence them
  inhibit_all_warnings!

  # Pods for Unwrap
  # pod 'SwiftEntryKit', '~> 1.0', :configurations => ['Debug', 'Release']
  pod 'SDWebImage', '~> 5.0'
  pod 'MKRingProgressView', '~> 2.2.2'
  pod 'Sourceful', :git => 'https://github.com/twostraws/Sourceful.git', :branch => 'master'
  pod 'DZNEmptyDataSet', '~> 1.8'
  pod 'SwiftLint', '0.31.0'

  # INCLUDE DEPENDENCIES OF OTHER FRAMEWORKS TO ALLOW US TO DISABLE ON MARZIPAN
  pod 'QuickLayout', :configurations => ['Debug', 'Release'] # SwiftEntryKit

  target 'UnwrapTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'UnwrapUITests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
      config.build_settings.delete('CODE_SIGNING_ALLOWED')
      config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end

    librariesWhichRequireSwift4 = ['SavannaKit', 'SourceEditor']    
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if librariesWhichRequireSwift4.include?(target.name)
                config.build_settings['SWIFT_VERSION'] = '4.1'
            end
        end
    end
  end
end
