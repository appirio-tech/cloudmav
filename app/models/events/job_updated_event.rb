class JobUpdatedEvent < JobEvent

  def set_info
    super
    self.is_public = false
  end

end
