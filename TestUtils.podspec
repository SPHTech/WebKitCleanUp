Pod::Spec.new do |spec|

    spec.name         = "TestUtils"
    spec.version      = "0.0.1"
    spec.summary      = "TestUtils module"

    spec.description  = <<-DESC
                   A module to list down unit test common functions.
                   DESC

    spec.homepage     = "https://github.com/SPHTech/TestUtils"
    spec.license      = { :type => "MIT", :text => "Copyright (c) 2023 SPHTech" }
    spec.authors            = { "hoang nguyen" => "hoangnguyen@sph.com.sg" }
    spec.platform     = :ios, "12.0"
    spec.source       = { :git => "git@github.com:SPHTech/TestUtils.git", :tag => "#{spec.version}" }
    spec.source_files  = "TestUtils/**/*.{swift}"
    spec.swift_version = '5.0'
    spec.requires_arc = true
    spec.static_framework = true
    spec.framework = "Foundation", "XCTest"
end
