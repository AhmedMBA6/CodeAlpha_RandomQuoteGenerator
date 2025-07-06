// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favorites_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FavoritesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesState()';
}


}

/// @nodoc
class $FavoritesStateCopyWith<$Res>  {
$FavoritesStateCopyWith(FavoritesState _, $Res Function(FavoritesState) __);
}


/// Adds pattern-matching-related methods to [FavoritesState].
extension FavoritesStatePatterns on FavoritesState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( FavoritesLoading value)?  loading,TResult Function( FavoritesSuccess value)?  success,TResult Function( FavoritesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case FavoritesLoading() when loading != null:
return loading(_that);case FavoritesSuccess() when success != null:
return success(_that);case FavoritesError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( FavoritesLoading value)  loading,required TResult Function( FavoritesSuccess value)  success,required TResult Function( FavoritesError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case FavoritesLoading():
return loading(_that);case FavoritesSuccess():
return success(_that);case FavoritesError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( FavoritesLoading value)?  loading,TResult? Function( FavoritesSuccess value)?  success,TResult? Function( FavoritesError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case FavoritesLoading() when loading != null:
return loading(_that);case FavoritesSuccess() when success != null:
return success(_that);case FavoritesError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<QuoteModel> favorites)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case FavoritesLoading() when loading != null:
return loading();case FavoritesSuccess() when success != null:
return success(_that.favorites);case FavoritesError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<QuoteModel> favorites)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case FavoritesLoading():
return loading();case FavoritesSuccess():
return success(_that.favorites);case FavoritesError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<QuoteModel> favorites)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case FavoritesLoading() when loading != null:
return loading();case FavoritesSuccess() when success != null:
return success(_that.favorites);case FavoritesError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FavoritesState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesState.initial()';
}


}




/// @nodoc


class FavoritesLoading implements FavoritesState {
  const FavoritesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FavoritesState.loading()';
}


}




/// @nodoc


class FavoritesSuccess implements FavoritesState {
  const FavoritesSuccess(final  List<QuoteModel> favorites): _favorites = favorites;
  

 final  List<QuoteModel> _favorites;
 List<QuoteModel> get favorites {
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favorites);
}


/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesSuccessCopyWith<FavoritesSuccess> get copyWith => _$FavoritesSuccessCopyWithImpl<FavoritesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesSuccess&&const DeepCollectionEquality().equals(other._favorites, _favorites));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_favorites));

@override
String toString() {
  return 'FavoritesState.success(favorites: $favorites)';
}


}

/// @nodoc
abstract mixin class $FavoritesSuccessCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory $FavoritesSuccessCopyWith(FavoritesSuccess value, $Res Function(FavoritesSuccess) _then) = _$FavoritesSuccessCopyWithImpl;
@useResult
$Res call({
 List<QuoteModel> favorites
});




}
/// @nodoc
class _$FavoritesSuccessCopyWithImpl<$Res>
    implements $FavoritesSuccessCopyWith<$Res> {
  _$FavoritesSuccessCopyWithImpl(this._self, this._then);

  final FavoritesSuccess _self;
  final $Res Function(FavoritesSuccess) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? favorites = null,}) {
  return _then(FavoritesSuccess(
null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<QuoteModel>,
  ));
}


}

/// @nodoc


class FavoritesError implements FavoritesState {
  const FavoritesError(this.message);
  

 final  String message;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FavoritesErrorCopyWith<FavoritesError> get copyWith => _$FavoritesErrorCopyWithImpl<FavoritesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FavoritesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FavoritesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FavoritesErrorCopyWith<$Res> implements $FavoritesStateCopyWith<$Res> {
  factory $FavoritesErrorCopyWith(FavoritesError value, $Res Function(FavoritesError) _then) = _$FavoritesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FavoritesErrorCopyWithImpl<$Res>
    implements $FavoritesErrorCopyWith<$Res> {
  _$FavoritesErrorCopyWithImpl(this._self, this._then);

  final FavoritesError _self;
  final $Res Function(FavoritesError) _then;

/// Create a copy of FavoritesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FavoritesError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
