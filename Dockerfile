FROM jenkins/jenkins:2.401.3-jdk17
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"

ENV JAVA_HOME /var/jdk_home
ENV PATH $PATH:$JAVA_HOME/bin

ENV GRADLE_HOME /var/gradle_home
ENV PATH $PATH:$GRADLE_HOME/bin

ENV ANDROID_HOME /var/android_home
ENV PATH $PATH:$ANDROID_HOME/tools
ENV PATH $PATH:$ANDROID_HOME/platform-tools
ENV PATH $PATH:$ANDROID_HOME/ndk-bundle

ENV FLUTTER_HOME /var/flutter_home
ENV PATH $PATH:$FLUTTER_HOME

ENV DART_HOME /var/dart_home
ENV PATH $PATH:$DART_HOME/bin