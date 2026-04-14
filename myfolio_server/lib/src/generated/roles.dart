/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod/serverpod.dart' as _i1;

abstract class Roles implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Roles._({
    this.id,
    required this.title,
    required this.description,
    this.yearsOfExperience,
    int? displayOrder,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) : displayOrder = displayOrder ?? 0,
       updatedAt = updatedAt ?? DateTime.now(),
       createdAt = createdAt ?? DateTime.now();

  factory Roles({
    int? id,
    required String title,
    required String description,
    int? yearsOfExperience,
    int? displayOrder,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) = _RolesImpl;

  factory Roles.fromJson(Map<String, dynamic> jsonSerialization) {
    return Roles(
      id: jsonSerialization['id'] as int?,
      title: jsonSerialization['title'] as String,
      description: jsonSerialization['description'] as String,
      yearsOfExperience: jsonSerialization['yearsOfExperience'] as int?,
      displayOrder: jsonSerialization['displayOrder'] as int?,
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
    );
  }

  static final t = RolesTable();

  static const db = RolesRepository._();

  @override
  int? id;

  String title;

  String description;

  int? yearsOfExperience;

  int? displayOrder;

  DateTime? updatedAt;

  DateTime? createdAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Roles]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Roles copyWith({
    int? id,
    String? title,
    String? description,
    int? yearsOfExperience,
    int? displayOrder,
    DateTime? updatedAt,
    DateTime? createdAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Roles',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
      if (displayOrder != null) 'displayOrder': displayOrder,
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Roles',
      if (id != null) 'id': id,
      'title': title,
      'description': description,
      if (yearsOfExperience != null) 'yearsOfExperience': yearsOfExperience,
    };
  }

  static RolesInclude include() {
    return RolesInclude._();
  }

  static RolesIncludeList includeList({
    _i1.WhereExpressionBuilder<RolesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RolesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RolesTable>? orderByList,
    RolesInclude? include,
  }) {
    return RolesIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Roles.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Roles.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _RolesImpl extends Roles {
  _RolesImpl({
    int? id,
    required String title,
    required String description,
    int? yearsOfExperience,
    int? displayOrder,
    DateTime? updatedAt,
    DateTime? createdAt,
  }) : super._(
         id: id,
         title: title,
         description: description,
         yearsOfExperience: yearsOfExperience,
         displayOrder: displayOrder,
         updatedAt: updatedAt,
         createdAt: createdAt,
       );

  /// Returns a shallow copy of this [Roles]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Roles copyWith({
    Object? id = _Undefined,
    String? title,
    String? description,
    Object? yearsOfExperience = _Undefined,
    Object? displayOrder = _Undefined,
    Object? updatedAt = _Undefined,
    Object? createdAt = _Undefined,
  }) {
    return Roles(
      id: id is int? ? id : this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience is int?
          ? yearsOfExperience
          : this.yearsOfExperience,
      displayOrder: displayOrder is int? ? displayOrder : this.displayOrder,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
    );
  }
}

class RolesUpdateTable extends _i1.UpdateTable<RolesTable> {
  RolesUpdateTable(super.table);

  _i1.ColumnValue<String, String> title(String value) => _i1.ColumnValue(
    table.title,
    value,
  );

  _i1.ColumnValue<String, String> description(String value) => _i1.ColumnValue(
    table.description,
    value,
  );

  _i1.ColumnValue<int, int> yearsOfExperience(int? value) => _i1.ColumnValue(
    table.yearsOfExperience,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int? value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );
}

class RolesTable extends _i1.Table<int?> {
  RolesTable({super.tableRelation}) : super(tableName: 'roles') {
    updateTable = RolesUpdateTable(this);
    title = _i1.ColumnString(
      'title',
      this,
    );
    description = _i1.ColumnString(
      'description',
      this,
    );
    yearsOfExperience = _i1.ColumnInt(
      'yearsOfExperience',
      this,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
  }

  late final RolesUpdateTable updateTable;

  late final _i1.ColumnString title;

  late final _i1.ColumnString description;

  late final _i1.ColumnInt yearsOfExperience;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDateTime updatedAt;

  late final _i1.ColumnDateTime createdAt;

  @override
  List<_i1.Column> get columns => [
    id,
    title,
    description,
    yearsOfExperience,
    displayOrder,
    updatedAt,
    createdAt,
  ];
}

class RolesInclude extends _i1.IncludeObject {
  RolesInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Roles.t;
}

class RolesIncludeList extends _i1.IncludeList {
  RolesIncludeList._({
    _i1.WhereExpressionBuilder<RolesTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Roles.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Roles.t;
}

class RolesRepository {
  const RolesRepository._();

  /// Returns a list of [Roles]s matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order of the items use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// The maximum number of items can be set by [limit]. If no limit is set,
  /// all items matching the query will be returned.
  ///
  /// [offset] defines how many items to skip, after which [limit] (or all)
  /// items are read from the database.
  ///
  /// ```dart
  /// var persons = await Persons.db.find(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.firstName,
  ///   limit: 100,
  /// );
  /// ```
  Future<List<Roles>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RolesTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RolesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RolesTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Roles>(
      where: where?.call(Roles.t),
      orderBy: orderBy?.call(Roles.t),
      orderByList: orderByList?.call(Roles.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Roles] matching the given query parameters.
  ///
  /// Use [where] to specify which items to include in the return value.
  /// If none is specified, all items will be returned.
  ///
  /// To specify the order use [orderBy] or [orderByList]
  /// when sorting by multiple columns.
  ///
  /// [offset] defines how many items to skip, after which the next one will be picked.
  ///
  /// ```dart
  /// var youngestPerson = await Persons.db.findFirstRow(
  ///   session,
  ///   where: (t) => t.lastName.equals('Jones'),
  ///   orderBy: (t) => t.age,
  /// );
  /// ```
  Future<Roles?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RolesTable>? where,
    int? offset,
    _i1.OrderByBuilder<RolesTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<RolesTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Roles>(
      where: where?.call(Roles.t),
      orderBy: orderBy?.call(Roles.t),
      orderByList: orderByList?.call(Roles.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Roles] by its [id] or null if no such row exists.
  Future<Roles?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Roles>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Roles]s in the list and returns the inserted rows.
  ///
  /// The returned [Roles]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Roles>> insert(
    _i1.DatabaseSession session,
    List<Roles> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Roles>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Roles] and returns the inserted row.
  ///
  /// The returned [Roles] will have its `id` field set.
  Future<Roles> insertRow(
    _i1.DatabaseSession session,
    Roles row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Roles>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Roles]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Roles>> update(
    _i1.DatabaseSession session,
    List<Roles> rows, {
    _i1.ColumnSelections<RolesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Roles>(
      rows,
      columns: columns?.call(Roles.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Roles]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Roles> updateRow(
    _i1.DatabaseSession session,
    Roles row, {
    _i1.ColumnSelections<RolesTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Roles>(
      row,
      columns: columns?.call(Roles.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Roles] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Roles?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<RolesUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Roles>(
      id,
      columnValues: columnValues(Roles.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Roles]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Roles>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<RolesUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<RolesTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<RolesTable>? orderBy,
    _i1.OrderByListBuilder<RolesTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Roles>(
      columnValues: columnValues(Roles.t.updateTable),
      where: where(Roles.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Roles.t),
      orderByList: orderByList?.call(Roles.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Roles]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Roles>> delete(
    _i1.DatabaseSession session,
    List<Roles> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Roles>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Roles].
  Future<Roles> deleteRow(
    _i1.DatabaseSession session,
    Roles row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Roles>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Roles>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RolesTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Roles>(
      where: where(Roles.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<RolesTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Roles>(
      where: where?.call(Roles.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Roles] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<RolesTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Roles>(
      where: where(Roles.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
