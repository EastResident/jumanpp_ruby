# frozen_string_literal: true
String.class_eval do
  def parse(*option)
    JumanppRuby::Juman.new(*option).parse(self)
  end
end
