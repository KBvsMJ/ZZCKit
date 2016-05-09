#
#  Be sure to run `pod spec lint MTAdvert.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "ZZCKit"
  s.version      = "0.1.1"
  s.summary      = "ZZCKit."
  s.homepage     = "https://github.com/zhouzhicun/ZZCKit"
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
              © 2008-2016 Meitu. All rights reserved.
    LICENSE
  }


  s.author       = { "zzc" => "315701008@qq.com" }
  s.platform     = :ios, "7.0"
  
  s.source       = { :git => "https://github.com/zhouzhicun/ZZCKit.git", :tag => s.version.to_s}
  #s.source       = { :git => "/Users/zzc/Desktop/ZZCKit/ZZCKit"}
 
  s.source_files = 'ZZCKit/*.{h,m}'
  s.public_header_files = 'ZZCKit/*.h'


  s.subspec 'Categorys' do |ss|
    ss.source_files = 'ZZCKit/Categorys/**/*.{h,m}'
  end


   s.subspec 'Util' do |ss|
    ss.source_files = 'ZZCKit/Util/**/*.{h,m}'
  end

  
  s.frameworks = 'Foundation', 'Security'
  s.requires_arc = true
  
 
 

end