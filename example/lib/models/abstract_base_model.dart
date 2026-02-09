abstract class AbstractBaseModel<Id> {
  Id? id;

  AbstractBaseModel({this.id});

  Map<String, dynamic> toMap();
}
