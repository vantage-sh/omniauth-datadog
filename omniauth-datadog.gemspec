require_relative "lib/omniauth/datadog/version"

Gem::Specification.new do |spec|
  spec.name = "omniauth-datadog"
  spec.version = Omniauth::Datadog::VERSION
  spec.authors = ["Vantage Engineering"]
  spec.email = ["support@vantage.sh"]
  spec.require_paths = %w[lib]

  spec.summary = "OmniAuth OAUTH2 Strategy for Datadog."
  spec.description = "OmniAuth OAUTH2 Strategy for Datadog."
  spec.homepage = "https://github.com/vantage-sh/omniauth-datadog"
  spec.license = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/vantage-sh/omniauth-datadog"

  spec.executables   = `git ls-files -- bin/*`.split("\n").collect { |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")

  # Uncomment to register a new dependency of your gem
  spec.add_dependency "omniauth-oauth2", "~> 1.8.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
