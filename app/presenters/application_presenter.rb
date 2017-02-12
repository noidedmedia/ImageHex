require 'set'

class ApplicationPresenter
  include Rails.application.routes.url_helpers

  def self.memoize(*attrs)
    m = Module.new do
      attrs.flatten.each do |attr|
        self.send(:define_method, attr) do
          a = self.instance_variable_get("@#{attr}_memoize")
          return a if a
          res = super()
          self.instance_variable_set("@#{attr}_memoize", res)
          return res
        end
      end
    end
    self.send(:prepend, m)
  end


  def self.autowrap(*meths)
    mapmeth = self.method(:to_presenter)
    m = Module.new do
      meths.flatten.each do |method|
        self.send(:define_method, method) do |*args|
          val = super(*args)
          raise ArugmentError, "not mappable" unless val.respond_to?(:map)
          val.map(&mapmeth)
        end
      end
    end
    self.send(:prepend, m)
  end

  def self.to_presenter(obj, hashset = nil)
    hashset ||= Set.new
    return self.presenter_map(obj, hashset) if obj.is_a? Enumerable
    v = obj.class.name.split("::").map{|x| x + "Presenter"}.join("::")
    o = const_get(v)
    unless o && o.is_a?(Class)
      raise ArgumentError, 
        "No presenter for class #{obj.class} (looked for #{v})"
    end
    o.new(obj)
  end

  def self.presenter_map(enumerable, hashset)
    if hashset.contains?(enumerable)
      raise ArgumentError, "Recursive array breaks everything"
    end
    hashset = hashset + [enumerable].to_set
    enumerable.map{|x| to_presenter(x, hashset)}
  end


  def self.delegate_to(sym)
    define_method(:_get_delegate) do 
      self.send(:instance_variable_get, "@#{sym}")
    end

    m = Module.new do |r|
      define_method(:method_missing) do |meth, *args|
        a = _get_delegate
        a.public_send(meth, *args)
      end

      define_method(:respond_to_missing?) do |sym, include_private = false|
        a = _get_delegate
        a.public_send(:respond_to?, sym, include_private) ||
          super(sym, include_private)
      end

      define_method(:respond_to?) do |sym, include_private = false|
        a = _get_delegate
        a.public_send(:respond_to?, sym, include_private) ||
          super(sym, include_private)
      end
    end
    self.send(:prepend, m)
  end

  def self.delegate_collection(sym)
    mapmeth = self.method(:to_presenter)
    define_method(:_collection_delegate) do
      instance_variable_get("@#{sym}")
    end

    define_method(:to_ary) do
      _collection_delegate.to_ary.map(&mapmeth)
    end

    define_method(:to_a) do 
      _collection_delegate.to_a.map(&mapmeth)
    end
  end
end
