Pod::Spec.new do |s|
    s.name             = 'CHIOTPField'
    s.version          = '0.1.0'
    s.summary          = 'CHIOTPField is a set of cool animated text fields for One-Time PIN code that are used to verify a phone number.'
  
    s.ios.deployment_target = '10.0'
    s.tvos.deployment_target = '12.0'
  
    s.homepage         = 'https://github.com/ChiliLabs/CHIOTPField'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Chili' => 'studio@chi.lv' }
    s.source           = { :git => 'https://github.com/ChiliLabs/CHIOTPField.git', :tag => s.version.to_s }
    s.swift_version    = '5.0'
  
    s.source_files = 'Sources/**/*.swift'
  
    s.subspec 'One' do |one|
        one.source_files = 'Sources/CHIOTPFieldOne/*.swift', 'CHIOTPField/Base/*.swift'
    end

    s.subspec 'Two' do |two|
        two.source_files = 'Sources/CHIOTPFieldTwo/*.swift', 'CHIOTPField/Base/*.swift'
    end

    s.subspec 'Three' do |three|
        three.source_files = 'Sources/CHIOTPFieldThree/*.swift', 'CHIOTPField/Base/*.swift'
    end

    s.subspec 'Four' do |four|
        four.source_files = 'Sources/CHIOTPFieldFour/*.swift', 'CHIOTPField/Base/*.swift'
    end
  
  end
