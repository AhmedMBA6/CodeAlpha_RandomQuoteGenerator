// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$QuoteState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuoteState()';
}


}

/// @nodoc
class $QuoteStateCopyWith<$Res>  {
$QuoteStateCopyWith(QuoteState _, $Res Function(QuoteState) __);
}


/// Adds pattern-matching-related methods to [QuoteState].
extension QuoteStatePatterns on QuoteState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( QuoteLoading value)?  loading,TResult Function( QuoteSuccess value)?  success,TResult Function( QuoteError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case QuoteLoading() when loading != null:
return loading(_that);case QuoteSuccess() when success != null:
return success(_that);case QuoteError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( QuoteLoading value)  loading,required TResult Function( QuoteSuccess value)  success,required TResult Function( QuoteError value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case QuoteLoading():
return loading(_that);case QuoteSuccess():
return success(_that);case QuoteError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( QuoteLoading value)?  loading,TResult? Function( QuoteSuccess value)?  success,TResult? Function( QuoteError value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case QuoteLoading() when loading != null:
return loading(_that);case QuoteSuccess() when success != null:
return success(_that);case QuoteError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( bool isInitial)?  loading,TResult Function( QuoteModel quotes)?  success,TResult Function( ApiErrorModel apiErrorModel)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case QuoteLoading() when loading != null:
return loading(_that.isInitial);case QuoteSuccess() when success != null:
return success(_that.quotes);case QuoteError() when error != null:
return error(_that.apiErrorModel);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( bool isInitial)  loading,required TResult Function( QuoteModel quotes)  success,required TResult Function( ApiErrorModel apiErrorModel)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case QuoteLoading():
return loading(_that.isInitial);case QuoteSuccess():
return success(_that.quotes);case QuoteError():
return error(_that.apiErrorModel);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( bool isInitial)?  loading,TResult? Function( QuoteModel quotes)?  success,TResult? Function( ApiErrorModel apiErrorModel)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case QuoteLoading() when loading != null:
return loading(_that.isInitial);case QuoteSuccess() when success != null:
return success(_that.quotes);case QuoteError() when error != null:
return error(_that.apiErrorModel);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements QuoteState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'QuoteState.initial()';
}


}




/// @nodoc


class QuoteLoading implements QuoteState {
  const QuoteLoading({this.isInitial = false});
  

@JsonKey() final  bool isInitial;

/// Create a copy of QuoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteLoadingCopyWith<QuoteLoading> get copyWith => _$QuoteLoadingCopyWithImpl<QuoteLoading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteLoading&&(identical(other.isInitial, isInitial) || other.isInitial == isInitial));
}


@override
int get hashCode => Object.hash(runtimeType,isInitial);

@override
String toString() {
  return 'QuoteState.loading(isInitial: $isInitial)';
}


}

/// @nodoc
abstract mixin class $QuoteLoadingCopyWith<$Res> implements $QuoteStateCopyWith<$Res> {
  factory $QuoteLoadingCopyWith(QuoteLoading value, $Res Function(QuoteLoading) _then) = _$QuoteLoadingCopyWithImpl;
@useResult
$Res call({
 bool isInitial
});




}
/// @nodoc
class _$QuoteLoadingCopyWithImpl<$Res>
    implements $QuoteLoadingCopyWith<$Res> {
  _$QuoteLoadingCopyWithImpl(this._self, this._then);

  final QuoteLoading _self;
  final $Res Function(QuoteLoading) _then;

/// Create a copy of QuoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isInitial = null,}) {
  return _then(QuoteLoading(
isInitial: null == isInitial ? _self.isInitial : isInitial // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class QuoteSuccess implements QuoteState {
  const QuoteSuccess(this.quotes);
  

 final  QuoteModel quotes;

/// Create a copy of QuoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteSuccessCopyWith<QuoteSuccess> get copyWith => _$QuoteSuccessCopyWithImpl<QuoteSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteSuccess&&(identical(other.quotes, quotes) || other.quotes == quotes));
}


@override
int get hashCode => Object.hash(runtimeType,quotes);

@override
String toString() {
  return 'QuoteState.success(quotes: $quotes)';
}


}

/// @nodoc
abstract mixin class $QuoteSuccessCopyWith<$Res> implements $QuoteStateCopyWith<$Res> {
  factory $QuoteSuccessCopyWith(QuoteSuccess value, $Res Function(QuoteSuccess) _then) = _$QuoteSuccessCopyWithImpl;
@useResult
$Res call({
 QuoteModel quotes
});




}
/// @nodoc
class _$QuoteSuccessCopyWithImpl<$Res>
    implements $QuoteSuccessCopyWith<$Res> {
  _$QuoteSuccessCopyWithImpl(this._self, this._then);

  final QuoteSuccess _self;
  final $Res Function(QuoteSuccess) _then;

/// Create a copy of QuoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? quotes = null,}) {
  return _then(QuoteSuccess(
null == quotes ? _self.quotes : quotes // ignore: cast_nullable_to_non_nullable
as QuoteModel,
  ));
}


}

/// @nodoc


class QuoteError implements QuoteState {
  const QuoteError(this.apiErrorModel);
  

 final  ApiErrorModel apiErrorModel;

/// Create a copy of QuoteState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteErrorCopyWith<QuoteError> get copyWith => _$QuoteErrorCopyWithImpl<QuoteError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteError&&(identical(other.apiErrorModel, apiErrorModel) || other.apiErrorModel == apiErrorModel));
}


@override
int get hashCode => Object.hash(runtimeType,apiErrorModel);

@override
String toString() {
  return 'QuoteState.error(apiErrorModel: $apiErrorModel)';
}


}

/// @nodoc
abstract mixin class $QuoteErrorCopyWith<$Res> implements $QuoteStateCopyWith<$Res> {
  factory $QuoteErrorCopyWith(QuoteError value, $Res Function(QuoteError) _then) = _$QuoteErrorCopyWithImpl;
@useResult
$Res call({
 ApiErrorModel apiErrorModel
});




}
/// @nodoc
class _$QuoteErrorCopyWithImpl<$Res>
    implements $QuoteErrorCopyWith<$Res> {
  _$QuoteErrorCopyWithImpl(this._self, this._then);

  final QuoteError _self;
  final $Res Function(QuoteError) _then;

/// Create a copy of QuoteState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? apiErrorModel = null,}) {
  return _then(QuoteError(
null == apiErrorModel ? _self.apiErrorModel : apiErrorModel // ignore: cast_nullable_to_non_nullable
as ApiErrorModel,
  ));
}


}

// dart format on
