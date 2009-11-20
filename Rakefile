# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

require 'tasks/rails'


desc "Run all back-end tests under test/ recursively"
task :test do 
    Rake::TestTask.new do |t|
          t.libs << "test"
              t.test_files = FileList.new('test/**/*_test.rb') do |filelist|
                  filelist.exclude('test_helper.rb')
                      end
              t.verbose = true
                end
end

desc "Backup project, excluding git repository"
task :backup do
    `tar zcvf ../prefer.tar.gz . --exclude=.git --exclude=output`
end
