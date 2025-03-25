"! <p class="shorttext synchronized" lang="EN">Anonymous Data Object</p>
class zcl_cp_anonymous_data_object definition
                                   public
                                   create public.

  public section.

    "! <p class="shorttext synchronized" lang="EN">Creates an instance representing a new anonymous Data Object</p>
    "! Use exactly one of the parameters. A runtime error occurs otherwise
    "!
    "! @parameter i_like | <p class="shorttext synchronized" lang="EN">Use an existing Data Object</p>
    "! @parameter i_type | <p class="shorttext synchronized" lang="EN">Use a data type</p>
    methods constructor
              importing
                i_like type data optional
                i_type type ref to cl_abap_datadescr optional.

    "! <p class="shorttext synchronized" lang="EN">Returns the new Data Object</p>
    "!
    "! @parameter r_val | <p class="shorttext synchronized" lang="EN">Data Object reference</p>
    methods ref
              returning
                value(r_val) type ref to data.

  protected section.

    data _ref type ref to data.

endclass.
class zcl_cp_anonymous_data_object implementation.

  method constructor.

    if i_like is supplied and i_type is bound. "both

      raise exception new cx_parameter_invalid( parameter = `i_like + i_type` ) ##NO_TEXT.

    elseif i_like is not supplied and i_type is not bound. "neither

      raise exception new cx_parameter_invalid( parameter = `NULL` ) ##NO_TEXT.

    endif.

    if i_like is supplied.

      create data _ref like i_like.

    elseif i_type is bound.

      create data _ref type handle i_type.

    endif.

  endmethod.
  method ref.

    r_val = _ref.

  endmethod.

endclass.
