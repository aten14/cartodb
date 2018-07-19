require 'carto/db/migration_helper'

include Carto::Db::MigrationHelper

migration(
  Proc.new do
    create_table :oauth_apps_users do
      foreign_key :oauth_app_id, :oauth_apps, type: :uuid, null: false, index: true, on_delete: :cascade
      foreign_key :user_id, :users, type: :uuid, null: false, index: true, on_delete: :cascade
      foreign_key :api_key_id, :api_keys, type: :uuid, null: false, index: true, on_delete: :restrict
      column      :scopes, 'text[]', null: false, default: "'{}'".lit
      String      :code, null: true
      DateTime    :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime    :updated_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end,
  Proc.new do
    drop_table :oauth_apps_users
  end
)
