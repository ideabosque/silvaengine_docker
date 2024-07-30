# Install Python 3.10.
cd /tmp
wget https://www.python.org/ftp/python/3.10.9/Python-3.10.9.tgz
tar xzf Python-3.10.9.tgz
cd Python-3.10.9/
./configure --enable-optimizations
make altinstall

# Clear up
rm -Rf /tmp/Python-3.10.9
rm -Rf /tmp/Python-3.10.9.tgz
