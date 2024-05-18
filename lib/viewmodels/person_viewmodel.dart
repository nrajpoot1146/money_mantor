import 'package:money_mantor/models/person_model.dart';
import 'package:money_mantor/mvvm/viewmodel.dart';
import 'package:money_mantor/repository/person_repo.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_add_event.dart';
import 'package:money_mantor/viewmodels/events/person_events/person_loaded_event.dart';

import 'events/loading_event.dart';

class PersonViewModel extends EventViewModel {
  final PersonRepo _personRepo;

  PersonViewModel(this._personRepo);

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
}
