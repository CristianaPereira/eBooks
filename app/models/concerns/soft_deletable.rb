module SoftDeletable
  # intercepts the destroy method and runs the soft_delete method
  def destroy
    callbacks_result = transaction do
      run_callbacks(:destroy) do
        soft_delete
      end
    end
    callbacks_result ? self : false
  end
end
