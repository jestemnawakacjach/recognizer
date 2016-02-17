require 'yaml'

CONFIG = YAML.load_file('build.yml')

task default: :specs

def system_or_exit(cmd, stdout = nil)
  puts "Executing #{cmd}"
  cmd += " >#{stdout}" if stdout
  system(cmd) || fail('******** Build failed ********')
end

def destination_platform
  specs_config = CONFIG["Specs"]
  platform = specs_config["Device"]
  simulator = specs_config["SimulatorVersion"]
  destination = "name=#{platform},OS=#{simulator}"
  "-destination \"platform=iOS Simulator,#{destination}\""
end

def project_scheme_argumets
  workspace = CONFIG["Workspace"]
  scheme = CONFIG["Scheme"]
  "-workspace #{workspace}.xcworkspace -scheme #{scheme}"
end

def run_specs_with_options(initial_pipe, options, additonal_build_args)
  arguments = project_scheme_argumets
  system_or_exit("#{initial_pipe} xcodebuild test #{arguments} -sdk iphonesimulator #{destination_platform} #{additonal_build_args} | xcpretty -c --no-utf #{options}")
end

desc 'Runs xcodebuild clean'
task :clean do
  system_or_exit("xcodebuild #{project_scheme_argumets} clean | xcpretty -c")
end

desc 'Runs specs'
task :specs do
  system_or_exit("clear");
  run_specs_with_options('', '--test', '')
end
