*"* use this source file for your ABAP unit test classes
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  "this class cannot be realistically tested using ABAP, because they don't have overloading and they don't have a useful mocking library and they have a million weird rules that makes this a literal nightmare to work with

  private section.

    methods ref_returns_attribute for testing.

endclass.

class zcl_cp_data_object_copy definition local friends _.

class _ implementation.

  method ref_returns_attribute.

    "arrange
    final(copy) = new zcl_cp_data_object_copy( '' ).

    copy->_ref = new i( 7 ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = copy->_ref
                                        act = copy->ref( ) ).

  endmethod.

endclass.
