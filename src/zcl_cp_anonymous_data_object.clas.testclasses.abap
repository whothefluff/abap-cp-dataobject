*"* use this source file for your ABAP unit test classes
*class _constructor_tests definition
*                         final
*                         for testing
*                         duration short
*                         risk level harmless.
*
*  private section.
*
*    constants local_w_no_transport type sxco_transport value is initial.
*
*    constants temporary_fugr_nam type sxco_fg_object_name value 'Y___________________000000'.
*
*    constants temporary_func_nam type sxco_fm_name value 'Y___________________0000000001'.
*
*    class-methods delete_temporary_fugr.
*
*    class-methods class_setup.
*
*    class-methods class_teardown.
*
*    methods c_throws_exc_for_invalid_param for testing.
*
*endclass.
*class _constructor_tests implementation.
*
*  method c_throws_exc_for_invalid_param.
*
*    "arrange
*    final(type) = cast cl_abap_datadescr( cl_abap_typedescr=>describe_by_data( `` ) ).
*
*    final(data) = ``.
*
*    "act
*    try.
*
*      call function temporary_func_nam
*        destination 'SELF'
*        exporting
*          i_like         = data
*          i_type         = type
*        exceptions
*          system_failure        = 1
*          communication_failure = 2.
*
*    catch cx_root ##CATCH_ALL ##NO_HANDLER.
*
*    endtry.
*
*    "assert
*    cl_abap_unit_assert=>assert_subrc( exp = 1
*                                       act = sy-subrc ).
*
*  endmethod.
*  method class_setup.
*
*    delete_temporary_fugr( ).
*
*    final(env) = xco_cp_generation=>environment->dev_system( local_w_no_transport ).
*
*    final(fugr_creation) = env->for-fugr->create_post_operation( ).
*
*    final(fugr) = fugr_creation->add_object( xco_cp_name=>choice->fixed( temporary_fugr_nam ) )->set_package( '$TMP' )->create_form_specification( ).
*
*    fugr->set_short_description( 'Temporary generated function for tests' ) ##NO_TEXT.
*
*    fugr_creation->execute( ).
*
*    final(func_creation) = env->for-fugr->create_patch_operation( ).
*
*    final(function_module) = func_creation->add_object( temporary_fugr_nam )->for-insert->add_function_module( temporary_func_nam ).
*
*    function_module->add_importing_parameter( 'I_LIKE' )->set_type( xco_cp_abap=>type-generic->data )->set_optional( ).
*
*    function_module->add_importing_parameter( 'I_TYPE' )->set_type( xco_cp_abap=>class( 'CL_ABAP_DATADESCR' ) )->set_optional( ).
*
*    function_module->set_source_code( xco_cp=>strings( value #( ( `new zcl_cp_anonymous_data_object( i_like = i_like ` ) ##NO_TEXT
*                                                                (                                   `i_type = i_type ).` ) ) ) ).
*
*    func_creation->execute( ).
*
*  endmethod.
*  method class_teardown.
*
*    delete_temporary_fugr( ).
*
*  endmethod.
*  method delete_temporary_fugr.
*
*    final(env) = xco_cp_generation=>environment->dev_system( local_w_no_transport ).
*
*    final(func_deletion) = env->for-fugr->create_patch_operation( ).
*
*    loop at xco_cp_abap=>function_group( temporary_fugr_nam )->function_modules->all->get( ) reference into final(fugr_func).
*
*      func_deletion->add_object( temporary_fugr_nam )->for-delete->add_function_module( fugr_func->*->name ).
*
*    endloop.
*
*    func_deletion->execute( ).
*
*    final(fugr_deletion) = env->for-fugr->create_delete_operation( ).
*
*    fugr_deletion->add_object( temporary_fugr_nam ).
*
*    fugr_deletion->execute( ).
*
*  endmethod.
*
*endclass.
class _ definition
        final
        for testing
        risk level harmless
        duration short.

  protected section.

    methods class_of
              importing
                i_exc type ref to cx_root
              returning
                value(r_val) type ref to cl_abap_classdescr.

    methods type_of
              importing
                i_ref type ref to data
              returning
                value(r_val) type ref to cl_abap_datadescr.

  private section.

    methods const_throws_exc_for_all_param for testing.

    methods const_throws_exc_for_no_param for testing.

    methods const_fills_attr_w_like_param for testing.

    methods const_fills_attr_w_type_param for testing.

    methods ref_returns_attribute for testing.

endclass.

class zcl_cp_anonymous_data_object definition local friends _.

class _ implementation.

  method const_throws_exc_for_all_param.

    "arrange
    final(type) = cast cl_abap_datadescr( cl_abap_typedescr=>describe_by_data( `` ) ).

    final(data) = ``.

    "act
    try.

      new zcl_cp_anonymous_data_object( i_like = data
                                        i_type = type ).

    catch cx_sy_no_handler into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( e is bound
                                               and class_of( e->previous ) eq class_of( new cx_parameter_invalid( ) ) ) ).

  endmethod.
  method const_throws_exc_for_no_param.

    "act
    try.

      new zcl_cp_anonymous_data_object( ).

    catch cx_sy_no_handler into final(e) ##NO_HANDLER.

    endtry.

    "assert
    cl_abap_unit_assert=>assert_true( xsdbool( e is bound
                                               and class_of( e->previous ) eq class_of( new cx_parameter_invalid( ) ) ) ).

  endmethod.
  method const_fills_attr_w_like_param.

    "arrange
    final(data) = ``.

    "act
    final(do) = new zcl_cp_anonymous_data_object( i_like = data ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = cl_abap_typedescr=>describe_by_data( data )
                                        act = type_of( do->_ref ) ).

  endmethod.
  method const_fills_attr_w_type_param.

    "arrange
    final(type) = cast cl_abap_datadescr( cl_abap_typedescr=>describe_by_data( `` ) ).

    "act
    final(do) = new zcl_cp_anonymous_data_object( i_type = type ).

    "assert
    cl_abap_unit_assert=>assert_equals( exp = type
                                        act = type_of( do->_ref ) ).

  endmethod.
  method ref_returns_attribute.

    "arrange
    final(do) = new zcl_cp_anonymous_data_object( i_like = `` ).

    do->_ref = new string( `` ).

    "act & assert
    cl_abap_unit_assert=>assert_equals( exp = do->_ref
                                        act = do->ref( ) ).

  endmethod.
  method class_of.

    cl_abap_typedescr=>describe_by_object_ref( exporting p_object_ref = i_exc
                                               receiving p_descr_ref = final(type)
                                               exceptions others = 0 ).

    r_val = cast #( type ).

  endmethod.
  method type_of.

    cl_abap_typedescr=>describe_by_data_ref( exporting p_data_ref = i_ref
                                             receiving p_descr_ref = final(type)
                                             exceptions others = 0 ).

    r_val = cast #( type ).

  endmethod.

endclass.
