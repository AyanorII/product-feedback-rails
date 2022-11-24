class ApplicationController < ActionController::API
  def render_errors(record)
    render json: {
             errors: record.errors.full_messages,
           },
           status: :unprocessable_entity
  end

  def not_found(model, id)
    render json: {
             message: "#{model.to_s.capitalize} with ID: #{id} not found!",
             code: 404,
             type: 'not found',
           },
           status: :not_found
  end
end
