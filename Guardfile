notification :libnotify

guard 'rake', :task => 'test' do
  watch(%r{^manifests\/(.+)\.pp$})
  watch(%r{^templates\/(.+)\.erb$})
  watch(%r{^spec\/classes\/(.+)\.rb$})
end
