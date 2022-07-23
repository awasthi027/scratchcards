Pod::Spec.new do |s|



#1

s.platform = :ios
s.ios.deployment_target = '14.0'

s.name = "ScratchCard"

s.summary = "Scratch card sample framework"

s.requires_arc = true

# 2
s.version = "1.0.0"

s.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
 }
 s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Ashish Awasthi" => "myemail.awasthi@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/awasthi027/scratchcards"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/awasthi027/scratchcards.git", 
             :tag => "#{s.version}" }

# 7
#s.framework = "UIKit"
#s.dependency = "Foundation"


# 8
s.source_files = "ScratchCard/**/*.{swift}"

# 9
#s.resources = "ScratchCard/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "5.5"

end