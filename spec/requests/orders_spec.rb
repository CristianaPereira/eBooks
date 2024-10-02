require 'rails_helper'

RSpec.describe "/orders", type: :request do
  # This should return the minimal set of attributes required to create a valid
  # Order. As you add validations to Order, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    { ebook_id: Ebook.all.sample.id, user_id: User.all.sample.id }
  }

  let(:invalid_attributes) {
    { ebook_id: Ebook.last.id+1, user_id: User.last.id+1 }
  }

  let(:valid_headers) {
    # TODO: add cookie for authentication
    {}
  }

  describe "GET /show" do
    it "renders a successful response" do
      order = Order.create! valid_attributes
      get api_order_url(order), as: :json
      expect(response).to be_successful
      expect(response.parsed_body).to eq(order.as_json)
    end

    it "renders a ERROR response" do
      get api_order_url(Order.last.id+1), as: :json
      expect(response).to be_not_found
      expect(response.parsed_body).to eq({ "error" => "record_not_found" })
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Order" do
        expect {
          post api_orders_url params: { order: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Order, :count).by(1)
      end

      it "renders a JSON response with the new order" do
        post api_orders_url params: { order: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Order" do
        total = Order.count
        expect {
          post api_orders_url params: { order: invalid_attributes }, as: :json
        }.to change(Order, :count).by(0)
        expect(Order.count).to eq(total)
      end

      it "renders a JSON response with errors for the new order" do
        post api_orders_url,
             params: { order: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
