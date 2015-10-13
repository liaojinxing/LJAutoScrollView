#
#  Be sure to run `pod spec lint LJAutoScrollView.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "LJAutoScrollView"
  s.version      = "1.0.1"
  s.summary      = "auto and infinite scroll view"

  s.description  = <<-DESC
                   LJAutoScrollView class provides an endlessly circulate scroll view. It allows users to scroll infinitely in the horizontal direction, and also provides automatic scrolling feature.

                   DESC

  s.homepage     = "https://github.com/liaojinxing/LJAutoScrollView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

   s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "Jinxing Liao" => "jinxingliao@gmail.com" }
   s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/liaojinxing/LJAutoScrollView.git", :tag => "1.0.1" }
  s.source_files  = "LJAutoScrollView/**/*.{h,m}"
   s.framework  = "UIKit"
   s.requires_arc = true
end
