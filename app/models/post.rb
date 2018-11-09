class Post < ApplicationRecord
  belongs_to :user
  enum status: [:pending, :active, :deactivated]

  audited associated_with: :user

  scope :foo, -> { where(status: :pending) }

  def self.up
    self.update_all_with_audits(status: :pending)
  end

  def self.update_all_with_audits(updates)
    return unless update_all(updates)
    AuditBatch.new(self, updates).create
  end
end
