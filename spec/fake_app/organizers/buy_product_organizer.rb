module BuyProductOrganizer
  extend Zertico::Organizer

  organize [ CreateProductInteractor, CreateInvoiceInteractor ]
end