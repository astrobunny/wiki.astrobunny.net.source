# mruby page

Some notes on the mruby C API

---

## Common things

`MRB_API` - This declares functions that are meant to be accessed externally. They seem unlikely to change. They are also exported when built dynamically. Other functions in the headers but not `MRB_API` seem to be subject to change at any time.

`mrb_sym` - This datatype basically means Ruby symbol `:something`. You can easily get this by using the `mrb_inter_lit(mrb, "symbol")`. This is the equivalent of `#to_sym`

`mrb_value` - This is Ruby's boxed type. This type is used nearly everywhere where different types can be accepted. See below for more information about how to box and unbox data.

---

## mruby Data types and C Data types

#### `RBasic`

Possibly BasicObject. Not sure. Every other R* type can cast to this, since it only consists of the `MRB_OBJECT_HEADER`

#### `RObject`

The mruby object. The difference between this and `RBasic` is this one can have instance variables.

#### `RArray`

Represents an array. You cannot actually cast this to `RObject`! Its got no space for instance variables.

#### `RClass`

Represents a class.

#### `RCptr`

Not sure. C Pointer?? Declared in `boxing_word.h`.

#### `RData`

Extended version of the `RObject` that can contain custom data.

#### `REnv`

Not sure what this is. Declared in `proc.h`

#### `RException`

Exception object. Its exactly the same as an `RObject`.

#### `RProc`

A Ruby proc. Procs in Ruby only represent a list of instructions. You can literally insert these anywhere and they can freely change control flow within the scope because they have no scope themselves. You cannot cast this to `RObject`. It is made of `mrb_irep`, a somewhat mysterious object to me right now.

#### `RBreak`

Breakpoint?  Not sure

#### `RFiber`

Don't know what a fiber is. Declared in `object.h`

#### `RFloat`

Not sure why this is a thing. Declared in `boxing_word.h`.

#### `RHash`

A Ruby hash. This is an `RObject` plus a hashtable.

#### `RRange`

#### `RString`

---

## Functions (Variables)

#### `MRB_API mrb_value mrb_gv_get(mrb_state *mrb, mrb_sym sym);`

Gets a global variable. 

- `mrb` is the state.
- `sym` is the symbol of the global variable. You can actually pass syms that do not start with `$`. However you cannot access them in ruby, because `$` tells the interpreter its a global variable. Could be good for hiding things but could also be subject to change.

#### `MRB_API void mrb_gv_set(mrb_state *mrb, mrb_sym sym, mrb_value val);`

Sets a global variable

- `mrb` is the state.
- `sym` same as `mrb_gv_get`.
- `val` the value to set the variable to.

#### `MRB_API void mrb_gv_remove(mrb_state *mrb, mrb_sym sym);`

Removes a global variable. Actually not sure what happens when theres no global.

---

#### `MRB_API mrb_value mrb_const_get(mrb_state*, mrb_value, mrb_sym);`
#### `MRB_API void mrb_const_set(mrb_state*, mrb_value, mrb_sym, mrb_value);`

#### `MRB_API mrb_bool mrb_const_defined(mrb_state*, mrb_value, mrb_sym);`
#### `MRB_API mrb_bool mrb_const_defined_at(mrb_state *mrb, mrb_value mod, mrb_sym id);`

#### `MRB_API void mrb_const_remove(mrb_state*, mrb_value, mrb_sym);`

---

#### `MRB_API mrb_value mrb_iv_get(mrb_state *mrb, mrb_value obj, mrb_sym sym);`
#### `MRB_API void mrb_iv_set(mrb_state *mrb, mrb_value obj, mrb_sym sym, mrb_value v);`

#### `MRB_API mrb_value mrb_obj_iv_get(mrb_state *mrb, struct RObject *obj, mrb_sym sym);`
#### `MRB_API void mrb_obj_iv_set(mrb_state *mrb, struct RObject *obj, mrb_sym sym, mrb_value v);`

#### `MRB_API mrb_bool mrb_iv_name_sym_p(mrb_state *mrb, mrb_sym sym);`
#### `MRB_API void mrb_iv_name_sym_check(mrb_state *mrb, mrb_sym sym);`

#### `MRB_API mrb_bool mrb_obj_iv_defined(mrb_state *mrb, struct RObject *obj, mrb_sym sym);`
#### `MRB_API mrb_bool mrb_iv_defined(mrb_state*, mrb_value, mrb_sym);`

#### `MRB_API mrb_value mrb_iv_remove(mrb_state *mrb, mrb_value obj, mrb_sym sym);`
#### `MRB_API void mrb_iv_copy(mrb_state *mrb, mrb_value dst, mrb_value src);`

---

#### `MRB_API mrb_value mrb_cv_get(mrb_state *mrb, mrb_value mod, mrb_sym sym);`
#### `MRB_API void mrb_cv_set(mrb_state *mrb, mrb_value mod, mrb_sym sym, mrb_value v);`

#### `MRB_API void mrb_mod_cv_set(mrb_state *mrb, struct RClass * c, mrb_sym sym, mrb_value v);`

#### `MRB_API mrb_bool mrb_cv_defined(mrb_state *mrb, mrb_value mod, mrb_sym sym);`
---

## Functions (Boxing)

### Simple Types

#### `MRB_INLINE mrb_value mrb_nil_value(void)`

#### `MRB_INLINE mrb_value mrb_false_value(void)`
#### `MRB_INLINE mrb_value mrb_true_value(void)`

#### `MRB_INLINE mrb_value mrb_bool_value(mrb_bool boolean)`

#### `MRB_INLINE mrb_value mrb_undef_value(void)`