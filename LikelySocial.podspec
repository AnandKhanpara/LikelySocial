
Pod::Spec.new do |spec|

  spec.name         = "LikelySocial"
  spec.version      = "0.0.1"
  spec.summary      = "Add LikelySocial"
  
  spec.description  = <<-DESC
  This CocoaPods library helps you perform LikelySocial.
                   DESC

  spec.homepage     = "https://github.com/AnandKhanpara/LikelySocial"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Anand Khanpara" => "anandkhanpara111@gmail.com" }
  spec.ios.deployment_target = "12.0"
  spec.swift_version = "5"
  spec.source       = { :git => "https://github.com/AnandKhanpara/LikelySocial.git", :tag => "#{spec.version}" }
  spec.source_files  = "LikelySocial/**/*.{h,m,swift}"

end
