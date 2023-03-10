// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetSongCollection on Isar {
  IsarCollection<Song> get songs => this.collection();
}

const SongSchema = CollectionSchema(
  name: r'Song',
  id: -5548886644249537934,
  properties: {
    r'albumId': PropertySchema(
      id: 0,
      name: r'albumId',
      type: IsarType.long,
    ),
    r'book': PropertySchema(
      id: 1,
      name: r'book',
      type: IsarType.string,
    ),
    r'bookId': PropertySchema(
      id: 2,
      name: r'bookId',
      type: IsarType.long,
    ),
    r'duration': PropertySchema(
      id: 3,
      name: r'duration',
      type: IsarType.long,
    ),
    r'hasKaraoke': PropertySchema(
      id: 4,
      name: r'hasKaraoke',
      type: IsarType.bool,
    ),
    r'hasRecording': PropertySchema(
      id: 5,
      name: r'hasRecording',
      type: IsarType.bool,
    ),
    r'lyrics': PropertySchema(
      id: 6,
      name: r'lyrics',
      type: IsarType.string,
    ),
    r'lyricsWords': PropertySchema(
      id: 7,
      name: r'lyricsWords',
      type: IsarType.stringList,
    ),
    r'newRecording': PropertySchema(
      id: 8,
      name: r'newRecording',
      type: IsarType.dateTime,
    ),
    r'psalm': PropertySchema(
      id: 9,
      name: r'psalm',
      type: IsarType.string,
    ),
    r'songNumber': PropertySchema(
      id: 10,
      name: r'songNumber',
      type: IsarType.string,
    ),
    r'songNumberInt': PropertySchema(
      id: 11,
      name: r'songNumberInt',
      type: IsarType.long,
    ),
    r'textWChords': PropertySchema(
      id: 12,
      name: r'textWChords',
      type: IsarType.string,
    ),
    r'title': PropertySchema(
      id: 13,
      name: r'title',
      type: IsarType.string,
    ),
    r'titleWords': PropertySchema(
      id: 14,
      name: r'titleWords',
      type: IsarType.stringList,
    )
  },
  estimateSize: _songEstimateSize,
  serialize: _songSerialize,
  deserialize: _songDeserialize,
  deserializeProp: _songDeserializeProp,
  idName: r'id',
  indexes: {
    r'titleWords': IndexSchema(
      id: 80481505061976672,
      name: r'titleWords',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'titleWords',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'lyricsWords': IndexSchema(
      id: -5180971056356316999,
      name: r'lyricsWords',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lyricsWords',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _songGetId,
  getLinks: _songGetLinks,
  attach: _songAttach,
  version: '3.0.5',
);

int _songEstimateSize(
  Song object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.book.length * 3;
  bytesCount += 3 + object.lyrics.length * 3;
  bytesCount += 3 + object.lyricsWords.length * 3;
  {
    for (var i = 0; i < object.lyricsWords.length; i++) {
      final value = object.lyricsWords[i];
      bytesCount += value.length * 3;
    }
  }
  {
    final value = object.psalm;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.songNumber.length * 3;
  bytesCount += 3 + object.textWChords.length * 3;
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.titleWords.length * 3;
  {
    for (var i = 0; i < object.titleWords.length; i++) {
      final value = object.titleWords[i];
      bytesCount += value.length * 3;
    }
  }
  return bytesCount;
}

void _songSerialize(
  Song object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.albumId);
  writer.writeString(offsets[1], object.book);
  writer.writeLong(offsets[2], object.bookId);
  writer.writeLong(offsets[3], object.duration);
  writer.writeBool(offsets[4], object.hasKaraoke);
  writer.writeBool(offsets[5], object.hasRecording);
  writer.writeString(offsets[6], object.lyrics);
  writer.writeStringList(offsets[7], object.lyricsWords);
  writer.writeDateTime(offsets[8], object.newRecording);
  writer.writeString(offsets[9], object.psalm);
  writer.writeString(offsets[10], object.songNumber);
  writer.writeLong(offsets[11], object.songNumberInt);
  writer.writeString(offsets[12], object.textWChords);
  writer.writeString(offsets[13], object.title);
  writer.writeStringList(offsets[14], object.titleWords);
}

Song _songDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Song(
    albumId: reader.readLongOrNull(offsets[0]),
    book: reader.readStringOrNull(offsets[1]) ?? "Гуногун",
    duration: reader.readLongOrNull(offsets[3]),
    hasKaraoke: reader.readBoolOrNull(offsets[4]) ?? false,
    hasRecording: reader.readBoolOrNull(offsets[5]) ?? true,
    newRecording: reader.readDateTimeOrNull(offsets[8]),
    psalm: reader.readStringOrNull(offsets[9]),
    songNumberInt: reader.readLong(offsets[11]),
    textWChords: reader.readStringOrNull(offsets[12]) ?? "",
    title: reader.readString(offsets[13]),
  );
  return object;
}

P _songDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? "Гуногун") as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (reader.readStringList(offset) ?? []) as P;
    case 8:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 9:
      return (reader.readStringOrNull(offset)) as P;
    case 10:
      return (reader.readString(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? "") as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readStringList(offset) ?? []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _songGetId(Song object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _songGetLinks(Song object) {
  return [];
}

void _songAttach(IsarCollection<dynamic> col, Id id, Song object) {}

extension SongQueryWhereSort on QueryBuilder<Song, Song, QWhere> {
  QueryBuilder<Song, Song, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Song, Song, QAfterWhere> anyTitleWordsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'titleWords'),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhere> anyLyricsWordsElement() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lyricsWords'),
      );
    });
  }
}

extension SongQueryWhere on QueryBuilder<Song, Song, QWhereClause> {
  QueryBuilder<Song, Song, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementEqualTo(
      String titleWordsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titleWords',
        value: [titleWordsElement],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementNotEqualTo(
      String titleWordsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleWords',
              lower: [],
              upper: [titleWordsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleWords',
              lower: [titleWordsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleWords',
              lower: [titleWordsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'titleWords',
              lower: [],
              upper: [titleWordsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementGreaterThan(
    String titleWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleWords',
        lower: [titleWordsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementLessThan(
    String titleWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleWords',
        lower: [],
        upper: [titleWordsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementBetween(
    String lowerTitleWordsElement,
    String upperTitleWordsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleWords',
        lower: [lowerTitleWordsElement],
        includeLower: includeLower,
        upper: [upperTitleWordsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementStartsWith(
      String TitleWordsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'titleWords',
        lower: [TitleWordsElementPrefix],
        upper: ['$TitleWordsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'titleWords',
        value: [''],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> titleWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'titleWords',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'titleWords',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'titleWords',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'titleWords',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementEqualTo(
      String lyricsWordsElement) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lyricsWords',
        value: [lyricsWordsElement],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementNotEqualTo(
      String lyricsWordsElement) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lyricsWords',
              lower: [],
              upper: [lyricsWordsElement],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lyricsWords',
              lower: [lyricsWordsElement],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lyricsWords',
              lower: [lyricsWordsElement],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lyricsWords',
              lower: [],
              upper: [lyricsWordsElement],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementGreaterThan(
    String lyricsWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lyricsWords',
        lower: [lyricsWordsElement],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementLessThan(
    String lyricsWordsElement, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lyricsWords',
        lower: [],
        upper: [lyricsWordsElement],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementBetween(
    String lowerLyricsWordsElement,
    String upperLyricsWordsElement, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lyricsWords',
        lower: [lowerLyricsWordsElement],
        includeLower: includeLower,
        upper: [upperLyricsWordsElement],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementStartsWith(
      String LyricsWordsElementPrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lyricsWords',
        lower: [LyricsWordsElementPrefix],
        upper: ['$LyricsWordsElementPrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lyricsWords',
        value: [''],
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterWhereClause> lyricsWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'lyricsWords',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'lyricsWords',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'lyricsWords',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'lyricsWords',
              upper: [''],
            ));
      }
    });
  }
}

extension SongQueryFilter on QueryBuilder<Song, Song, QFilterCondition> {
  QueryBuilder<Song, Song, QAfterFilterCondition> albumIdIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> albumIdIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'albumId',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> albumIdEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'albumId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> albumIdGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'albumId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> albumIdLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'albumId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> albumIdBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'albumId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'book',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'book',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'book',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'book',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'book',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookId',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> bookIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'duration',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationEqualTo(int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'duration',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> durationBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'duration',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> hasKaraokeEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasKaraoke',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> hasRecordingEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasRecording',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lyrics',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lyrics',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lyrics',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lyrics',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lyricsWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lyricsWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lyricsWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lyricsWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lyricsWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lyricsWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lyricsWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lyricsWords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lyricsWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      lyricsWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lyricsWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lyricsWords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lyricsWords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lyricsWords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lyricsWords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lyricsWords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> lyricsWordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'lyricsWords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> newRecordingIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'newRecording',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> newRecordingIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'newRecording',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> newRecordingEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'newRecording',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> newRecordingGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'newRecording',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> newRecordingLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'newRecording',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> newRecordingBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'newRecording',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'psalm',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'psalm',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'psalm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'psalm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'psalm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'psalm',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'psalm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'psalm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'psalm',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'psalm',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'psalm',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> psalmIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'psalm',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songNumber',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'songNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'songNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'songNumber',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'songNumber',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'songNumber',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberIntEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'songNumberInt',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberIntGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'songNumberInt',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberIntLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'songNumberInt',
        value: value,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> songNumberIntBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'songNumberInt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textWChords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'textWChords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'textWChords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'textWChords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'textWChords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'textWChords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'textWChords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'textWChords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'textWChords',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> textWChordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'textWChords',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleMatches(String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'titleWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'titleWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'titleWords',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'titleWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'titleWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'titleWords',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'titleWords',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'titleWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition>
      titleWordsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'titleWords',
        value: '',
      ));
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'titleWords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'titleWords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'titleWords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'titleWords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'titleWords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Song, Song, QAfterFilterCondition> titleWordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'titleWords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension SongQueryObject on QueryBuilder<Song, Song, QFilterCondition> {}

extension SongQueryLinks on QueryBuilder<Song, Song, QFilterCondition> {}

extension SongQuerySortBy on QueryBuilder<Song, Song, QSortBy> {
  QueryBuilder<Song, Song, QAfterSortBy> sortByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByBookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByHasKaraoke() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKaraoke', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByHasKaraokeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKaraoke', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByHasRecording() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRecording', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByHasRecordingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRecording', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByNewRecording() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newRecording', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByNewRecordingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newRecording', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByPsalm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psalm', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByPsalmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psalm', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortBySongNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumber', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortBySongNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumber', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortBySongNumberInt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumberInt', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortBySongNumberIntDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumberInt', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByTextWChords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textWChords', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByTextWChordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textWChords', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension SongQuerySortThenBy on QueryBuilder<Song, Song, QSortThenBy> {
  QueryBuilder<Song, Song, QAfterSortBy> thenByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByAlbumIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'albumId', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByBook() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByBookDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'book', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByBookIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookId', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByDurationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'duration', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByHasKaraoke() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKaraoke', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByHasKaraokeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasKaraoke', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByHasRecording() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRecording', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByHasRecordingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasRecording', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByLyrics() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByLyricsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lyrics', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByNewRecording() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newRecording', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByNewRecordingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'newRecording', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByPsalm() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psalm', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByPsalmDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'psalm', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenBySongNumber() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumber', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenBySongNumberDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumber', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenBySongNumberInt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumberInt', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenBySongNumberIntDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'songNumberInt', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByTextWChords() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textWChords', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByTextWChordsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'textWChords', Sort.desc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<Song, Song, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }
}

extension SongQueryWhereDistinct on QueryBuilder<Song, Song, QDistinct> {
  QueryBuilder<Song, Song, QDistinct> distinctByAlbumId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'albumId');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByBook(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'book', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByBookId() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookId');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByDuration() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'duration');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByHasKaraoke() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasKaraoke');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByHasRecording() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasRecording');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByLyrics(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lyrics', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByLyricsWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lyricsWords');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByNewRecording() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'newRecording');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByPsalm(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'psalm', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctBySongNumber(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songNumber', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctBySongNumberInt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'songNumberInt');
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByTextWChords(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'textWChords', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Song, Song, QDistinct> distinctByTitleWords() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'titleWords');
    });
  }
}

extension SongQueryProperty on QueryBuilder<Song, Song, QQueryProperty> {
  QueryBuilder<Song, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Song, int?, QQueryOperations> albumIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'albumId');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> bookProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'book');
    });
  }

  QueryBuilder<Song, int, QQueryOperations> bookIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookId');
    });
  }

  QueryBuilder<Song, int?, QQueryOperations> durationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'duration');
    });
  }

  QueryBuilder<Song, bool, QQueryOperations> hasKaraokeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasKaraoke');
    });
  }

  QueryBuilder<Song, bool, QQueryOperations> hasRecordingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasRecording');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> lyricsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lyrics');
    });
  }

  QueryBuilder<Song, List<String>, QQueryOperations> lyricsWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lyricsWords');
    });
  }

  QueryBuilder<Song, DateTime?, QQueryOperations> newRecordingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'newRecording');
    });
  }

  QueryBuilder<Song, String?, QQueryOperations> psalmProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'psalm');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> songNumberProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songNumber');
    });
  }

  QueryBuilder<Song, int, QQueryOperations> songNumberIntProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'songNumberInt');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> textWChordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'textWChords');
    });
  }

  QueryBuilder<Song, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<Song, List<String>, QQueryOperations> titleWordsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'titleWords');
    });
  }
}
