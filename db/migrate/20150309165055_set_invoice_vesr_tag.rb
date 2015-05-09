class SetInvoiceVesrTag < ActiveRecord::Migration
  def up
    return unless BankAccount.tagged_with('invoice:vesr')

    account = BankAccount.find_by_code('1020')
    if account
    account.tag_list << 'invoice:vesr'
    account.save!
    else
      puts  "BankAccount.find_by_code('1020') - not found during migration !!"
    end
  end
end
