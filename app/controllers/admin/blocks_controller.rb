class Admin::BlocksController < AuthenticatedController

  def index
    @blocks = Block.all(:order => "label ASC")
  end

  def show
    @block = Block.find(params[:id])
  end

  def edit
    @block = Block.find(params[:id])
  end

  def update
    @block = Block.find(params[:id])

    if @block.update_attributes(params[:block])
      flash[:notice] = "Block successfully updated."
      redirect_to admin_blocks_path
    else
      flash[:error] = @block.errors.full_messages.to_sentence
      render 'admin/blocks/edit'
    end
  end

end
