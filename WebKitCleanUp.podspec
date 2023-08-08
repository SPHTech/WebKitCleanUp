Pod::Spec.new do |spec|

    spec.name         = "WebKitCleanUp"
    spec.version      = "0.0.1"
    spec.summary      = "WebKitCleanUp module"

    spec.description  = <<-DESC
                   A module to handle webkit clean up.
                   DESC

    spec.homepage     = "https://github.com/SPHTech/WebKitCleanUp"
    spec.license      = { :type => "MIT", :text => "Copyright (c) 2023 SPHTech" }
    spec.authors            = { "hoang nguyen" => "hoangnguyen@sph.com.sg" }
    spec.platform     = :ios, "12.0"
    spec.source       = { :git => "git@github.com:SPHTech/WebKitCleanUp.git", :tag => "#{spec.version}" }
    spec.source_files  = "WebKitCleanUp/**/*.{swift}"
    spec.swift_version = '5.0'
    spec.requires_arc = true
    spec.static_framework = true
    spec.framework = "Foundation"
end
