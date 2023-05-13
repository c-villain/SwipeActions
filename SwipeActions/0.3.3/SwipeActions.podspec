Pod::Spec.new do |s|
    s.name             = 'SwipeActions'
    s.version          = '0.3.3'
    s.summary          = 'Library for creating swipe actions for any SwiftUI View.'
    s.description      = <<-DESC
    Library for creating swipe actions for any SwiftUI View, 
    similar to Apple's swipeActions(edge:allowsFullSwipe:content:) 
    that available from iOS 15 and only in List 🤷🏼‍♂️. 
    You can use SwipeActions in project targeting iOS 13 with any view (e.g. Text or VStack).
                         DESC
  
    s.homepage         = 'https://github.com/c-villain/SwipeActions'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Alexander Kraev' => 'lexkraev@gmail.com' }
    s.source           = { :git => 'https://github.com/c-villain/SwipeActions.git', :tag => s.version.to_s }
  
    s.ios.deployment_target = '13.0'
    s.macos.deployment_target = '10.15'
    s.swift_version = '5'
    s.source_files = 'Sources/SwipeActions/**/*'
  end
  