# Uncomment the next line to define a global platform for your project
platform :ios, '10.0'

target 'Umbrella' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Umbrella
  pod 'SwiftLint'
  pod 'SwiftGen'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'SQLite.swift', '~> 0.11.5'
	
  target 'UmbrellaTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'UmbrellaUITests' do
    inherit! :search_paths
    # Pods for testing

    pod 'Quick'
    pod 'Nimble'
  end

end
