ThinkingSphinx::Index.define :user, with: :active_record do
  # fields
  indexes username, sortable: true
end
