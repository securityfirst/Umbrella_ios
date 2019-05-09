platform :ios, '10.0'

target 'Umbrella' do
  
  use_frameworks!
  inhibit_all_warnings!

  pod 'SwiftLint'
  pod 'Localize-Swift', '~> 2.0'
  pod 'SQLite.swift/SQLCipher', :git => 'https://github.com/stephencelis/SQLite.swift.git'
  pod 'Files', :git => 'https://github.com/clayellis/Files.git'
  pod 'FeedKit', '~> 8.0'
  pod 'BTNavigationDropdownMenu', :git => 'https://github.com/lucascorrea/BTNavigationDropdownMenu.git'
  pod 'Yams'
  pod 'Toast-Swift', '~> 4.0.0'
  pod 'Zip', '~> 1.1'
  
  target 'UmbrellaTests' do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
    
  end
  
  pod 'Down'

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['ARCHS'] = 'arm64'
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
    
#    installer_representation.pods_project.targets.each do |target|
#        if target.name != 'MarkdownView' && target.name != 'Toast-Swift'
#            target.build_configurations.each do |config|
#                config.build_settings['SWIFT_VERSION'] = '4.0'
#            end
#        end
#    end
end

