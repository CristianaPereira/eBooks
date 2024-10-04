class OrderMailer < ApplicationMailer
  def confirmation_email
    @order = params[:order]
    @user = @order.user
    @find_books_url = "#{ENV["DOMAIN"]}/ebooks"
    mail(to: @user.email, subject: "Order ##{@order.id} Confirmed")
  end
end
