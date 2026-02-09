## [4.3.0] - 2026-02-09

* Create IconDataExternalField.
* Deprecate IconDataField.

## [4.2.0] - 2026-02-03

* Create ListField.
* Updating IconField and IconData.
* Expose CNPJ and CPF parsers.

## [4.1.0] - 2026-01-30

* Fix null values from fields.

## [4.0.0] - 2026-01-29

* Complete refactoring.

## [3.8.0] - 2025-05-27

* Updating to Flutter 3.32.0 and Dart 3.8.0.
* Updating plugins.

## [3.7.0] - 2025-04-21

* Adding String extension repeat.
* Adding List extension intersperse.
* Removing PackageInfo plugin and version attribute.
* Updating to Flutter 3.29.0 and Dart 3.7.0.
* Updating analysis_options.

## [3.6.0] - 2025-02-02

* Updating to Flutter 3.27.0 and Dart 3.6.0.
* Removing connectivity_plus plugin.
* Updating FontAwesome to 10.8.0.
* Updating FollyUtils.textColorByLuminance to use Colors.computeLuminance.
* Fixing deprecated methods.

## [3.5.0] - 2024-11-02

* Adding package_info_plus to provide version string in AbstractConfig.

## [3.4.1] - 2024-10-27

* Fixing AbstractEdit Navigator pop, by [rilpires](https://github.com/rilpires).

## [3.4.0] - 2024-09-22

* Adding BasicTable.

## [3.3.1] - 2024-09-19

* Fixing FollyMenuHeader text color.

## [3.3.0] - 2024-09-15

* Bumping EmailValidator to ^3.0.0.
* Adding removeNulls method to FollyIterableExtension.
* Renaming `FollyIterableExtension<T extends Enum>` to
  `FollyIterableEnumExtension<T extends Enum>`
* Adding normalize method to FollyStringExtension.
* Moving methods above to FollyStringExtension.
    * isPascalCase
    * isCamelCase
    * isSnakeCase
    * camel2Snake
    * pascal2Camel
    * camel2Pascal
    * snake2Pascal
    * snake2Camel
    * pascal2Snake

## [3.2.3] - 2024-06-20

* Adding translations for AbstractEdit.
* Updating analysis_options.yaml.

## [3.2.2] - 2024-05-23

* Removing duration field.

## [3.2.1] - 2024-05-23

* Updating to Flutter 3.22.0 and Dart 3.4.0.

## [3.1.2] - 2024-05-14

* Changing getLeading method from AbstractBuilder to be able to return null.
* Updating ListField:
    * Fixing component's alignment.
    * Adding properties to configure the icons.
    * Feature to manual sort the list.

## [3.1.1] - 2024-05-13

* Updating decorators from:
    * BoolField
    * ListField
    * TableField
    * ModelField
* Removing deprecate methods from ModelUtils.
* Adding EmptyButton to ResponsiveStateless.

## [3.1.0] - 2024-05-08

* Updating TableField.
* Renaming HeaderCell to HeaderText.
* Adding new properties to TableIconButton.

## [3.0.2] - 2024-04-11

* Adding leadingWidth to AbstractEdit and AbstractList.

## [3.0.1] - 2024-03-31

* Updating Connectivity Plus to ^6.0.1.

## [3.0.0] - 2024-03-31

* Upgrade to Flutter 3.19.0 and Dart 3.3.0.
* Updating Connectivity Plus to ^6.0.0.
* Removing FileField and FileEditingController.

## [2.7.0] - 2024-02-11

* Updating to Font Awesome 10.7.0.
* Updating analysis_options.yaml.
* Updating ChoiceChipField style and adding multiple selection.
* Fixing Hashable mixin.
* Deprecating FileField and FileEditingController for new desktop
  implementation.

## [2.6.1] - 2024-01-27

* Adding counterText to fields.

## [2.6.0] - 2024-01-26

* Adding widget to DropdownField child.

## [2.5.1] - 2024-01-22

* Rolling back ModelUtils.
* Renaming uiBuilder to builder.
* Adding builder and consumer to actions and rowActions attributes in
  AbstractList.
* Creating ModelUtils methods:
    * fromJsonProducerMap
    * fromJsonListProducerMap
    * fromJsonSetProducerMap
* Deprecating ModelUtils methods:
    * fromJsonModel
    * fromJsonList
    * fromJsonSet
    * fromJsonSafeEnumSet
    * fromJsonSafeEnumList

## [2.5.0] - 2024-01-22

* Creating ModelUtils.fromProducer method.
* Adding types for ModelUtils methods:
    * fromJsonList (internal type)
    * fromJsonSet (internal type)
    * _fromJsonRawIterable (private method)
    * fromJsonRawMap
    * fromJsonSafeList
    * fromJsonSafeSet
    * fromJsonSafeStringList (internal type)
    * fromJsonSafeStringSet (internal type)

## [2.4.3] - 2024-01-19

* Creating FollyIterableExtension.byNameOrNull method.

## [2.4.2] - 2024-01-04

* Fixing AbstractEdit model return.

## [2.4.1] - 2024-01-02

* Fixing CircularWaiting.

## [2.4.0] - 2024-01-02

* Creating FollyCell.textHeaderRight.
* Updating plugins.
* Creating FollyIterableExtension for Enums.
* Adding exitWithoutSaveMessage to AbstractEdit.
* Adding saveErrorText to AbstractEdit.
* Updating to PopScope.
* Adding onDeleteError to AbstractList class.
* Adding onSaveError to AbstractEdit class.

## [2.3.0] - 2023-10-15

* Updating Ipv4Address tests.
* Updating plugins.

## [2.2.1] - 2023-09-30

* Fixing LicencePlateValidator.
* Updating type attribute in FileField.
* Updating plugins.

## [2.2.0] - 2023-08-21

* Upgrading to Flutter 3.13.0 and Dart 3.1.0.
* Updating analysis_options.yaml.
* Updating ModelUtils methods:
    * fromJsonSet
    * fromJsonSafeList
    * fromJsonSafeSet

## [2.1.3] - 2023-08-18

* Adding internal padding to FollyCell.
* Fixing AbstractEdit model return.

## [2.1.2] - 2023-08-09

* Renaming the states classes to respect private visibility:
    * _BaseStatefulFieldState
    * _BoolFieldState
    * _ChoiceChipFieldState
    * _DropdownFieldState
    * _FileFieldState
    * _IconDataFieldState
* Adding AbstractValidator to field's constructor:
    * CepField
    * CestField
    * CnaeField
    * CnpjField
    * CpfCnpjField
    * CpfField
    * CreditCardExpirationField
    * EmailField
    * Ipv4Field
    * LicencePlateField
    * LocalPhoneField
    * MacAddressField
    * MobilePhoneField
    * NcmField
    * PhoneField

## [2.1.1] - 2023-08-06

* Fixing ModelField.

## [2.1.0] - 2023-08-06

* Fixing ModelEditingController.
* Adding ID type to ModelField.
* Changing ModelUtils.toSaveMapOnlyId visibility.

## [2.0.2] - 2023-07-29

* Fixing the returned value of AbstractEdit to AbstractList.

## [2.0.1] - 2023-07-27

* Creating AbstractConsumer idFrom method.

## [2.0.0] - 2023-07-26

* Correcting id object type to AbstractModel.
* Adding ConsumerPermission.allowAll constructor.
* Updating AbstractConsumer saveOrUpdate method to return AbstractModel ID.
* Updating AbstractEdit:
    * Method afterSave now receive ID instead AbstractModel.
    * Navigator pop now return ID instead AbstractModel.

## [1.2.4] - 2023-07-18

* Updating implementation of columnsHeaders in TableField.

## [1.2.3] - 2023-07-16

* Fixing NewDecimalField example.
* Creating FollyUtils.colorHex method.
* Updating FollyUtils.colorParser to return null instead default color.
* Renaming HomeCard backgroundColor to color.

## [1.2.2] - 2023-07-15

* Removing nullable from columnBuilders in FollyTable.

## [1.2.1] - 2023-07-15

* Removing column attribute to FollyTableColumnBuilder.

## [1.2.0] - 2023-07-15

* Adding column attribute to FollyTableColumnBuilder.
* Removing Duplet class.

## [1.1.1] - 2023-07-12

* Fixing AbstractList mount status.

## [1.1.0] - 2023-06-29

* Creating FollyTableColumnBuilder to help build columns for FollyTable.
* Deprecating Duplet and Triplet classes instead of using Dart Records.
* Bump Font Awesome to ^10.5.0.
* AbstractUIBuilder updates:
    * Method buildBottomNavigationBar return Widget? instead Widget.
    * Removing method buildBackgroundContainer.
    * Creating method buildListBody.
    * Creating method buildSearchBody.
    * Creating method buildEditBody.

## [1.0.4] - 2023-06-04

* Splitting FollyCell to a new file.
* Removing AbstractModel.fromMultiMap call from ModelUtils.fromJsonList method.

## [1.0.3] - 2023-06-03

* Fixing ModelUtils.fromJsonList method.

## [1.0.2] - 2023-05-29

* Allow NewDecimalField to work with negative numbers.

## [1.0.1] - 2023-05-29

* Updating linter rules.
* Removing Dart Code Metrics.

## [1.0.0] - 2023-05-17

* Upgrade to Flutter 3.10 and Dart 3.0.0.
* Updating class Decimal features.
* Removing deprecated classes and methods.
* Creating FollyStringExtension with methods:
    * capitalize.
    * capitalizeWords.
* Creating ModelUtils methods:
    * fromJsonSafeBool
* Creating classes for tests:
    * Duplet
    * Triplet
* Updating AbstractUIBuilder to use null string for labelPrefix and labelSuffix.
* Removing labelPrefix and editController from formContent method.
* Removing AbstractEditContent class.

## [0.22.3] - 2023-05-12

* Adding FollyUtils.colorParse method.

## [0.22.2] - 2023-05-11

* Fixing ModelUtils methods:
    * fromJsonDateMillis.
    * fromJsonDateSecs.
    * fromJsonNullableDateMillis.
    * fromJsonNullableDateSecs.
    * toSaveMapId.
* Creating ModelUtils methods:
    * fromJsonRawIterable.
    * fromJsonSet.
    * fromJsonSafeSet.
    * fromJsonSafeStringSet.
    * toMapSet.
    * toSaveSetMapId.
    * toSaveSet.
    * toMapDecimalInt.
    * toMapDecimalDouble.
* Creating DateTimeExtension methods:
    * startOfDay.
    * endOfDay.
    * yearFirstDay.
    * yearLastDay.
* Creating tests for ModelUtils.
* Disposing fields controllers.

## [0.22.1] - 2023-04-02

* Adding chipExternalPadding and chipInternalPadding to ChoiceChipField.
* Adding new methods to DateTimeExtension:
    * prevWeekFirstDay.
    * prevWeekLastDay.
    * nextWeekFirstDay.
    * nextWeekLastDay.
* Adding FollyValidators:
    * stringNotBlank(String? value).
    * stringNullNotBlank(String? value).
    * notEmpty(dynamic value).
    * notBlank(dynamic value).
* Fixing bugs in ColorValidator and DateTimeValidator.

## [0.22.0] - 2023-04-01

* Creating DateTimeExtension.

## [0.20.4] - 2023-03-26

* Fixing CreditCardNumberField suffixIcon attribute.

## [0.21.2] - 2023-03-21

* Updating Date and Time Fields.

## [0.20.3] - 2023-03-21

* Updating Date and Time Fields.

## [0.21.1] - 2023-03-20

* Fixing DateTimeEditingController file typo.

## [0.20.2] - 2023-03-20

* Fixing DateTimeEditingController file typo.

## [0.21.0] - 2023-03-16

* AbstractEdit
    * Deprecating modelFunctions attribute.
    * Creating actions attribute.
* Abstract List
    * Deprecating mapFunctions attribute.
    * Deprecating modelFunctions attribute.
    * Creating actions attribute.
    * Creating rowActions attribute.
* Deprecating Classes
    * AbstractFunctionInterface
    * AbstractMapFunction
    * AbstractModelFunction
    * AbstractFunction
    * MapFunction
    * ModelFunction

## [0.20.1] - 2023-02-25

* Fixing BaseStatefulField.

## [0.19.1] - 2023-02-24

* Fixing NewDecimalField.

## [0.20.0] - 2023-02-21

* Adding onTap attribute to all fields.
* Splitting Field Controllers
* Updating default behavior from fields:
    * ColorField
    * DateField
    * DateTimeField
    * DurationField
    * DecimalField
    * NewDecimalField

## [0.19.0] - 2023-02-16

* Upgrade to font_awesome_flutter 10.4.0.
* Adding intValue and doubleValue to NewDecimalEditingController.

## [0.18.2] - 2023-02-14

* Fixing NewDecimalField.

## [0.18.1] - 2023-02-13

* Fixing NewDecimalField.

## [0.18.0] - 2023-02-13

* Adding NewDecimalField.
* Update to Flutter 3.7.0 and Dart 2.19.0.
* Fixing README.md typo.

## [0.17.4] - 2022-12-23

* Adding afterSave callback in AbstractEdit.

## [0.17.3] - 2022-12-21

* Checking if scroll controller position has content dimensions in AbstractList.

## [0.17.2] - 2022-12-13

* Updating appBarLeading to use context.

## [0.17.1] - 2022-12-13

* Adding AppBar Leading widget to AbstractList.
* Adding AppBar Leading widget to AbstractEdit.

## [0.17.0] - 2022-12-12

* Update to FontAwesome 10.3.0.
* Adding Ipv4Address class.

## [0.16.4] - 2022-12-04

* Adding Ipv4Field.
* Organizing imports.
* Updating CI script.

## [0.16.3] - 2022-11-10

* Adding contentPadding to the fields.
* Adding new tests for FollyUtils.

## [0.16.2] - 2022-11-05

* Updating README.md.
* Removing deprecated method fakeMaterialColor.

## [0.16.1] - 2022-11-01

* Updating README.md.
* Adding new tests for FollyValidators.
* Deprecating AbstractEnumParser.

## [0.16.0] - 2022-10-30

* Initial pub.dev publish

## [0.0.1] - 2020-11-17

* Initial release.
