# frozen_string_literal: true

require_relative "xcode_fastlane/version"
require "git"
require "xcodeproj"

# Main module for helper methods and CLI.
module XcodeFastlane
  # Loads and returns the Xcode project file.
  def self.project
    @project ||= Xcodeproj::Project.open(Pathname.glob("../*.xcodeproj").first)
  end

  # Returns the first target
  def self.target
    project.targets.first
  end

  # Generates an SKU
  # Requires environment: PRODUCE_PLATFORM to be set.
  def self.sku
    platform = ENV.fetch("PRODUCE_PLATFORM")
    CredentialsManager::AppfileConfig.try_fetch_value(:app_identifier) + ".#{platform}"
  end

  # Returns product bundle identifier for the given target or the first one found, if target_name is nil.
  #
  # Arguments:
  #   target_name: (String) The name of the target to fetch identifier from. Defaults to first target.
  def self.product_bundle_id(target_name = nil)
    scheme = project.native_targets.find { |target| !target_name || target.name == target_name }
    build_configuration = scheme.build_configurations.first
    build_configuration.build_settings["PRODUCT_BUNDLE_IDENTIFIER"]
  end

  # Returns the product name, retrieved from the application path.
  def self.product_name
    product = project.products.select { |p| p.explicit_file_type == "wrapper.application" }.first
    product.path.split(".").first
  end

  # Creates and checks out a new branch
  def self.checkout_branch(name)
    git = Git.open(".")
    git.branch(name).checkout
  end
end
