# frozen_string_literal: true

require_relative "lib/xcode_fastlane/version"

Gem::Specification.new do |spec|
  spec.name = "xcode_fastlane"
  spec.version = XcodeFastlane::VERSION
  spec.authors = ["Karsten Silkenbäumer"]
  spec.email = ["993392+kassi@users.noreply.github.com"]

  spec.summary = "Easy fastlane setup for xcode projects using Xcode Cloud builds."
  spec.description = "Provides init script, templates and functions to be used within fastlane files."
  spec.homepage = "https://github.com/kassi/xcode_fastlane"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kassi/xcode_fastlane"
  spec.metadata["changelog_uri"] = "https://github.com/kassi/xcode_fastlane/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) { |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git .github appveyor Gemfile])
    end
  }
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "dotenv", ">= 2.1.1", "< 3.0.0"
  spec.add_dependency "git", "~> 2.0"
  spec.add_dependency "thor", "~> 1.3"
  spec.add_dependency "xcodeproj", "~> 1.24"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
  spec.metadata["rubygems_mfa_required"] = "true"
end
