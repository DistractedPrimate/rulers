class Object
  def self.const_missing(c)
    const_str = c.to_s
    @klass_looked_for ||= {}
    return nil if @klass_looked_for[const_str]

    require Rulers.to_underscore(const_str)
    @klass_looked_for[const_str] = true
    klass = Object.const_get(c)

    klass
  end
end