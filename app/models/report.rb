class Report < ActiveRecord::Base
  enum severity: [:illegal, :offensive, :spam]
  belongs_to :reportable, polymorphic: true
  validates :severity, presence: true
  validates :message, length: {in: 50..500}, allow_blank: true

end
