
Pod::Spec.new do |s|

  s.name         = "AnimatedAlert"
  s.version      = "1.0.0"
  s.summary      = "AnimatedAlertView is alert view that uses UIKit Dynamics and provide animated present/dismiss behavior."

  s.homepage     = "https://github.com/sainiketan47/AnimatedAlertView"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }


   s.author             = { "Ketan" => "ketan.saini@netsolutions.in" }
  # Or just: s.author    = "Ketan"
  # s.authors            = { "Ketan" => "ketan.saini@netsolutions.in" }
  # s.social_media_url   = "http://twitter.com/Ketan"


  # s.platform     = :ios
   s.platform     = :ios, "9.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => "https://github.com/sainiketan47/AnimatedAlertView.git", :tag => s.version.to_s }


  s.source_files  = "AnimatedAlert.framework"
  s.ios.vendored_frameworks = 'AnimatedAlert.framework'
  #s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
