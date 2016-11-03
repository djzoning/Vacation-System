<cfoutput>		
	<div id = "alerts-container"></div>
	
	<cfset fromToDate = structKeyExists(prc, "vacation") ? '#prc.vacation.getFromDate()# - #prc.vacation.getToDate()#' : "" />
	<cfset length = structKeyExists(prc, "vacation") ? '#prc.vacation.getLength()#' : "" />
	<cfset typeId = structKeyExists(prc, "vacation") ? '#prc.vacation.getType().getId()#' : "" />
	<cfset deputyId = structKeyExists(prc, "vacation") ? '#prc.vacation.getDeputy().getId()#' : "" />
	<cfset description = structKeyExists(prc, "vacation") ? '#prc.vacation.getDescription()#' : "" />

	#html.hiddenField(
		name = "userId", 
		value = "#prc.loggedUser#", 
		id = "userId"
	)#
	#html.hiddenField(
		name = "availableDays", 
		value = "#prc.availableDays#", 
		id = "availableDays"
	)#
	#html.hiddenField(
		name = "daysLimit", 
		value = "0", 
		id = "daysLimit"
	)#
	#html.hiddenField(
		name = "maxAllowedPaid", 
		value = "#getSetting('maxAllowedVacationDays')#", 
		id = "maxAllowedPaid"
	)#
	#html.hiddenField(
		name = "statusId", 
		value = "1", 
		id = "statusId"
	)#
	#html.hiddenField(
		name = "teamId", 
		value = "#prc.userTeamId#", 
		id = "teamId"
	)#
	<div class="form-group">
		#html.inputField(
			label = "From - To", 
			type = "text", 
			name = "fromToDate",
			class = "form-control", 
			required = "required", 
			value = "#fromToDate#"
		)#
	</div>
	<div class="form-group">
		#html.inputField(
			label = "Length", 
			type = "numeric", 
			name = "length", 
			class = "form-control", 
			required = "required", 
			value = "#length#", 
			data = { toggle = "popover", placement = "top" }, 
			title = "Please, check if the length is correct"
		)#
	</div>
	<div class="form-group">
		#html.select(
	    	options = "#prc.types#",
			column = "Id",
			nameColumn = "Name",
			selectedValue = "#typeId#",
	    	name = "typeId",
	    	label = "Type",
	    	required = "required",
	    	class = "form-control select2"
	    )#
    </div>
	<div class="form-group">
	    #html.select(
	    	options = "#prc.users#",
	    	column = "Id",
	    	nameColumn = "FirstName",
	    	selectedValue = "#deputyId#",
	    	name = "deputyId",
	    	label = "Fill-in",
	    	required = "required",
	    	class = "form-control select2"
	    )#
    </div>
	<div class="form-group">
		#html.textarea(
			label = "Description", 
			name = "description", 
			id = "description", 
			rows = "5", 
			class = "form-control", 
			value = "#description#"
		)#
</div>
</cfoutput>