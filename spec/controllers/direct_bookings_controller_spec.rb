require 'spec_helper'

shared_examples "direct booking actions" do
  describe "should create a new direct booking" do
    it "creates a new direct booking" do
      booking_template = FactoryGirl.create(:invoice_booking_template)
      xhr :get, :new, {:direct_booking => {:booking_template_id => booking_template.id}}
      expect(response).to render_template('new')
      expect(assigns(:direct_booking).value_date).to eq(Date.today)
    end

    it "creates a direct booking" do
      invoice = FactoryGirl.create(:invoice)
      credit_account = FactoryGirl.create(:credit_account)
      debit_account = FactoryGirl.create(:service_account)
      comment = 'Schon wieder gemahnt.'
      xhr :post, :create, :direct_booking => {:title => 'Mahnung',
                                              :debit_account_id => debit_account.id,
                                              :credit_account_id => credit_account.id,
                                              :reference_id => invoice.id,
                                              :reference_type => 'Invoice',
                                              :value_date => Date.today,
                                              :amount => 20.0,
                                              :comments => comment}
      expect(response).to render_template('list')
      expect(assigns(:direct_booking)).not_to be_nil
      expect(assigns(:direct_booking).comments).to eq(comment)
      expect(assigns(:direct_account)).not_to be_nil
      expect(assigns(:direct_account)).to eq(assigns(:direct_booking).balance_account)
    end
  end
end

describe DirectBookingsController do
  context "as admin" do
    login_admin
    it_behaves_like "direct booking actions"
  end

  context "as accountant" do
    login_accountant
    it_behaves_like "direct booking actions"
  end
end
