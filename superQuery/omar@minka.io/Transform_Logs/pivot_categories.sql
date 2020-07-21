CALL fhoffa.x.pivot(
   'minka-ach-dw.temp.logs_transfor_test' # source table
  , 'minka-ach-dw.temp.logs_pivot_test' # destination table
  , ['transfer_id'] # row_ids
  , 'category' # pivot_col_name
  , 'payload' # pivot_col_value
  , 100 # max_columns
  , 'COUNT' # aggregation
  , '' # optional_limit
);
