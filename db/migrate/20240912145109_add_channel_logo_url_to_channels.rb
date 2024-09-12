class AddChannelLogoUrlToChannels < ActiveRecord::Migration[7.1]
  def change
    add_column :channels, :channel_logo_url, :string
  end
end
