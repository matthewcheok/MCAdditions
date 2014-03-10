Pod::Spec.new do |s|
  s.name     = 'MCAdditions'
  s.version  = '0.1'
  s.platform = :ios, '7.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'A host of useful utilties for any iOS application.'
  s.homepage = 'https://github.com/matthewcheok/MCAdditions'
  s.author   = { 'Matthew Cheok' => 'cheok.jz@gmail.com' }
  s.requires_arc = true
  s.source   = {
      :git => 'https://github.com/matthewcheok/MCAdditions.git',
      :branch => 'master',
      :tag => s.version.to_s
  }
  s.source_files = 'MCAdditions/**/*.{h,m}'
  s.dependency 'Mantle', '~> 1.3.1'
end
