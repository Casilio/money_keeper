class TransactionsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_categories, only: [:index, :edit, :update, :create]
  before_action :get_transaction, only: [:destroy, :edit, :update]
  before_action :get_transactions, only: [:index, :create]
  before_action :check_user, only: [:edit, :update, :destroy]

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
    if @transaction.update_attributes(transaction_params)
      flash[:success] = "Transaction was updated"
      redirect_to transactions_path
    else
      render "edit"
    end
  end

  def destroy
    flow = @transaction.category.flow
    new_balance = current_user.balance(format: false).to_f - @transaction.amount
    if flow == "income" and new_balance < 0
        flash[:danger] = "Operation was not perform. Balance can't be less than zero."
        redirect_to transactions_path
    else
      @transaction.destroy
      flash[:success] = "Transaction was removed."
      redirect_to transactions_path
    end
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

    def check_user
      if !current_user?(@transaction.user)
        redirect_to root_path
      end
    end
end
