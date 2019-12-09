Gem::Specification.new do |s|
    s.name = %q{dad_jokes_2020}
    s.version = "1.0.0"
    s.date = %q{2011-09-29}
    s.licenses    = ['MIT']
    s.summary = %q{dad_jokes gives you a joke on any and every subject you want}
    s.description = "Why not have some laughs?"
    s.authors     = ["Sylwia Vargas"]
    s.homepage    = 'https://rubygems.org/gems/dad_jokes'
    s.metadata    = { "source_code_uri" => "https://github.com/sylwiavargas/dad_jokes" }
    s.files = [
      "lib/dad_jokes.rb"
    ]
    s.require_paths = ["lib"]
    
    spec.add_development_dependency "bundler", "~> 1.9"
    spec.add_development_dependency "rake", "~> 10.0"
    spec.add_development_dependency "rest-client", "~> 2.1"
    spec.add_runtime_dependency "colorize", "~> 0.8.1"
    spec.add_runtime_dependency "require_all"
  end
