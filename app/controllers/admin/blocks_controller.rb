class Admin::BlocksController < AuthenticatedController

  def index
    @blocks = Block.order("label ASC")
  end

  def show
    @block = Block.find(params[:id])
  end

  def edit
    @block = Block.find(params[:id])
  end

  def update
    @block = Block.find(params[:id])

    if @block.update_attributes(block_params)
      flash[:notice] = "Block successfully updated."
      redirect_to admin_blocks_path
    else
      flash[:error] = @block.errors.full_messages.to_sentence
      render 'admin/blocks/edit'
    end
  end

  private

  def block_params
    params.permit![:block]
  end

end
