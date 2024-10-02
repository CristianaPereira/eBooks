# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview
  def confirmation_email
    OrderMailer.with(order: Order.first).confirmation_email
  end
end
