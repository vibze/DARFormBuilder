# pod spec lint DARFormBuilder.podspec

Pod::Spec.new do |s|

  s.platform = :ios
  s.ios.deployment_target = '9.0'
  s.name         = "DARFormBuilder"
  s.version      = "1.1.7"
  s.summary      = "A library created to build forms faster"
  s.description  = "Uses UITableVIew and a set of cells to construct a form for any requirement."
  s.homepage     = "https://github.com/vibze/DARFormBuilder"
  s.license      = "LICENSE"

  s.author             = { "Viktor Ten" => "ten.viktor@gmail.com" }
  s.social_media_url   = "https://github.com/vibze"
  s.source       = { :git => "https://github.com/vibze/DARFormBuilder.git", :tag => "#{s.version}" }

  s.source_files  = "DARFormBuilder/**/*.{swift}"
  s.exclude_files = ["DARFormBuilderExample/**/*", "DARFormBuilderExampleUITests/**/*"]

  s.requires_arc = true
end
