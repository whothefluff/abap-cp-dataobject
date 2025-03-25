# abap-cp-dataobject
It's pretty basic code but I do it often so I might as well be able to reuse it.

## Common Use Cases

1. Creating a new anonymous data object of the same type of an existing variable:
   ```abap
   final(new_ref) = new zcl_anonymous_data_object( i_like = existing_var )->ref( ).
   ```

2. Creating a new anonymous data object with a specified type:
   ```abap
   final(new_ref) = new zcl_anonymous_data_object( i_type = some_var_type )->ref( ).
   ```

3. Copying an existing variable (both type and value) to a new anonymous data object:
   ```abap
   final(copied_var) = new zcl_data_object_copy( existing_var )->ref( ).
   ```
