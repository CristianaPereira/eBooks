class Orders::Create < ApplicationService
  def call(user_id, ebook_id)
    @order = Order.new(user_id: user_id, ebook_id: ebook_id)

    params_checks!
    process_discount!
    @order.save!
    send_email_confirmation
    # success @order
    @order
  end

  private

  def params_checks!
    raise ActiveRecord::RecordInvalid.new(@order) unless @order.valid?
  end

  def process_payment!(payment_ref)
    puts "Process payment"
    # PaymentProcessor.call!(@booking, payment_ref)
  end

  def send_email_confirmation
    puts "Send emails"
    # BookingMailer.confirmation(@booking).deliver_later
  end

  def process_discount!
    @order.total = @order.ebook.price * 0.9
  end
end
