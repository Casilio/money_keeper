class TransactionsController < ApplicationController
  before_action :get_categories, only: [:index, :edit]
  before_action :get_transaction, only: [:destroy, :edit, :update]
  before_action :get_transactions, only: [:index]

  def index
    @transaction = Transaction.new(event_date: Time.zone.now, amount: 1)
  end

  def create
    @transaction = Transaction.new(transaction_params)
    @transaction.user = @transaction.category.user
    if @transaction.save
      flash[:success] = "Transaction was added."
      redirect_to transactions_path
    else
      render "index"
    end
  end

  def edit

  end

  def update
    save = @transaction.update_attributes(transaction_params)
    flow = @transaction.category.flow
    if flow == "income"
      @categories = current_user.categories.income
    else
      @categories = current_user.categories.expense
    end

    if save
      flash[:success] = "Transaction was updated"
      redirect_to transactions_path
    else
      render "edit"
    end
  end

  def destroy
    @transaction.destroy
    flash[:success] = "Transaction was removed."
    redirect_to transactions_path
  end

  private

    def get_categories
      @categories = current_user.categories.all
    end

    def transaction_params
      params.require(:transaction).permit(:amount, :description, :category_id, :event_date)
    end

    def get_transaction
      @transaction = Transaction.find(params[:id])
    end

    def get_transactions
      @transactions = current_user.transactions.paginate(page: params[:page])
    end
end
