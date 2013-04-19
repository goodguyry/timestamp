--  TimeStamp.app
--  Created by Ryan Domingue on 7/20/09; Update 2/10/13

--------------------------------------------------------------
--  Icon clicked
--------------------------------------------------------------
on run
	
	try
		tell application "Finder"
			set sel to the selection as text
			set the clipboard to POSIX path of sel
		end tell
		-- set to "false" to timestamp without duplication
		my addTimeStamp(true)
	on error
		beep 2
	end try
	return
	
end run

--------------------------------------------------------------
--  Item droppped on icon
--------------------------------------------------------------
on open names
	
	-- set to "true" to timestamp a duplicate file
	my addTimeStamp(false)
	return
	
end open

--------------------------------------------------------------
--  Receives boolean value

--  Appends the date provided to the end of the filename
--------------------------------------------------------------
on addTimeStamp(fileDup)
	
	set AppleScript's text item delimiters to ""
	
	tell application "Finder"
		
		set these_files to the selection
		
		repeat with i in these_files
			if fileDup then
				set dup to duplicate i
			else
				set dup to i
			end if
			
			set thisName to the name of i
			set thisExt to the name extension of i
			
			if thisExt is not "" then
				set thisExt to "." & thisExt
				set AppleScript's text item delimiters to thisExt
				set newName to (text items 1 thru ((the count of (every text item of thisName)) - 1) of thisName) as text
			else
				set newName to thisName
			end if
			
			set AppleScript's text item delimiters to ""
			set newName to newName & "_" & (formatDate(the current date) of me) & thisExt
			
			set the name of dup to newName
			
		end repeat
		
	end tell
	
end addTimeStamp

--------------------------------------------------------------
--  Receives a date

--  Formats the date given
--  Returns a formatted date/time
--------------------------------------------------------------
on formatDate(x)
	
	set old_delims to AppleScript's text item delimiters
	set AppleScript's text item delimiters to ""
	
	-- format date/time as yyyymmdd_hhmmss
	set the_result to Â
		(the year of x & Â
			double_digit(the month of x as number) & Â
			double_digit(the day of x) & "_" & Â
			double_digit(the hours of x) & Â
			double_digit(the minutes of x) & Â
			double_digit(the seconds of x) Â
				) as text
	
	set AppleScript's text item delimiters to old_delims
	return the_result
	
end formatDate

--------------------------------------------------------------
--  Receives a date

--  Formats single digit time and date values to double digit
--  Returns a formatted date/time
--------------------------------------------------------------
on double_digit(x)
	if x < 10 then return "0" & (x as text)
	return x as text
end double_digit
