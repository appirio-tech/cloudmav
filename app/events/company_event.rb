class CompanyEvent < Event

  referenced_in :company, :inverse_of => :events

  def set_info
    self.category = "Company"
  end

  def do_work
    company.retag!
  end

end
