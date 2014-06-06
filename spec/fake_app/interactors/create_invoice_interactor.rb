class CreateInvoiceInteractor < Zertico::Interactor
  def perform(attributes, objects)
    @invoice = Invoice.create(attributes)
  end

  def rollback
    @invoice.destroy
  end
end