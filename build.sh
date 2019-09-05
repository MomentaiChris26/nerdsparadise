# allows you to execute ./build.sh without the bash keyword
chmod +x ./build.sh
# copy across files to distribution directory
mkdir dist
cp ./src/app.rb ./dist
cp ./src/class.rb ./dist
cp ./src/module.rb ./dist
cp ./src/saved_data.csv ./dist
# install all gems
gem install colorize 
gem install tty-prompt
gem install tty-font
gem install terminal-table
gem install tty-spinner