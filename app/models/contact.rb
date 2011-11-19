class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name, :type => String
  field :email, :type => String
  field :subject, :type => String
  field :description, :type => String

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :subject
  validates_presence_of :description
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  after_create :send_email

  def send_email
    Notifier.contact(self).deliver
  end
end
