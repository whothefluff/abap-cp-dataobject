"! <p class="shorttext synchronized" lang="EN">Data Object Copy</p>
class zcl_cp_data_object_copy definition
                              public
                              create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Creates an instance representing the copy of a Data Object</p>
    "!
    "! @parameter i_data_object | <p class="shorttext synchronized" lang="EN">Existing Data Object</p>
    methods constructor
              importing
                i_data_object type data
                i_factory type ref to object optional.

    "! <p class="shorttext synchronized" lang="EN">Returns the copied Data Object</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Data Object reference</p>
    methods ref
              returning
                value(r_val) type ref to data.

  protected section.

    data _ref type ref to data.

endclass.
class zcl_cp_data_object_copy implementation.

  method constructor.

    final(new_data_object) = new zcl_cp_anonymous_data_object( i_like = i_data_object )->ref( ).

    new_data_object->* = i_data_object.

    _ref = new_data_object.

  endmethod.
  method ref.

    r_val = _ref.

  endmethod.

endclass.
