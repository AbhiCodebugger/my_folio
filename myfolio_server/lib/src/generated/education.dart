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

abstract class Education
    implements _i1.TableRow<int?>, _i1.ProtocolSerialization {
  Education._({
    this.id,
    required this.duration,
    required this.institution,
    required this.degree,
    required this.fieldOfStudy,
    this.grade,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : displayOrder = displayOrder ?? 0,
       createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  factory Education({
    int? id,
    required String duration,
    required String institution,
    required String degree,
    required String fieldOfStudy,
    String? grade,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _EducationImpl;

  factory Education.fromJson(Map<String, dynamic> jsonSerialization) {
    return Education(
      id: jsonSerialization['id'] as int?,
      duration: jsonSerialization['duration'] as String,
      institution: jsonSerialization['institution'] as String,
      degree: jsonSerialization['degree'] as String,
      fieldOfStudy: jsonSerialization['fieldOfStudy'] as String,
      grade: jsonSerialization['grade'] as String?,
      displayOrder: jsonSerialization['displayOrder'] as int?,
      createdAt: jsonSerialization['createdAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['createdAt']),
      updatedAt: jsonSerialization['updatedAt'] == null
          ? null
          : _i1.DateTimeJsonExtension.fromJson(jsonSerialization['updatedAt']),
    );
  }

  static final t = EducationTable();

  static const db = EducationRepository._();

  @override
  int? id;

  String duration;

  String institution;

  String degree;

  String fieldOfStudy;

  String? grade;

  int? displayOrder;

  DateTime? createdAt;

  DateTime? updatedAt;

  @override
  _i1.Table<int?> get table => t;

  /// Returns a shallow copy of this [Education]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  Education copyWith({
    int? id,
    String? duration,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    String? grade,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
  @override
  Map<String, dynamic> toJson() {
    return {
      '__className__': 'Education',
      if (id != null) 'id': id,
      'duration': duration,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      if (grade != null) 'grade': grade,
      if (displayOrder != null) 'displayOrder': displayOrder,
      if (createdAt != null) 'createdAt': createdAt?.toJson(),
      if (updatedAt != null) 'updatedAt': updatedAt?.toJson(),
    };
  }

  @override
  Map<String, dynamic> toJsonForProtocol() {
    return {
      '__className__': 'Education',
      if (id != null) 'id': id,
      'duration': duration,
      'institution': institution,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      if (grade != null) 'grade': grade,
      if (displayOrder != null) 'displayOrder': displayOrder,
    };
  }

  static EducationInclude include() {
    return EducationInclude._();
  }

  static EducationIncludeList includeList({
    _i1.WhereExpressionBuilder<EducationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EducationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EducationTable>? orderByList,
    EducationInclude? include,
  }) {
    return EducationIncludeList._(
      where: where,
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Education.t),
      orderDescending: orderDescending,
      orderByList: orderByList?.call(Education.t),
      include: include,
    );
  }

  @override
  String toString() {
    return _i1.SerializationManager.encode(this);
  }
}

class _Undefined {}

class _EducationImpl extends Education {
  _EducationImpl({
    int? id,
    required String duration,
    required String institution,
    required String degree,
    required String fieldOfStudy,
    String? grade,
    int? displayOrder,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : super._(
         id: id,
         duration: duration,
         institution: institution,
         degree: degree,
         fieldOfStudy: fieldOfStudy,
         grade: grade,
         displayOrder: displayOrder,
         createdAt: createdAt,
         updatedAt: updatedAt,
       );

  /// Returns a shallow copy of this [Education]
  /// with some or all fields replaced by the given arguments.
  @_i1.useResult
  @override
  Education copyWith({
    Object? id = _Undefined,
    String? duration,
    String? institution,
    String? degree,
    String? fieldOfStudy,
    Object? grade = _Undefined,
    Object? displayOrder = _Undefined,
    Object? createdAt = _Undefined,
    Object? updatedAt = _Undefined,
  }) {
    return Education(
      id: id is int? ? id : this.id,
      duration: duration ?? this.duration,
      institution: institution ?? this.institution,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      grade: grade is String? ? grade : this.grade,
      displayOrder: displayOrder is int? ? displayOrder : this.displayOrder,
      createdAt: createdAt is DateTime? ? createdAt : this.createdAt,
      updatedAt: updatedAt is DateTime? ? updatedAt : this.updatedAt,
    );
  }
}

class EducationUpdateTable extends _i1.UpdateTable<EducationTable> {
  EducationUpdateTable(super.table);

  _i1.ColumnValue<String, String> duration(String value) => _i1.ColumnValue(
    table.duration,
    value,
  );

  _i1.ColumnValue<String, String> institution(String value) => _i1.ColumnValue(
    table.institution,
    value,
  );

  _i1.ColumnValue<String, String> degree(String value) => _i1.ColumnValue(
    table.degree,
    value,
  );

  _i1.ColumnValue<String, String> fieldOfStudy(String value) => _i1.ColumnValue(
    table.fieldOfStudy,
    value,
  );

  _i1.ColumnValue<String, String> grade(String? value) => _i1.ColumnValue(
    table.grade,
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

class EducationTable extends _i1.Table<int?> {
  EducationTable({super.tableRelation}) : super(tableName: 'educations') {
    updateTable = EducationUpdateTable(this);
    duration = _i1.ColumnString(
      'duration',
      this,
    );
    institution = _i1.ColumnString(
      'institution',
      this,
    );
    degree = _i1.ColumnString(
      'degree',
      this,
    );
    fieldOfStudy = _i1.ColumnString(
      'fieldOfStudy',
      this,
    );
    grade = _i1.ColumnString(
      'grade',
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

  late final EducationUpdateTable updateTable;

  late final _i1.ColumnString duration;

  late final _i1.ColumnString institution;

  late final _i1.ColumnString degree;

  late final _i1.ColumnString fieldOfStudy;

  late final _i1.ColumnString grade;

  late final _i1.ColumnInt displayOrder;

  late final _i1.ColumnDateTime createdAt;

  late final _i1.ColumnDateTime updatedAt;

  @override
  List<_i1.Column> get columns => [
    id,
    duration,
    institution,
    degree,
    fieldOfStudy,
    grade,
    displayOrder,
    createdAt,
    updatedAt,
  ];
}

class EducationInclude extends _i1.IncludeObject {
  EducationInclude._();

  @override
  Map<String, _i1.Include?> get includes => {};

  @override
  _i1.Table<int?> get table => Education.t;
}

class EducationIncludeList extends _i1.IncludeList {
  EducationIncludeList._({
    _i1.WhereExpressionBuilder<EducationTable>? where,
    super.limit,
    super.offset,
    super.orderBy,
    super.orderDescending,
    super.orderByList,
    super.include,
  }) {
    super.where = where?.call(Education.t);
  }

  @override
  Map<String, _i1.Include?> get includes => include?.includes ?? {};

  @override
  _i1.Table<int?> get table => Education.t;
}

class EducationRepository {
  const EducationRepository._();

  /// Returns a list of [Education]s matching the given query parameters.
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
  Future<List<Education>> find(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EducationTable>? where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EducationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EducationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.find<Education>(
      where: where?.call(Education.t),
      orderBy: orderBy?.call(Education.t),
      orderByList: orderByList?.call(Education.t),
      orderDescending: orderDescending,
      limit: limit,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Returns the first matching [Education] matching the given query parameters.
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
  Future<Education?> findFirstRow(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EducationTable>? where,
    int? offset,
    _i1.OrderByBuilder<EducationTable>? orderBy,
    bool orderDescending = false,
    _i1.OrderByListBuilder<EducationTable>? orderByList,
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findFirstRow<Education>(
      where: where?.call(Education.t),
      orderBy: orderBy?.call(Education.t),
      orderByList: orderByList?.call(Education.t),
      orderDescending: orderDescending,
      offset: offset,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Finds a single [Education] by its [id] or null if no such row exists.
  Future<Education?> findById(
    _i1.DatabaseSession session,
    int id, {
    _i1.Transaction? transaction,
    _i1.LockMode? lockMode,
    _i1.LockBehavior? lockBehavior,
  }) async {
    return session.db.findById<Education>(
      id,
      transaction: transaction,
      lockMode: lockMode,
      lockBehavior: lockBehavior,
    );
  }

  /// Inserts all [Education]s in the list and returns the inserted rows.
  ///
  /// The returned [Education]s will have their `id` fields set.
  ///
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// insert, none of the rows will be inserted.
  ///
  /// If [ignoreConflicts] is set to `true`, rows that conflict with existing
  /// rows are silently skipped, and only the successfully inserted rows are
  /// returned.
  Future<List<Education>> insert(
    _i1.DatabaseSession session,
    List<Education> rows, {
    _i1.Transaction? transaction,
    bool ignoreConflicts = false,
  }) async {
    return session.db.insert<Education>(
      rows,
      transaction: transaction,
      ignoreConflicts: ignoreConflicts,
    );
  }

  /// Inserts a single [Education] and returns the inserted row.
  ///
  /// The returned [Education] will have its `id` field set.
  Future<Education> insertRow(
    _i1.DatabaseSession session,
    Education row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.insertRow<Education>(
      row,
      transaction: transaction,
    );
  }

  /// Updates all [Education]s in the list and returns the updated rows. If
  /// [columns] is provided, only those columns will be updated. Defaults to
  /// all columns.
  /// This is an atomic operation, meaning that if one of the rows fails to
  /// update, none of the rows will be updated.
  Future<List<Education>> update(
    _i1.DatabaseSession session,
    List<Education> rows, {
    _i1.ColumnSelections<EducationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.update<Education>(
      rows,
      columns: columns?.call(Education.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Education]. The row needs to have its id set.
  /// Optionally, a list of [columns] can be provided to only update those
  /// columns. Defaults to all columns.
  Future<Education> updateRow(
    _i1.DatabaseSession session,
    Education row, {
    _i1.ColumnSelections<EducationTable>? columns,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateRow<Education>(
      row,
      columns: columns?.call(Education.t),
      transaction: transaction,
    );
  }

  /// Updates a single [Education] by its [id] with the specified [columnValues].
  /// Returns the updated row or null if no row with the given id exists.
  Future<Education?> updateById(
    _i1.DatabaseSession session,
    int id, {
    required _i1.ColumnValueListBuilder<EducationUpdateTable> columnValues,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateById<Education>(
      id,
      columnValues: columnValues(Education.t.updateTable),
      transaction: transaction,
    );
  }

  /// Updates all [Education]s matching the [where] expression with the specified [columnValues].
  /// Returns the list of updated rows.
  Future<List<Education>> updateWhere(
    _i1.DatabaseSession session, {
    required _i1.ColumnValueListBuilder<EducationUpdateTable> columnValues,
    required _i1.WhereExpressionBuilder<EducationTable> where,
    int? limit,
    int? offset,
    _i1.OrderByBuilder<EducationTable>? orderBy,
    _i1.OrderByListBuilder<EducationTable>? orderByList,
    bool orderDescending = false,
    _i1.Transaction? transaction,
  }) async {
    return session.db.updateWhere<Education>(
      columnValues: columnValues(Education.t.updateTable),
      where: where(Education.t),
      limit: limit,
      offset: offset,
      orderBy: orderBy?.call(Education.t),
      orderByList: orderByList?.call(Education.t),
      orderDescending: orderDescending,
      transaction: transaction,
    );
  }

  /// Deletes all [Education]s in the list and returns the deleted rows.
  /// This is an atomic operation, meaning that if one of the rows fail to
  /// be deleted, none of the rows will be deleted.
  Future<List<Education>> delete(
    _i1.DatabaseSession session,
    List<Education> rows, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.delete<Education>(
      rows,
      transaction: transaction,
    );
  }

  /// Deletes a single [Education].
  Future<Education> deleteRow(
    _i1.DatabaseSession session,
    Education row, {
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteRow<Education>(
      row,
      transaction: transaction,
    );
  }

  /// Deletes all rows matching the [where] expression.
  Future<List<Education>> deleteWhere(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EducationTable> where,
    _i1.Transaction? transaction,
  }) async {
    return session.db.deleteWhere<Education>(
      where: where(Education.t),
      transaction: transaction,
    );
  }

  /// Counts the number of rows matching the [where] expression. If omitted,
  /// will return the count of all rows in the table.
  Future<int> count(
    _i1.DatabaseSession session, {
    _i1.WhereExpressionBuilder<EducationTable>? where,
    int? limit,
    _i1.Transaction? transaction,
  }) async {
    return session.db.count<Education>(
      where: where?.call(Education.t),
      limit: limit,
      transaction: transaction,
    );
  }

  /// Acquires row-level locks on [Education] rows matching the [where] expression.
  Future<void> lockRows(
    _i1.DatabaseSession session, {
    required _i1.WhereExpressionBuilder<EducationTable> where,
    required _i1.LockMode lockMode,
    required _i1.Transaction transaction,
    _i1.LockBehavior lockBehavior = _i1.LockBehavior.wait,
  }) async {
    return session.db.lockRows<Education>(
      where: where(Education.t),
      lockMode: lockMode,
      lockBehavior: lockBehavior,
      transaction: transaction,
    );
  }
}
