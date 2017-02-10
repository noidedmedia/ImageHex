class ApplicationPresenter
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
end
