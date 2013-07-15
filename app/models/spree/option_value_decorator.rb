Spree::OptionValue.class_eval do

  attr_accessible :image
  attr_accessible :color_code

  default_scope order("#{quoted_table_name}.position")

  has_attached_file :image,
    :styles        => { :small => '18x18#', :medium => '40x30#', :large => '140x110#' },
    :default_style => :small,
    :url           => "/spree/option_values/:id/:style/:basename.:extension",
    :path          => ":rails_root/public/spree/option_values/:id/:style/:basename.:extension"

  include Spree::Core::S3Support
  supports_s3 :image
  
  
  Spree::Image.attachment_definitions[:attachment][:styles] = ActiveSupport::JSON.decode(Spree::Config[:attachment_styles]).symbolize_keys!
  Spree::Image.attachment_definitions[:attachment][:path] = Spree::Config[:attachment_path]
  Spree::Image.attachment_definitions[:attachment][:url] = Spree::Config[:attachment_url]
  Spree::Image.attachment_definitions[:attachment][:default_url] = Spree::Config[:attachment_default_url]
  Spree::Image.attachment_definitions[:attachment][:default_style] = Spree::Config[:attachment_default_style]

  
  def has_image?
    image_file_name && !image_file_name.empty?
  end

  scope :for_product, lambda { |product| select("DISTINCT #{table_name}.*").where("spree_option_values_variants.variant_id IN (?)", product.variant_ids).joins(:variants)
  }
  
  
end
