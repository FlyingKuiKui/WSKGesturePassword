
Pod::Spec.new do |spec|
  spec.name         = "WSKGesturePassword"
  spec.version      = "0.0.1"
  spec.summary      = "A short description of WSKGesturePassword."

  spec.description  = '1、描述' \
                      '2、描述' \

  spec.homepage = "https://github.com/FlyingKuiKui/WSKGesturePassword"
  spec.license = "MIT"
  spec.author = { "FlyingKuiKui" => "shengkuiwang@126.com" }
  spec.source = { :git => "http://EXAMPLE/WSKGesturePassword.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"

end
