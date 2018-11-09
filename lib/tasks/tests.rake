require 'benchmark'

namespace :tests do
  task run: :environment do

    Benchmark.bm do |x|
      x.report do
        puts "records to update: #{Post.count}"
      end

      x.report('update:') do
        puts "Initial audit count: #{Audited.audit_class.count}"
        Post.where(status: :pending).find_each do |post|
          post.update(title: 'updated this record')
        end
        puts "New audit count: #{Audited.audit_class.count}"
      end

      x.report('update_all_with_audits:') do
        puts "Initial audit count: #{Audited.audit_class.count}"
        Post.where(status: :pending).update_all_with_audits(title: 'Batch post title')
        puts "New audit count: #{Audited.audit_class.count}"
      end
    end
  end
end
