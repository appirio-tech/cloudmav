class String
  def is_a_constant?
    self.constantize
    true
  rescue NameError
    false
  end
end