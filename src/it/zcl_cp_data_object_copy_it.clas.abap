"! <p class="shorttext synchronized" lang="EN">Integration Testing</p>
"! @testing ZCL_CP_ANONYMOUS_DATA_OBJECT
"! @testing ZCL_CP_DATA_OBJECT_COPY
class zcl_cp_data_object_copy_it definition
                                 public
                                 create public
                                 for testing
                                 risk level harmless
                                 duration short.

  public section.

    methods clone_value for testing.

  protected section.

endclass.
class zcl_cp_data_object_copy_it implementation.

  method clone_value.

    "arrange
    data(some_val) = 3.

    "act
    final(copy) = new zcl_cp_data_object_copy( some_val )->ref( ).

    some_val += 1.

    "assert
    cl_abap_unit_assert=>assert_equals( exp = 3
                                        act = copy->* ).

  endmethod.

endclass.
