import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/mvvm/viewmodel.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/loading_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_events/transaction_add_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_events/transaction_deleted_event.dart';
import 'package:money_mantor/viewmodels/events/transaction_events/transactions_loaded_event.dart';

import '../models/person_model.dart';

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

  void updateOrAdd(Transaction transaction) {
    notify(
      LoadingEvent(isLoading: true),
    );

    _transactionRepo.update(transaction).then((value) => {
          if (value == 0)
            {
              _transactionRepo.add(transaction).then(
                    (value) => {
                      notify(
                        LoadingEvent(isLoading: false),
                      ),
                      notify(
                        TransactionAddEvent(isAdded: value != 0),
                      ),
                    },
                  )
            }
          else
            {
              notify(
                LoadingEvent(isLoading: false),
              ),
              notify(
                TransactionAddEvent(isAdded: value != 0),
              )
            }
        });
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
    deleteById(transaction.id!);
  }

  void deleteById(int id) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.fetchById(id).then((trans) {
      _transactionRepo.delete(id).then(
            (value) => {
              notify(
                LoadingEvent(isLoading: false),
              ),
              notify(TransactionDeletedEvent(transaction: trans!)),
            },
          );
    });
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
              TransactionsLoadedEvent(value!),
            ),
          },
        );
  }

  void fetchAllByPerson(Person p) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _transactionRepo.fetchAllByPerson(p).then(
          (value) => {
            notify(
              LoadingEvent(isLoading: false),
            ),
            notify(
              TransactionsLoadedEvent(value!),
            ),
          },
        );
  }
}
