FROM node:14
#RUN apt-get update -qqy

# Get wget to download firefox and xvfb
RUN apt-get update && apt-get install -y software-properties-common curl wget xvfb tar gzip bash packagekit-gtk3-module

RUN node -v && npm -v


# Install Chrome
RUN apt-get update 
RUN apt-get install -y fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatspi2.0-0 libgtk-3-0 libnspr4 libnss3 libxss1 libxtst6 xdg-utils
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb


# Set firefox version and installation directory through environment variables.
 ENV FIREFOX_VERSION 83.0
 ENV FIREFOX_DIR /usr/bin/firefox
 ENV FIREFOX_FILENAME $FIREFOX_DIR/firefox.tar.bz2

# Download the firefox of specified version from Mozilla and untar it.
 RUN mkdir $FIREFOX_DIR
 RUN wget -q --continue --output-document $FIREFOX_FILENAME "https://ftp.mozilla.org/pub/firefox/releases/${FIREFOX_VERSION}/linux-x86_64/en-US/firefox-${FIREFOX_VERSION}.tar.bz2"
 RUN tar -xaf "$FIREFOX_FILENAME" --strip-components=1 --directory "$FIREFOX_DIR"
 
#SET xvfb
RUN export DISPLAY=:99 &

# Prepend firefox dir to PATH
 ENV PATH $FIREFOX_DIR:$PATH
#COPY ne-nl-fpon-web-int-test /ne-nl-fpon-web-int-test

ENTRYPOINT ["/bin/bash"]
