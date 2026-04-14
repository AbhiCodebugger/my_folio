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

abstract class Skill implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Skill._({
    this.id,
    required this.name,
    int? displayOrder,
  }) : displayOrder = displayOrder ?? 0;

  factory Skill({
    int? id,
    required String name,
    int? displayOrder,
  }) = _SkillImpl;

  factory Skill.fromJson(Map<String, dynamic> jsonSerialization) {
    return Skill(
      id: jsonSerialization['id'] as int?,
      name: jsonSerialization['name'] as String,
      displayOrder: jsonSerialization['displayOrder'] as int?,
    );
  }

  static final t = SkillTable();

  static const db = SkillRepository._();

  @override
  int? id;

  String name;

  int? displayOrder;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Skill copyWith({
    int? id,
    String? name,
    int? displayOrder,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Skill',
      if (id != null) 'id': id,
      'name': name,
      if (displayOrder != null) 'displayOrder': displayOrder,
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Skill',
      if (id != null) 'id': id,
      'name': name,
    };
  }

  static SkillInclude include() {
    return SkillInclude._();
  }

  static SkillIncludeList includeList({
    _i1.WhereExpressionBuilder<SkillTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SkillTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SkillTable>? orderByList,
    SkillInclude? include,
  }) {
    return SkillIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Skill.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Skill.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _SkillImpl extends Skill {
  _SkillImpl({
    int? id,
    required String name,
    int? displayOrder,
  }) : super._(
         id: id,
         name: name,
         displayOrder: displayOrder,
       );

  /// Returns a shallow copy of this [Skill]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Skill copyWith({
    Object? id = _Undefined,
    String? name,
    Object? displayOrder = _Undefined,
  }) {
    return Skill(
      id: id is int? ? id : this.id,
      name: name ?? this.name,
      displayOrder: displayOrder is int? ? displayOrder : this.displayOrder,
    );
  }
}

class SkillUpdateTable extends _i1.UpdateTable<SkillTable> {
  SkillUpdateTable(super.table);

  _i1.ColumnValue<String, String> name(String value) => _i1.ColumnValue(
    table.name,
    value,
  );

  _i1.ColumnValue<int, int> displayOrder(int? value) => _i1.ColumnValue(
    table.displayOrder,
    value,
  );
}

class SkillTable extends _i1.Table<int?> {
  SkillTable({super.tableRelation}) : super(tableName: 'skills') {
    updateTable = SkillUpdateTable(this);
    name = _i1.ColumnString(
      'name',
      this,
    );
    displayOrder = _i1.ColumnInt(
      'displayOrder',
      this,
      hasDefault: true,
    );
  }

  late final SkillUpdateTable updateTable;

  late final _i1.ColumnString name;

  late final _i1.ColumnInt displayOrder;

  @override
  List<_i1.Column> get columns => [
    id,
    name,
    displayOrder,
  ];
}

class SkillInclude extends _i1.IncludeObject {
  SkillInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Skill.t;
}

class SkillIncludeList extends _i1.IncludeList {
  SkillIncludeList._({
    _i1.WhereExpressionBuilder<SkillTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Skill.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Skill.t;
}

class SkillRepository {
  const SkillRepository._();

  /// Returns a list of [Skill]s matching the given query parameters.
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
  Future<List<Skill>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SkillTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SkillTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SkillTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Skill>(
      where: where?.call(Skill.t),
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Skill] matching the given query parameters.
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
  Future<Skill?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SkillTable>? where,
    int? offset,
    _i1.OrderByBuilder<SkillTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<SkillTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Skill>(
      where: where?.call(Skill.t),
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Skill] by its [id] or null if no such row exists.
  Future<Skill?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Skill>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Skill]s in the list and returns the inserted rows.
  ///
  /// The returned [Skill]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Skill>> insert(
    _i1.DatabaseSession session,
    List<Skill> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Skill>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Skill] and returns the inserted row.
  ///
  /// The returned [Skill] will have its `id` field set.
  Future<Skill> insertRow(
    _i1.DatabaseSession session,
    Skill row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Skill>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Skill]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Skill>> update(
    _i1.DatabaseSession session,
    List<Skill> rows, {
    _i1.ColumnSelections<SkillTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Skill>(
      rows,
      columns: columns?.call(Skill.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Skill]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Skill> updateRow(
    _i1.DatabaseSession session,
    Skill row, {
    _i1.ColumnSelections<SkillTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Skill>(
      row,
      columns: columns?.call(Skill.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Skill] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Skill?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<SkillUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Skill>(
      id,
      columnValues: columnValues(Skill.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Skill]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Skill>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<SkillUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<SkillTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<SkillTable>? orderBy,
    _i1.OrderByListBuilder<SkillTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Skill>(
      columnValues: columnValues(Skill.t.updateTable),
      where: where(Skill.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Skill.t),
      orderByList: orderByList?.call(Skill.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Skill]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Skill>> delete(
    _i1.DatabaseSession session,
    List<Skill> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Skill>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Skill].
  Future<Skill> deleteRow(
    _i1.DatabaseSession session,
    Skill row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Skill>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Skill>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SkillTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Skill>(
      where: where(Skill.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<SkillTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Skill>(
      where: where?.call(Skill.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Skill] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<SkillTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Skill>(
      where: where(Skill.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
