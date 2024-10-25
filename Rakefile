# Rakefile

task :cmcc do
  pod
  package
end

task :pod do
  pod
end

task :package do
  package
end
def pod
  puts "Current cocoaspod version:"
  system 'pod --version'
  puts "Running: pod install --no-repo-update"
  system 'pod install --no-repo-update'
end

def  package
  puts "Running: swift package manager install"
  system 'ruby swift_package.rb'
end
