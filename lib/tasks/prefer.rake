
desc "test rake"
task :hi do
  puts "hi"
end

desc "Run all back-end tests under test/ recursively"
task :backendtest do
  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList.new('test/**/*_test.rb') do |filelist|
      filelist.exclude('test_helper.rb')
      filelist.exclude('backend_test_helper.rb')
    end
    t.verbose = true
  end
end
  
desc "Backup project, excluding git repository"
task :backup do
  `tar zcvf ../prefer-web.tar.gz . --exclude=.git --exclude=output`
end

