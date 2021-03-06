# coding: utf-8
require 'spec_helper'

describe JumanppRuby do
  it 'has a version number' do
    expect(JumanppRuby::VERSION).not_to be nil
  end

  it 'Juman.parse' do
    juman = JumanppRuby::Juman.new(force_single_path: :true)
    parsed_text = juman.parse('モビルスーツの性能の違いが、戦力の決定的差でないということを教えてやる')
    expect(parsed_text).to eq ["モビルスーツ", "の", "性能", "の", "違い", "が", "、", "戦力", "の", "決定", "的", "差", "で", "ない", "と", "いう", "こと", "を", "教えて", "やる", "EOS"]
  end

  context "proper handing of escape characters" do
    it '#parse' do
      juman = JumanppRuby::Juman.new(force_single_path: :true)
      juman.parse("Ｓｔｒｉｎｇ　ｔｈｅｏｒｙ") do |a|
        expect(a.size).to eq(12).or(eq(1))
      end
    end
  end

  context 'hankaku' do
    it 'Juman.parse' do
      juman = JumanppRuby::Juman.new(force_single_path: :true)
      parsed_text = juman.parse('String')
      expect(parsed_text).to eq ['Ｓｔｒｉｎｇ', 'EOS']
    end
  end
end

describe String do
  it 'String.parse' do
    parsed_text = 'モビルスーツの性能の違いが、戦力の決定的差でないということを教えてやる'.parse(force_single_path: :true)
    expect(parsed_text).to eq ["モビルスーツ", "の", "性能", "の", "違い", "が", "、", "戦力", "の", "決定", "的", "差", "で", "ない", "と", "いう", "こと", "を", "教えて", "やる", "EOS"]
  end
end
