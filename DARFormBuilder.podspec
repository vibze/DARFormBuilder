# pod spec lint DARFormBuilder.podspec

Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.name         = "DARFormBuilder"
  s.version      = "1.0.0"
  s.summary      = "A library created to build forms faster"
  s.description  = "A library created to build forms faster"
  s.homepage     = "https://github.com/vibze/DARFormBuilder"
  s.license      = "MIT"

  s.author             = { "Viktor Ten" => "ten.viktor@gmail.com" }
  s.social_media_url   = "https://github.com/vibze"
  s.source       = { :git => "https://github.com/vibze/DARFormBuilder", :tag => "#{s.version}" }

  s.source_files  = "DARFormBuilder/**/*.{swift}"
  s.exclude_files = ["DARFormBuilderExample/**/*", "DARFormBuilderExampleUITests/**/*"]

  s.requires_arc = true
end
