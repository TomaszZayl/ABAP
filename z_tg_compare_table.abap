*&---------------------------------------------------------------------*
*& Report z_tg_compare_table
*&---------------------------------------------------------------------*

REPORT z_tg_compare_table.

TYPES: BEGIN OF gts_string,
         lv_str           TYPE string,
         lv_ind           TYPE i,
       END OF gts_string.

TYPES: BEGIN OF gts_compare,
          lv_com_str      TYPE string,
          lv_index        LIKE sy-tabix,
       END OF gts_compare.

PARAMETERS: lp_compt      RADIOBUTTON GROUP rb,
            lp_showt      RADIOBUTTON GROUP rb.

DATA: it_first_table      TYPE TABLE OF gts_string,
      it_second_table     TYPE TABLE OF gts_string,
      it_compare_table    TYPE TABLE OF gts_compare.

it_first_table = VALUE #(
                          ( lv_ind = 1  lv_str = 'First index First Table'   )
                          ( lv_ind = 2  lv_str = 'Second index First Table'  )
                          ( lv_ind = 3  lv_str = 'Third index First Table'   )
                          ( lv_ind = 4  lv_str = 'Fourth index First Table'  )
                          ( lv_ind = 5  lv_str = 'Fifth index First Table'   )
                          ( lv_ind = 6  lv_str = 'Sixth index First Table'   )
                          ( lv_ind = 7  lv_str = 'Seventh index First Table' )
                          ( lv_ind = 8  lv_str = 'Eight index First Table'   )
                          ( lv_ind = 9  lv_str = 'Ninth index First Table'   )
                          ( lv_ind = 10 lv_str = 'Tenth index First Table'   )
                        ).

it_second_table = VALUE #(
                          ( lv_ind = 1  lv_str = 'First index First Table'   )
                          ( lv_ind = 2  lv_str = 'Second index First Table'  )
                          ( lv_ind = 3  lv_str = 'Third index First Table'   )
                          ( lv_ind = 4  lv_str = 'Fourth index First Table'  )
                          ( lv_ind = 5  lv_str = 'Fifth index First Table'   )
                          ( lv_ind = 6  lv_str = 'Sixth index First Table'   )
                          ( lv_ind = 7  lv_str = 'Seventh index First Table' )
                          ( lv_ind = 8  lv_str = 'Eighth index First Table'  )
                          ( lv_ind = 9  lv_str = 'Ninth index First Table'   )
                          ( lv_ind = 10 lv_str = 'Tentha index First Table'  )
                         ).

IF lp_compt = 'X'.
  PERFORM compare_tables.
ELSEIF  lp_showt = 'X'.
  PERFORM show_table.
ENDIF.

******************** BEGIN OF COMPARE TABLES ********************
FORM compare_tables.

  FIELD-SYMBOLS <wa_ft_record> LIKE LINE OF it_first_table.
  FIELD-SYMBOLS <wa_st_record> LIKE LINE OF it_second_table.
  FIELD-SYMBOLS <wa_com_record> LIKE LINE OF it_compare_table.

  IF lines( it_first_table ) > 0.
    LOOP AT it_first_table ASSIGNING <wa_ft_record>.
      LOOP AT it_second_table ASSIGNING <wa_st_record>.
        IF <wa_ft_record> EQ <wa_st_record>.
          APPEND VALUE #( lv_com_str = 'Values are the same' lv_index = sy-tabix ) TO it_compare_table.
        ENDIF.
      ENDLOOP.
    ENDLOOP.

    LOOP AT it_compare_table ASSIGNING <wa_com_record>.
      WRITE:
          / <wa_com_record>-lv_com_str, 'in index no. ', <wa_com_record>-lv_index LEFT-JUSTIFIED,
          /1 sy-uline(50).
    ENDLOOP.
  ENDIF.

ENDFORM.
******************** END OF COMPARE TABLES ********************

******************** BEGIN OF SHOW TABLES ********************
FORM show_table.
  FIELD-SYMBOLS <wa_first_record> LIKE LINE OF it_first_table.
  FIELD-SYMBOLS <wa_second_record> LIKE LINE OF it_second_table.

  IF lines( it_first_table ) > 0.
    WRITE: 'First table:'.
    LOOP AT it_first_table ASSIGNING <wa_first_record>.
      WRITE: / <wa_first_record>-lv_ind, <wa_first_record>-lv_str.
    ENDLOOP.
  ENDIF.

  SKIP 2.

  WRITE: 'Second table:'.
  IF lines( it_second_table ) > 0.
    LOOP AT it_second_table ASSIGNING <wa_second_record>.
      WRITE: / <wa_second_record>-lv_ind, <wa_second_record>-lv_str.
    ENDLOOP.
  ENDIF.

ENDFORM.
******************** END OF SHOW TABLES ********************