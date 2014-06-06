class CreateProductInteractor < Zertico::Interactor
  def perform(attributes, objects)
    @product = Product.create(attributes)
  end

  def rollback
    @product.destroy
  end
end