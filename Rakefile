require 'YAML'
require 'houston'

task default: :specs

def system_or_exit(cmd, stdout = nil)
  puts "Executing #{cmd}"
  cmd += " >#{stdout}" if stdout
  system(cmd) || fail('******** Build failed ********')
end

def destination_platform
  "-destination \"platform=iOS Simulator,name=iPhone 6,OS=9.3\""
end

def project_scheme_argumets
  "-workspace UIKonf.xcworkspace -scheme UIKonf"
end

def run_specs_with_options(initial_pipe, options, additonal_build_args)
  arguments = project_scheme_argumets
  system_or_exit("#{initial_pipe} env NSUnbufferedIO=YES xcodebuild test #{arguments} -sdk iphonesimulator #{destination_platform} #{additonal_build_args} | xcpretty -c --no-utf #{options}")
end

desc 'Runs xcodebuild clean'
task :clean do
  system_or_exit("xcodebuild #{project_scheme_argumets} clean | xcpretty -c")
end

desc 'Runs specs'
task :specs do
  run_specs_with_options('', '--test', '')
end
