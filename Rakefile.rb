task :default => :test

task :test do
  sh "/Applications/_system/Emacs.app/Contents/MacOS/Emacs --no-site-file -batch -L . -L #{ENV['HOME']}/.emacs.d/el-get/ert-expectations -l ert-expectations -l tff.el -f batch-expectations"
end
