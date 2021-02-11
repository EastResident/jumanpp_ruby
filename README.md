# JumanppRuby

This gem is Ruby binding for JUMAN++

## Installation

```ruby
gem 'jumanpp_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install jumanpp_ruby

## Usage

### `JumanppRuby::Juman.parse`

`parse(text)`method can parse Japanese text as `Array` if first argument only.

```rb
require 'jumanpp_ruby'

juman = JumanppRuby::Juman.new(force_single_path: :true)
p juman.parse('モビルスーツの性能の違いが、戦力の決定的差でないということを教えてやる')
# => ["モビルスーツ", "の", "性能", "の", "違い", "が", "、", "戦力", "の", "決定", "的", "差", "で", "ない", "と", "いう", "こと", "を", "教えて", "やる", "EOS"]
```

If you passed Japanese text and `&block` as argument, you can handle Morphological Analysis result as `Array` in the block.

```rb
require 'jumanpp_ruby'

juman = JumanppRuby::Juman.new(force_single_path: :true)
juman.parse('ララァ…私を導いてくれ！') do |word|
  p word
end
# =>["ララァ", "ララァ", "ララァ", "名詞", "6", "普通名詞", "1", "*", "0", "*", "0", "自動獲得:Wikipedia", "Wikipediaリダイレクト:ララァ・スン"]
# =>["…", "…", "…", "特殊", "1", "記号", "5", "*", "0", "*", "0", "NIL"]
# =>["私", "わたし", "私", "名詞", "6", "普通名詞", "1", "*", "0", "*", "0", "代表表記:私/わたし", "漢字読み:訓", "カテゴリ:人"]
# =>["を", "を", "を", "助詞", "9", "格助詞", "1", "*", "0", "*", "0", "NIL"]
# =>["導いて", "みちびいて", "導く", "動詞", "2", "*", "0", "子音動詞カ行", "2", "タ系連用テ形", "14", "代表表記:導く/みちびく"]
# =>["くれ", "くれ", "くれる", "接尾辞", "14", "動詞性接尾辞", "7", "母音動詞", "1", "基本連用形", "8", "代表表記:くれる/くれる"]
# =>["！", "！", "！", "特殊", "1", "記号", "5", "*", "0", "*", "0", "NIL"]
# =>["EOS"]
```

### `String.parse`

You can use `parse` method as `String` instance method.

```rb
require 'jumanpp_ruby'

p 'モビルスーツの性能の違いが、戦力の決定的差でないということを教えてやる'.parse
# => ["モビルスーツ", "の", "性能", "の", "違い", "が", "、", "戦力", "の", "決定", "的", "差", "で", "ない", "と", "いう", "こと", "を", "教えて", "やる", "EOS"]
```

### Use Juman++ configuration

This binding allow Juman++ configurations.

```
usage: JumanppRuby::Juman.new(options as Hash)
options:
  beam: set beam width used in analysis (unsigned int [=5])
  force_single_path: do not output ambiguous words on lattice(default false)
  partial: receive partially annotated text(default false)
```

example

```rb
JumanppRuby::Juman.new(
  beam: 5,
  force_single_path: :true,
  partial: :true
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/jumanpp_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

