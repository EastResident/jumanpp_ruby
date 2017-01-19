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
end

describe String do
  it 'String.parse' do
    parsed_text = 'モビルスーツの性能の違いが、戦力の決定的差でないということを教えてやる'.parse(force_single_path: :true)
    expect(parsed_text).to eq ["モビルスーツ", "の", "性能", "の", "違い", "が", "、", "戦力", "の", "決定", "的", "差", "で", "ない", "と", "いう", "こと", "を", "教えて", "やる", "EOS"]
  end
end
