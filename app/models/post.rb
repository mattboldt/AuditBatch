class Post < ApplicationRecord
  belongs_to :user
  enum status: [:pending, :active, :deactivated]

  audited associated_with: :user

  def self.update_all_with_audits(updates)
    result = ActiveRecord::Base.connection.exec_query(select(:id, *updates.keys).to_sql)
    current_values = result.to_hash

    if update_all(updates)
      audits = current_values.map do |value|
        {
          auditable_id: value['id'],
          auditable_type: self.name,
          audited_changes: updates.to_hash,
          comment: '',
        }
      end
      audits
      Audited.audit_class.import(audits)
    end
  end
end
