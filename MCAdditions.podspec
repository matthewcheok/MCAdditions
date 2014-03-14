Pod::Spec.new do |s|
  s.name     = 'MCAdditions'
  s.version  = '0.1.4'
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
  s.source_files = 'MCAdditions/MCAdditions.h'
  s.dependency 'Mantle', '~> 1.4.1'

  s.subspec 'Model' do |ss|
    ss.source_files = 'MCAdditions/Classes/Model/*.{h,m}'
  end

  s.subspec 'UI' do |ss|
    ss.source_files = 'MCAdditions/Classes/UI/*.{h,m}'
  end

  s.subspec 'Categories' do |ss|
    ss.source_files = 'MCAdditions/Categories/*.{h,m}'
  end

  s.subspec 'ExtObjC' do |ss|
    ss.source_files = 'MCAdditions/libextobjc/*.{h,m}'
  end
end
