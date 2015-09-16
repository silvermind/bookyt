class CreditInvoicesController < InvoicesController
  defaults :resource_class => CreditInvoice

  # Actions
  def new
    # Allow pre-seeding some parameters
    invoice_params = {
      :customer_id => current_tenant.company.id,
      :state       => 'booked',
      :value_date  => Date.today,
      :due_date    => Date.today.in(current_tenant.payment_period.days).to_date
    }

    # Set default parameters
    invoice_params.merge!(params[:invoice]) if params[:invoice]

    @credit_invoice = CreditInvoice.new(invoice_params)

    @credit_invoice.line_items.build(
      :times          => 1,
      :quantity       => 'x',
      :include_in_saldo_list => ['vat:full'],
      :debit_account  => resource_class.profit_account,
      :credit_account => resource_class.balance_account
    )

    new!
  end
end
