Pod::Spec.new do |spec|

  spec.name         = "AutoSolveClient"
  spec.version      = "0.0.1"
  spec.summary      = "AYCD AutoSolve Client"
  spec.description  = <<-DESC
    Swift client for connecting to the AYCD AutoSolve network. Uses RMQClient and Emit as dependencies
                   DESC

  spec.homepage     = "https://docs.aycd.io/docs/autosolve-api.html"
  spec.license      = "MIT"
  spec.author             = { "Apriscott" => "scott@kapelewski.com" }
  spec.ios.deployment_target = "13.0"
  spec.source       = { :git => "https://github.com/aycdinc/autosolve-client-swift.git", :tag => "#{spec.version}" }
  spec.source_files  = "AutoSolveClient", "AutoSolveClient/Messaging/*", "AutoSolveClient/AutoSolveConnectionDelegate/*", "AutoSolveClient/Utils/*",
  spec.dependency "RMQClient"
  spec.dependency "Emit"

end
