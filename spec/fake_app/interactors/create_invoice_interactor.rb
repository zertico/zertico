class CreateInvoiceInteractor < Zertico::Interactor
  def perform(attributes)
    @invoice = Invoice.create(attributes)
  end

  def rollback
    @invoice.destroy
  end
end