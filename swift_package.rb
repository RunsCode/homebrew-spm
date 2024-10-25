# frozen_string_literal: true
require 'json'

PROJECT_PATH = "#{__dir__}/Pods/Pods.xcodeproj".freeze
# PROJECT_PATH = "#{__dir__}/Hello.xcodeproj".freeze
puts "SPM init #{PROJECT_PATH}"
SWIFT_COMMAND = "/Users/runscode/Desktop/Demo/Command/spm/.build/debug/spm".freeze

def spm(target, options = {})
  puts "-"*200
  puts "Calling Ruby Fuction: \nspm with project: #{target}, options: #{options.inspect}"
  if target.nil? or !target.kind_of?(String) or target.empty?
    puts "\e[31mError: Pods target is null or wrong\e[0m"
    exit(1)
  end
  package = options[:name]
  if package.nil? or package.empty?
    puts "\e[31mError: Pods:#{target} install package is null or wrong\e[0m"
    exit(1)
  end
  try_check(target, package, 'location', options[:location])
  # puts "target: #{target}, name: #{options[:name]}, location: #{options[:location]}"
  options[:target] = target

  command = SWIFT_COMMAND + " #{PROJECT_PATH}" + " #{JSON.generate(options.to_json)}"
  puts "Calling Swift Command: \n#{command}"
  system command
end

# def Pod(target,)

def try_check(target, package, key, value)
  if value.nil? or value.empty?
    puts "\e[31mError: Pods:#{target} install Package:#{package} while value for Key:#{key} is null or wrong\e[0m"
    exit(1)
  end
end


# spm "Hello_Example", :location=> 'https://baidu.com', :name=> 'httpsdns', :kind => 'version', :tag=> '0.0.8', :branch => 'main'
# spm "Hello_Example", :location=> 'https://baidu.com', :name=> 'httpsdns', :tag=> '0.0.8', :branch => 'main'
spm "Hello", :location=> 'https://gitee.com/runsminicode/CMCCHttpDNSKit', :name=> 'CMCCHttpDNSKit', :major=> '0.0.2'
spm "Hello", :location=> 'https://gitee.com/runsminicode/ObjCLibExtKit', :name=> 'ObjCLibExtKit', :major => '0.0.4'
