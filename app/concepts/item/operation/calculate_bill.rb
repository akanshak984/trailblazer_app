module Item::Operation
  class CalculateBill < Trailblazer::Operation
    step :calculate_order_amount
    step :calculate_delivery_charges
    step :calculate_bill

    def calculate_order_amount(ctx, **)
      order_amount = 0
      ctx[:order_items].each do |item|
        order_amount += item[:price]
      end
      ctx[:order_amount] = order_amount
    end

    def calculate_delivery_charges(ctx, **)
      if ctx[:self_pickup].to_s == "true"
        ctx[:delivery_charges] = 0
      else
        ctx[:delivery_charges] = 0.05 * ctx[:order_amount]
      end
    end

    def calculate_bill(ctx, **)
      ctx[:bill_amount] = ctx[:order_amount] + ctx[:delivery_charges]
    end
  end
end

# result = Item::Operation::CalculateBill.(INPUT1)
# result[:bill_amount]