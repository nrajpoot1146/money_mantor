import 'package:money_mantor/models/saving_data_model_base.dart';
import 'package:money_mantor/repository/repo_base.dart';

class BankDataRepo extends RepoBase<SavingDataModelBase>
{
  BankDataRepo(super.db, super.logger);
}