
Pod::Spec.new do |spec|
  spec.name = "ResultBuilderKit"
  spec.version = "1.1.0"
  spec.summary = "A set of result-builders"
  spec.description = <<-DESC
  This library provides a set of result-builders
                   DESC

  spec.homepage = "https://github.com/muukii/ResultBuilderKit"
  spec.license = "MIT"
  spec.author = { "Muukii" => "muukii.app@gmail.com" }
  spec.social_media_url = "https://twitter.com/muukii_app"

  spec.ios.deployment_target = "12.0"
  # spec.osx.deployment_target = "10.7"
  # spec.watchos.deployment_target = "2.0"
  # spec.tvos.deployment_target = "9.0"

  spec.source = { :git => "https://github.com/muukii/ResultBuilderKit.git", :tag => "#{spec.version}" }
  spec.source_files = "ResultBuilderKit/**/*.swift"  
  spec.requires_arc = true
  spec.swift_versions = ["5.3", "5.4", "5.5"]
end
