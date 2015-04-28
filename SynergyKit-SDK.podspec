Pod::Spec.new do |s|
  s.name         = "SynergyKit-SDK"
  s.version      = "2.1.0"
  s.license      = 'MIT'
  s.summary      = "iOS SDK for BaaS SynergyKit"
  s.homepage     = "https://synergykit.com/"
  s.authors      =  { "Letsgood.com s.r.o." => "jan.cislinsky@letsgood.com" }

  s.platform  	  = :ios, "7.0" 
  s.source       =  { :git => "https://github.com/SynergyKit/synergykit-sdk-ios.git", :tag => s.version.to_s }
  s.source_files =  'SDK/**/*.{h,m}'
  s.frameworks   = 'Foundation'
  s.dependency 'AFNetworking', '> 2'
  s.dependency 'JSONModel'
  s.dependency 'SIOSocket'

  s.requires_arc = true

end
