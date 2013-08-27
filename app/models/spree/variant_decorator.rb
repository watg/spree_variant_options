Spree::Variant.class_eval do
  
  include ActionView::Helpers::NumberHelper
  
  attr_accessible :option_values
  
  def to_hash(currency)
    # actual_price  = self.price
    #actual_price += Calculator::Vat.calculate_tax_on(self) if Spree::Config[:show_price_inc_vat]
    #actual_price = price_in(currency)
    actual_price = current_price_in(currency)
    
    { 
      :id    => self.id, 
      # :count => 1, # Rosario self.count_on_hand is not available anymore on Spree 2.0, 
      :price => actual_price.display_price.to_s
    }
  end
    
end
