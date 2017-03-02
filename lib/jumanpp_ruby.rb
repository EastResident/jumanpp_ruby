# frozen_string_literal: true
require 'jumanpp_ruby/version'
require 'jumanpp_ruby/string'

module JumanppRuby
  class Juman
    require 'open3'

    def initialize(beam: nil, force_single_path: false, partial: false)
      argv = ['jumanpp']
      argv << '--beam' << beam if beam
      argv << '--force-single-path' if force_single_path
      argv << '--partial' if partial
      @pipe = IO.popen(argv, 'r+')
    end

    def parse(sentents)
      @pipe.puts(zh_convert(sentents))
      responses = []
      while sentent = @pipe.gets
        responses << sentent.delete('\\').delete('\"')
        break if sentent =~ /EOS\n/
      end
      if block_given?
        responses.each { |word| yield word.split }
      else responses.map { |word| word.split.first }
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

    private

    def zh_convert str
      str.tr <<~'STR1',<<~'STR2'
        ABCDEFGHIJKLMNOPQRSTUVWXYZ
        abcdefghijklmnopqrstuvwxyz
        0123456789
        !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~
      STR1
        ＡＢＣＤＥＦＧＨＩＪＫＬＭＮＯＰＱＲＳＴＵＶＷＸＹＺ
        ａｂｃｄｅｆｇｈｉｊｋｌｍｎｏｐｑｒｓｔｕｖｗｘｙｚ
        ０１２３４５６７８９
        ！”＃＄％＆’（）＊＋，−．／：；＜＝＞？＠［￥］＾＿｀｛｜｝〜
      STR2
    end
  end
end
