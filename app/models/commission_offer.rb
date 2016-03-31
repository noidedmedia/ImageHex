# frozen_string_literal: true
class CommissionOffer < ActiveRecord::Base
  belongs_to :listing
  belongs_to :user
  has_many :subjects, class_name: "CommissionSubject",
                      inverse_of: :commission_offer
  has_one :background, class_name: "CommissionBackground",
                       inverse_of: :commission_offer

  has_many :commission_images
  has_many :images, through: :commission_images

  accepts_nested_attributes_for :subjects,
                                allow_destroy: true
  accepts_nested_attributes_for :background,
                                allow_destroy: true

  validates :user, presence: true

  validates :listing, presence: true,
                      if: :confirmed

  validate :has_acceptable_subject_count
  validate :background_is_acceptable
  validate :not_offering_to_self

  has_one :conversation

  before_save :calculate_price,
              if: :listing

  def calculate_fee
    if offeree.has_filled_commissions?
      ((total_price * 0.12).floor + 0.30).to_i
    else
      0
    end
  end

  def has_background?
    background.present?
  end

  def offeree
    listing.user
  end

  def has_subjects?
    subjects.length > 0
  end

  delegate :name, to: :offeree, prefix: true

  def involves?(u)
    offeree == u || user == u
  end

  def confirm!
    transaction do
      self.confirmed = true
      touch(:confirmed_at)
      save
      Notification.create(user: offeree,
                          subject: self,
                          kind: :commission_offer_confirmed)
      Conversation.create(commission_offer: self,
                          users: [user,
                                  offeree])
    end
  end

  def accept!
    return false unless confirmed?
    transaction do
      self.accepted = true
      touch(:accepted_at)
      save
      Notification.create(user: user,
                          subject: self,
                          kind: :commission_offer_accepted)
    end
  end

  ##
  # Don't do this in a transaction because we'd rather not notify and make
  # the charge than do neither
  def charge!(stripe_charge_id)
    time_due = listing.weeks_to_completion.weeks.from_now
    update(stripe_charge_id: stripe_charge_id,
           charged: true,
           charged_at: Time.now,
           due_at: time_due)
    Notification.create(user: offeree,
                        subject: self,
                        kind: :commission_offer_charged)
  end

  def fill!(image)
    self.class.transaction do
      images << image
      Notification.create(user: user,
                          kind: :commission_offer_filled,
                          subject: self)
      update(filled_at: Time.now,
             filled: true)
    end
  end

  protected

  def not_offering_to_self
    if user_id == listing.try(:user_id)
      errors.add('user', "cannot offer to yourself!")
    end
  end

  def background_is_acceptable
    return unless listing
    if has_background? && !listing.allow_background?
      errors.add(:background, "Not allowed")
    end
  end

  def has_acceptable_subject_count
    return unless listing
    if (s = listing.try(:maximum_subjects)) && subjects.size > s
      errors.add(:subjects, "have more than this product's maximum")
    end
    unless listing.allow_further_subjects?
      if subjects.size > listing.included_subjects
        errors.add(:subject, "have too many")
      end
    end
  end

  def calculate_price
    p = listing
    i = p.base_price
    subject_charge_count = subjects.size - p.included_subjects
    i += p.subject_price * subject_charge_count if subject_charge_count > 0
    i += p.background_price if has_background? && p.charge_for_background?
    self.total_price = i
  end
end
