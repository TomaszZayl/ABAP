*&---------------------------------------------------------------------*
*& Report  Z_TG_COMPARE_TABLE
*&---------------------------------------------------------------------*

REPORT z_tg_compare_table.

TYPES: BEGIN OF gts_string,
         lv_str           TYPE string,
       END OF gts_string.

TYPES: BEGIN OF gts_compare,
          lv_com_str      TYPE string,
       END OF gts_compare.

PARAMETERS: lp_usrin      TYPE i,
            lp_compt      RADIOBUTTON GROUP rb,
            lp_showt      RADIOBUTTON GROUP rb.

DATA: it_first_table      TYPE TABLE OF gts_string,
      it_second_table     TYPE TABLE OF gts_string,
      it_compare_table    TYPE TABLE OF gts_compare.

FIELD-SYMBOLS <wa_ft_record>  LIKE LINE OF it_first_table.
FIELD-SYMBOLS <wa_st_record>  LIKE LINE OF it_second_table.

it_first_table = VALUE #(
                          ( lv_str = 'Lorem ipsum dolor sit amet' )
                          ( lv_str = 'Consectetur adipiscing elit' )
                          ( lv_str = 'Proin nibh augue, suscipit a, scelerisque sed' )
                          ( lv_str = 'Etiam pellentesque aliquet tellus' )
                          ( lv_str = 'Phasellus pharetra nulla ac diam' )
                          ( lv_str = 'Quisque semper justo at risus' )
                          ( lv_str = 'Donec venenatis, turpis vel hendrerit interdum' )
                          ( lv_str = 'Nam congue, pede vitae dapibus aliquet' )
                          ( lv_str = 'Etiam sit amet lectus quis est congue mollis' )
                          ( lv_str = 'Phasellus congue lacus eget neque' )
                          ( lv_str = 'Phasellus ornare, ante vitae consectetuer consequat' )
                          ( lv_str = 'Praesent sodales velit quis augue' )
                        ).

it_second_table = VALUE #(
                          ( lv_str = 'Lorem ipsum dolor sit amet' )
                          ( lv_str = 'Consectetur adipiscing elit' )
                          ( lv_str = 'Proin nibh augue, suscipit a, scelerisque sed' )
                          ( lv_str = 'Etiam pellentesque aliquet tellus' )
                          ( lv_str = 'Phasellus pharetra nulla ac diam' )
                          ( lv_str = 'Quisque semper justo at risus' )
                          ( lv_str = 'Donec venenatis, turpis vel hendrerit interdum' )
                          ( lv_str = 'Nam congue, pede vitae dapibus aliquet' )
                          ( lv_str = 'Etiam sit amet lectus quis est congue mollis' )
                          ( lv_str = 'Consectetur adipiscing elit' )
                          ( lv_str = 'Phasellus ornare, ante vitae consectetuer consequat' )
                          ( lv_str = 'Praesent sodales velit quis augue' )
                         ).


IF lp_compt = 'X'.
  PERFORM compare_tables.
ELSEIF  lp_showt = 'X'.
  PERFORM show_table.
ENDIF.

******************** BEGIN OF COMPARE TABLES ********************
FORM compare_tables.
  FIELD-SYMBOLS <wa_com_record> LIKE LINE OF it_compare_table.

  DATA: lv_ft_rec LIKE LINE OF it_first_table.

  READ TABLE: it_first_table INDEX lp_usrin INTO lv_ft_rec.

  WRITE: 'I''m searching for', lp_usrin LEFT-JUSTIFIED, '. index ...'. NEW-LINE.
  WRITE: 'It seems that value of ', lp_usrin LEFT-JUSTIFIED, '. index is: ', lv_ft_rec-lv_str COLOR 3. NEW-LINE.
  WRITE: /,'I''m comparing values ...'. NEW-LINE.
  WRITE: 'Results are ...', /, /1 sy-uline(83).

  LOOP AT it_second_table ASSIGNING <wa_st_record>.
    IF lv_ft_rec-lv_str EQ <wa_st_record>-lv_str.
      WRITE:   /1 sy-vline,'Entry from first table','IS FOUND ' COLOR 5,'    on ', sy-tabix LEFT-JUSTIFIED,'. index of second table.' LEFT-JUSTIFIED,
               /1 sy-vline,'Value of this index is: ', <wa_st_record>-lv_str COLOR 3, /1 sy-uline(83).
    ELSE.
      WRITE:   /1 sy-vline,'Entry from first table','IS NOT FOUND ' COLOR 6,'on ', sy-tabix LEFT-JUSTIFIED,'. index of second table.' LEFT-JUSTIFIED,
               /1 sy-vline,'Value of this index is: ', <wa_st_record>-lv_str COLOR 3, /1 sy-uline(83).
    ENDIF.
  ENDLOOP.
ENDFORM.
******************** END OF COMPARE TABLES ********************

******************** BEGIN OF SHOW TABLES ********************
FORM show_table.
  IF lines( it_first_table ) > 0.
    WRITE: 'First table:'.
    LOOP AT it_first_table ASSIGNING <wa_ft_record>.
      WRITE: / sy-tabix, <wa_ft_record>-lv_str.
    ENDLOOP.
  ENDIF.

  SKIP 2.

  WRITE: 'Second table:'.
  IF lines( it_second_table ) > 0.
    LOOP AT it_second_table ASSIGNING <wa_st_record>.
      WRITE: / sy-tabix, <wa_st_record>-lv_str.
    ENDLOOP.
  ENDIF.

ENDFORM.
******************** END OF SHOW TABLES ********************
