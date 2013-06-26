Spree::Variant.class_eval do
  
  include ActionView::Helpers::NumberHelper
  
  attr_accessible :option_values
  
  def to_hash
    actual_price  = self.price
    #actual_price += Calculator::Vat.calculate_tax_on(self) if Spree::Config[:show_price_inc_vat]
    { 
      :id    => self.id, 
      # :count => 1, # Rosario self.count_on_hand is not available anymore on Spree 2.0, 
      :price => number_to_currency(actual_price)
    }
  end
    
end
