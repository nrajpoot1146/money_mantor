import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/mvvm/viewmodel.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_add_event.dart';
import 'package:money_mantor/viewmodels/events/transactions_loaded_event.dart';

class TransactionViewModel extends EventViewModel {
  final TransactionRepo _transactionRepo;

  TransactionViewModel(this._transactionRepo);

  /// Add transaction to db
  void add(Transaction transaction) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.add(transaction).then(
          (value) => {
            notify(
              LoadingEvent(isLoading: false),
            ),
            notify(
              TransactionAddEvent(isAdded: value != 0),
            ),
          },
        );
  }

  void addOrUpdate(Transaction transaction) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.add(transaction).then(
          (value) => {
            notify(
              LoadingEvent(isLoading: false),
            ),
            notify(
              TransactionAddEvent(isAdded: value != 0),
            ),
          },
        );
  }

  void update(Transaction transaction) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.update(transaction).then(
          (value) => notify(
            LoadingEvent(isLoading: false),
          ),
        );
  }

  void delete(Transaction transaction) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.delete(transaction.id!).then(
          (value) => notify(
            LoadingEvent(isLoading: false),
          ),
        );
  }

  void fetchAll() {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.fetchAll().then(
          (value) => {
            notify(
              LoadingEvent(isLoading: false),
            ),
            notify(
              TransactionsLoadedEvent(value),
            ),
          },
        );
  }
}
