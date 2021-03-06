File 1)	DSK:NVDM05.R10	created: 1240 03-JUN-90
File 2)	DSK:NVDM05.R10[21476,404153]	created: 1818 12-FEB-90

1)1	  MAXIMUM_READ_CUD_BLOCK_SIZE = maximum_convert_block_size_in_sectors * page_size;
1)	  MAXIMUM_READ_CUD_DATA = maximum_read_cud_block_size - maximum_bytes_in_word;
****
2)1	  MAXIMUM_READ_CUD_BLOCK_SIZE = maximum_mud_block_size_in_sectors * page_size;
2)	  MAXIMUM_READ_CUD_DATA = maximum_read_cud_block_size - maximum_bytes_in_word;
**************
1)1	  MAXIMUM_CONVERT_BLOCK = maximum_normal_convert_blocks
1)	     + convert_overflow_blocks;
1)	  CONVERT_BLOCK_LIMIT = maximum_convert_block - 1;
****
2)1	  MAX IMUM_CONVERT_BLOCK = maximum_normal_convert_blocks +
2)	    convert_overflow_blocks;
2)	  CONVERT_BLOCK_LIMIT = maximum_convert_block - 1;
**************
1)1	  FIRST_PAGE_DATA_LIMIT = page_limit - passtable_header_size_in_bytes;
1)	  TAPE_PASSTABLE_LENGTH = passtable_file_length_in_bytes + 4;
****
2)1	  TAPE_PASSTABLE_LENGTH = passtable_file_length_in_bytes + 4;
**************
1)1	  HEADER_DATA_INDEX = 0..first_page_data_limit;
1)	  PASSTABLE_FILLER_INDEX = 0..passtable_filler_limit;
****
2)1	  PASSTABLE_FILLER_INDEX = 0..passtable_filler_limit;
**************
1)1	  FIRST_PASSTABLE_PAGE = record
1)	    header      : passtable_disc_header;
1)	    data        : array [header_data_index] of char
1)	  end (* first_passtable_page *);
1)	  PASSTABLE_ENTRY = record
****
2)1	  PASSTABLE_ENTRY = record
**************
1)1	$if CONVERT_TO_43
1)	  MAXIMUM_CONVERT_READ_SIZE = maximum_convert_block_size_in_sectors * page_size;
1)	  TAPE_CUD_BLOCK_SIZE = (MAXIMUM_CONVERT_READ_SIZE + 4) * TAPE_BLOCKING_FACTOR;
1)	$endif CONVERT_TO43
1)	$ifnone CONVERT_TO_43  TAPE_CUD_BLOCK_SIZE = (MAXIMUM_CUD_BLOCK_SIZE + 4) * TAPE_BLOCKING_FACTOR;
****
2)1	$if CONVERT_TO_43  TAPE_CUD_BLOCK_SIZE = (MAXIMUM_READ_CUD_BLOCK_SIZE + 4) * TAPE_BLOCKING_FACTOR;
2)	$ifnone CONVERT_TO_43  TAPE_CUD_BLOCK_SIZE = (MAXIMUM_CUD_BLOCK_SIZE + 4) * TAPE_BLOCKING_FACTOR;
**************
1)1	$ifnot BEFORE_SUP_V43
1)	$ifnot convert_to_43     MAXIMUM_MUD_BLOCK_SIZE_IN_SECTORS
1)	$if convert_to_43     MAXIMUM_CONVERT_BLOCK_SIZE_IN_SECTORS
1)	$endif BEFORE_SUP_V43
1)	    * TAPE_BLOCKING_FACTOR;
****
2)1	$ifnot BEFORE_SUP_V43    MAXIMUM_MUD_BLOCK_SIZE_IN_SECTORS
2)	    * TAPE_BLOCKING_FACTOR;
**************
1)1	 
1)	 
1)	(*************************  passtable_handler  **************************)
1)	(*                                                                      *)
File 1)	DSK:NVDM05.R10	created: 1240 03-JUN-90
File 2)	DSK:NVDM05.R10[21476,404153]	created: 1818 12-FEB-90

1)	(*                           check_passtable                            *)
1)	(*                                                                      *)
1)	(************************************************************************)
1)	 
1)	procedure entry CHECK_PASSTABLE(
1)	  var all_match : boolean);
1)	 
1)	var
1)	  read_ok : boolean;
1)	  header_page : first_passtable_page;
1)	begin
1)	  dsksys.page_request(
1)	$if logical_volumes             lv_dir.files_unit,
1)	$ifnone logical_volumes         FILE_SYSTEM_DISK,
1)	    DISK_READ, PASSTABLE_FILE_START, header_page, read_ok);
1)	  if not read_ok
1)	  then user_terminal.write_quoted_text_line('Error reading PASSTABLE file\ ')
1)	  else
1)	    if header_page.header.file_id <> PASSTABLE_FILE_ID
1)	    then
1)	      begin
1)	        all_match := FALSE;
1)	        user_terminal.write_quoted_text_line('Error on PASSTABLE file ID\ ')
1)	      end
1)	end (* check_passtable *);
1)	$endif disk_maintenance_code
****
2)1	$endif disk_maintenance_code
**************
1)1	  schedtable : actual_schedtable_data;
1)	$if include_dnic
1)	  dnic_header : dnic_table_header;
1)	$endif include_dnic
1)	begin
****
2)1	begin
**************
1)1	$if include_dnic
1)	  dsksys.page_request(
1)	(*      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-  *)
1)	$if logical_volumes      lv_dir.files_unit,
1)	$ifnone logical_volumes     FILE_SYSTEM_DISK,
1)	(*      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-  *)
1)	    DISK_READ, DNIC_FILE_HEADER_START, dnic_header, read_ok);
1)	  if not read_ok
1)	  then user_terminal.write_quoted_text_line('Error reading DNIC file\')
1)	  else
1)	    if dnic_header.file_id <> DNIC_FILE_ID
1)	    then
1)	      begin
1)	        all_match := FALSE;
1)	        user_terminal.write_quoted_text_line('Error on DNIC file ID\')
1)	      end;
1)	$endif include_dnic
File 1)	DSK:NVDM05.R10	created: 1240 03-JUN-90
File 2)	DSK:NVDM05.R10[21476,404153]	created: 1818 12-FEB-90

1)	 dsksys.page_request(
1)	$if logical_volumes     lv_dir.files_unit,
1)	$ifnone logical_volumes     FILE_SYSTEM_DISK,
1)	    DISK_READ, SCHEDTABLE_FILE_START, schedtable, read_ok);
1)	  if not read_ok
1)	  then user_terminal.write_quoted_text_line('Error reading SCHEDTABLE file\')
1)	  else
1)	    if schedtable.header <> SCHEDTABLE_FILE_ID
1)	    then
1)	      begin
1)	        all_match := FALSE;
1)	        user_terminal.write_quoted_text_line('Error on SCHEDTABLE file ID\')
1)	      end
1)	end (* check_file *);
****
2)1	end (* check_file *);
**************
1)1	$if CONVERT_TO_43   sup_43 : boolean;
1)	begin
****
2)1	begin
**************
1)1	   if not ok
1)	$endif CONVERT_TO_43
****
2)1	  if (ok and not (label_version = version)) or
2)	    (sup_43 and (label_version = version))
2)	$endif CONVERT_TO_43
**************
1)1	                  report_illegal_offset(tape_buffer[tape_index].block)
1)			end
****
2)1			  report_illegal_offset(tape_buffer[tape_index].block)
2)			end
**************
1)1	  if ok and user_terminal.sendable
****
2)1	  else
2)	    if scanned.status <> RUN_ERROR
2)	    then user_terminal.write_quoted_text_line('command is: 'reformat UNIT#\');
2)	  if ok and user_terminal.sendable
**************
1)1	$ifany (force_password_change, global_password_only_login)
1)	            if user_terminal.sendable
1)	            then pasmon.check_passtable(all_match);
1)	$endif any(force_password_change, global_password_only_login)
1)		    if user_terminal.sendable and check_cud_checksum
****
2)1		    if user_terminal.sendable and check_cud_checksum
**************
  