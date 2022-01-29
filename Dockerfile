FROM ruby:latest

RUN curl -O http://ftp.edrdg.org/pub/Nihongo/JMdict.gz
RUN gem install nokogiri

COPY src workspace
WORKDIR /workspace
CMD [ "ruby", "main.rb" ]
