import 'package:injectable/injectable.dart';
import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/models/transaction_model.dart';
import 'package:money_mantor/utils/mvvm/base_viewmodel.dart';
import 'package:money_mantor/repository/person_repo.dart';
import 'package:money_mantor/repository/transaction_repo.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_add_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_loaded_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/total_amount_loaded_event.dart';

import 'events/loading_event.dart';

@injectable
class PersonViewModel extends BaseViewModel {
  final PersonRepo _personRepo;
  final TransactionRepo _transactionRepo;

  PersonViewModel(this._personRepo, this._transactionRepo, super.logger);

  /// Add transaction to db
  void add(Person person) {
    notify(
      LoadingEvent(isLoading: true),
    );

    _personRepo.add(person).then((value) {
      notify(
        LoadingEvent(isLoading: false),
      );
    });
  }

  void updateOrAdd(Person person) {
    notify(
      LoadingEvent(isLoading: true),
    );

    _personRepo.update(person).then((value) => {
          if (value == 0)
            {
              _personRepo.add(person).then(
                    (value) => {
                      notify(
                        LoadingEvent(isLoading: false),
                      ),
                      notify(
                        PersonAddEvent(value != 0),
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
                PersonAddEvent(value != 0),
              )
            }
        });
  }

  void update(Person person) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _personRepo.update(person).then(
          (value) => notify(
            LoadingEvent(isLoading: false),
          ),
        );
  }

  void delete(Person transaction) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _personRepo.delete(transaction.id!).then((value) => {
          notify(
            LoadingEvent(isLoading: false),
          ),
          // notify(TransactionDeletedEvent(transaction: transaction)),
        });
  }

  void deleteById(int id) {
    notify(
      LoadingEvent(isLoading: true),
    );
    _personRepo.delete(id).then((value) => {
          notify(
            LoadingEvent(isLoading: false),
          ),
          //notify(TransactionDeletedEvent()),
        });
  }

  void fetchAll() {
    notify(
      LoadingEvent(isLoading: true),
    );
    _personRepo.fetchAll().then(
          (value) => {
            notify(
              LoadingEvent(isLoading: false),
            ),
            notify(
              PersonLoadedEvent(value!),
            ),
          },
        );
  }

  void fetchNetTotalAmountByPerson(Person person) {
    _transactionRepo.fetchAllByPerson(person).then(
          (value){
            var totalAmount = 0.0;
            for (var t in value!) {
              if(t.transactionType == TransactionType.Given) {
                totalAmount -= t.amount;
              } else {
                totalAmount += t.amount;
              }
            }
            notify(
              TotalAmountLoadedEvent(
                {
                  "personid": person.id.toString(),
                  "amount": totalAmount.toString(),
                },
              ),
            );
          },
        );
  }
}
