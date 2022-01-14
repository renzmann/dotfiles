cd /etc/yum.repos.d/
sudo wget https://download.opensuse.org/repositories/shells:fish:release:3/CentOS_7/shells:fish:release:3.repo
sudo yum install fish
cd $HOME
sudo yum install util-linux-user
chsh -sh ($which fish)
