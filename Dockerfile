FROM java:8

MAINTAINER addie <addie9000+dockerhub@gmail.com>

# Setup prerequests
RUN apt-get update
RUN apt-get install -y lib32stdc++6 lib32z1 make file
RUN apt-get clean

# Setup Android SDK
RUN curl -L http://dl.google.com/android/android-sdk_r24.4.1-linux.tgz | tar xzC /opt
ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${ANDROID_HOME}/tools:$ANDROID_HOME/platform-tools:$PATH 

# Update Android SDK
RUN echo y | android update sdk -u -a -t platform-tools,build-tools-23.0.1,build-tools-23.0.2,android-23
RUN echo y | android update sdk -u -a -t extra-android-m2repository,extra-google-m2repository

# Setup Android NDK
RUN curl -L http://dl.google.com/android/repository/android-ndk-r11b-linux-x86_64.zip -o /tmp/ndk.zip
RUN unzip -q /tmp/ndk.zip -d /opt
RUN rm /tmp/ndk.zip
ENV ANDROID_NDK_HOME /opt/android-ndk-r11b
ENV PATH ${ANDROID_NDK_HOME}:$PATH

# Set TERM dumb to disable gradle fancy output.
ENV TERM dumb
