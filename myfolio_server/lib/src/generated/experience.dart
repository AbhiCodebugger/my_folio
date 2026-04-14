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

abstract class Experience
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Experience._({
    this.id,
    required this.duration,
    required this.company,
    required this.position,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Experience({
    int? id,
    required String duration,
    required String company,
    required String position,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _ExperienceImpl;

  factory Experience.fromJson(Map<String, dynamic> jsonSerialization) {
    return Experience(
      id: jsonSerialization['id'] as int?,
      duration: jsonSerialization['duration'] as String,
      company: jsonSerialization['company'] as String,
      position: jsonSerialization['position'] as String,
      displayOrder: jsonSerialization['displayOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = ExperienceTable();

  static const db = ExperienceRepository._();

  @override
  int? id;

  String duration;

  String company;

  String position;

  int? displayOrder;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Experience copyWith({
    int? id,
    String? duration,
    String? company,
    String? position,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'duration': duration,
      'company': company,
      'position': position,
      if (displayOrder != null) 'displayOrder': displayOrder,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Experience',
      if (id != null) 'id': id,
      'duration': duration,
      'company': company,
      'position': position,
    };
  }

  static ExperienceInclude include() {
    return ExperienceInclude._();
  }

  static ExperienceIncludeList includeList({
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    ExperienceInclude? include,
  }) {
    return ExperienceIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Experience.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Experience.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _ExperienceImpl extends Experience {
  _ExperienceImpl({
    int? id,
    required String duration,
    required String company,
    required String position,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         duration: duration,
         company: company,
         position: position,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Experience]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Experience copyWith({
    Object? id = _Undefined,
    String? duration,
    String? company,
    String? position,
    Object? displayOrder = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return Experience(
      id: id is int? ? id : this.id,
      duration: duration ?? this.duration,
      company: company ?? this.company,
      position: position ?? this.position,
      displayOrder: displayOrder is int? ? displayOrder : this.displayOrder,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class ExperienceUpdateTable extends _i1.UpdateTable<ExperienceTable> {
  ExperienceUpdateTable(super.table);

  _i1.ColumnValue<String, String> duration(String value) => _i1.ColumnValue(
    table.duration,
    value,
  );

  _i1.ColumnValue<String, String> company(String value) => _i1.ColumnValue(
    table.company,
    value,
  );

  _i1.ColumnValue<String, String> position(String value) => _i1.ColumnValue(
    table.position,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int? value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );

  _i1.ColumnValue<DateTime, DateTime> createdAt(DateTime? value) =>
      _i1.ColumnValue(
        table.createdAt,
        value,
      );

  _i1.ColumnValue<DateTime, DateTime> updatedAt(DateTime? value) =>
      _i1.ColumnValue(
        table.updatedAt,
        value,
      );
}

class ExperienceTable extends _i1.Table<int?> {
  ExperienceTable({super.tableRelation}) : super(tableName: 'experiences') {
    updateTable = ExperienceUpdateTable(this);
    duration = _i1.ColumnString(
      'duration',
      this,
    );
    company = _i1.ColumnString(
      'company',
      this,
    );
    position = _i1.ColumnString(
      'position',
      this,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
    createdAt = _i1.ColumnDateTime(
      'createdAt',
      this,
      hasDefault: true,
    );
    updatedAt = _i1.ColumnDateTime(
      'updatedAt',
      this,
      hasDefault: true,
    );
  }

  late final ExperienceUpdateTable updateTable;

  late final _i1.ColumnString duration;

  late final _i1.ColumnString company;

  late final _i1.ColumnString position;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    duration,
    company,
    position,
    displayOrder,
    createdAt,
    updatedAt,
  ];
}

class ExperienceInclude extends _i1.IncludeObject {
  ExperienceInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Experience.t;
}

class ExperienceIncludeList extends _i1.IncludeList {
  ExperienceIncludeList._({
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Experience.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Experience.t;
}

class ExperienceRepository {
  const ExperienceRepository._();

  /// Returns a list of [Experience]s matching the given query parameters.
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
  Future<List<Experience>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Experience>(
      where: where?.call(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Experience] matching the given query parameters.
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
  Future<Experience?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Experience>(
      where: where?.call(Experience.t),
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Experience] by its [id] or null if no such row exists.
  Future<Experience?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Experience>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Experience]s in the list and returns the inserted rows.
  ///
  /// The returned [Experience]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Experience>> insert(
    _i1.DatabaseSession session,
    List<Experience> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Experience>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Experience] and returns the inserted row.
  ///
  /// The returned [Experience] will have its `id` field set.
  Future<Experience> insertRow(
    _i1.DatabaseSession session,
    Experience row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Experience>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Experience]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Experience>> update(
    _i1.DatabaseSession session,
    List<Experience> rows, {
    _i1.ColumnSelections<ExperienceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Experience>(
      rows,
      columns: columns?.call(Experience.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Experience]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Experience> updateRow(
    _i1.DatabaseSession session,
    Experience row, {
    _i1.ColumnSelections<ExperienceTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Experience>(
      row,
      columns: columns?.call(Experience.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Experience] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Experience?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<ExperienceUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Experience>(
      id,
      columnValues: columnValues(Experience.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Experience]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Experience>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<ExperienceUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<ExperienceTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<ExperienceTable>? orderBy,
    _i1.OrderByListBuilder<ExperienceTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Experience>(
      columnValues: columnValues(Experience.t.updateTable),
      where: where(Experience.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Experience.t),
      orderByList: orderByList?.call(Experience.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Experience]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Experience>> delete(
    _i1.DatabaseSession session,
    List<Experience> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Experience>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Experience].
  Future<Experience> deleteRow(
    _i1.DatabaseSession session,
    Experience row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Experience>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Experience>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExperienceTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Experience>(
      where: where(Experience.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<ExperienceTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Experience>(
      where: where?.call(Experience.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Experience] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<ExperienceTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Experience>(
      where: where(Experience.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
