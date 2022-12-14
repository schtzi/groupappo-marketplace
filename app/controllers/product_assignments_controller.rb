class ProductAssignmentsController < ApplicationController
  before_action :set_product, only: %i[create]
  before_action :set_product_assignment, only: %i[destroy]

  def create
    @product_assignment = ProductAssignment.new(product_assignment_params)
    if @product_assignment.save
      @product_assignment.booking.update_price
      redirect_to product_booking_path(product_id: :product_id, id: :booking_id)
    else
      render 'products/show', alert: 'sth went wrong'
    end
  end

  def create_bike(product, booking)
    @product_assignment = ProductAssignment.new(product: product, booking: booking)
    @product_assignment.save
    booking.update_price
  end

  def destroy
    @product_assignment.destroy
    redirect_to product_booking_path(product_id: :product_id, id: :booking_id)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_product_assignment
    @product_assignment = ProductAssignment.find(params[:id])
  end

  def product_assignment_params
    params.permit(:product_id, :booking_id)
  end

  def permit_booking_id
    params.permit(:booking_id)
  end
end
