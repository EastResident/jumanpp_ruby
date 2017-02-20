# frozen_string_literal: true
require 'jumanpp_ruby/version'
require 'jumanpp_ruby/string'

module JumanppRuby
  class Juman
    require 'open3'

    def initialize(**options)
      @option = []
      @option.tap do |opt|
        opt << "-B #{options[:beam]}" if options[:beam]
        opt << '--force-single-path' if options[:force_single_path] == :true
        opt << '--partial' if options[:partial] == :true
      end
      @pipe ||= IO.popen("jumanpp #{@option.join(' ')}".strip, 'r+')
    end

    def parse(sentents)
      @pipe.puts(sentents)
      responses = []
      while sentent = @pipe.gets
        a = sentent.scan(/(?:\\ |[^\s"]|"[^"]*")+/)
        a.each {|i| i.sub!(/\A"(.*)"\z/, '\\1') }
        responses << a
        break if sentent =~ /EOS\n/
      end
      if block_given?
        responses.each { |word| yield word }
      else responses.map { |word| word.first }
      end
    end

    def close
      @pipe.close
    end

    def self.version
      o, = Open3.capture2('jumanpp -v')
      o.strip
    end

    def self.help
      o, = Open3.capture2('jumanpp -h')
      o.strip
    end
  end
end
