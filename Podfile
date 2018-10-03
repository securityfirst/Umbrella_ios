platform :ios, '10.0'

target 'Umbrella' do
  
  use_frameworks!
  inhibit_all_warnings!

  pod 'SwiftLint'
  pod 'Localize-Swift', '~> 2.0'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'SQLite.swift/SQLCipher', :git => 'https://github.com/stephencelis/SQLite.swift.git'
  pod 'Files', :git => 'https://github.com/clayellis/Files.git'
  pod 'Yams'
  pod 'MarkdownView', '~> 1.2.0'
  pod 'FeedKit', '~> 8.0'
  pod 'BTNavigationDropdownMenu', :git => 'https://github.com/lucascorrea/BTNavigationDropdownMenu.git'
  
  target 'UmbrellaTests' do
    inherit! :search_paths

    pod 'Quick'
    pod 'Nimble'
    
  end

end

post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end
