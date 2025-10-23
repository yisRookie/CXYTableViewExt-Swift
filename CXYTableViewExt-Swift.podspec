Pod::Spec.new do |spec|

  spec.name         = "CXYTableViewExt-Swift"
  spec.version      = "0.0.2"
  spec.summary      = "Make it easier for you to configure and use UITableView."
  spec.description  = <<-DESC
  Make UITableView configuration easier. 让你更简单的配置UITableView，极大的简化逻辑
                   DESC

  spec.homepage     = "https://github.com/iHongRen/CXYTableViewExt-Swift"
  spec.screenshots  = "https://raw.githubusercontent.com/iHongRen/CXYTableViewExt-Swift/main/imgs/setting.png"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "Allen" => "525372406@qq.com" }
  spec.ios.deployment_target = "12.0"
  spec.swift_versions = "5.0"

  spec.source       = { :git => "https://github.com/iHongRen/CXYTableViewExt-Swift.git", :tag => "#{spec.version}" }
  

  #spec.source_files  = "CXYTableViewExt-Swift/CXYTableViewExt-Swift/CXYTableViewExt/*.swift"
spec.source_files = [
  "CXYTableViewExt-Swift/CXYTableViewExt-Swift/CXYTableViewExt/*.swift",
  "CXYTableViewExt-Swift/CXYTableViewExt-Swift/CXYCollectionViewExt/*.swift"
]


end
