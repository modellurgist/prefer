
desc "Backup project, excluding git repository"
task :backup do
  `tar zcvf ../prefer-web.tar.gz . --exclude=.git --exclude=output`
end

