task :default => :test

task :test do
  #sh "/Applications/_system/Emacs.app/Contents/MacOS/Emacs -Q --no-site-file -batch -L . -L #{ENV['HOME']}/.emacs.d/el-get/ert-expectations -l ert-expectations -l tff-tests.el -f batch-expectations"
  sh "cask exec ecukes --reporter magnars --quiet"
end
