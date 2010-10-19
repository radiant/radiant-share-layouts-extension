class HamlFilter < TextFilter
  def filter(text)
    Haml::Engine.new(text).render
  end
end