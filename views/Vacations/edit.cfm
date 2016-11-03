<cfoutput>
	#getModel( "messagebox@cbmessagebox" ).renderit()#
	
	<cfset disabled = SESSION.user.id NEQ prc.vacation.getUser().getId() ? ',disabled="true"' : "" />
		<!--- ALERTS --->
		#html.hiddenField(
			name = "maxAllowedPaidAlert", 
			id = "maxAllowedPaidAlert", 
			value = "#prc.maxAllowedPaidAlert#"
		)#
		#html.hiddenField(
			name = "teamUsersAlert", 
			id = "teamUsersAlert", 
			value = "#prc.teamUsersAlert#"
		)#
	    #html.hiddenField(
	    	name = "vacationTypeLengthAlert", 
	    	id = "vacationTypeLengthAlert", 
	    	value = "#prc.vacationTypeLengthAlert#"
	    )#
	    #html.hiddenField(
	    	name = "vacationLengthAlert", 
	    	id = "vacationLengthAlert", 
	    	value = "#prc.vacationLengthAlert#"
	    )#
	    <!---  --->
		#html.hiddenField(
			name = "userId", 
			value = "#prc.vacation.getUser().getId()#", 
			id = "userId"
		)#
		#html.hiddenField(
			name = "statusId", 
			value = "#prc.vacation.getStatus().getId()#", 
			id = "statusId"
		)#
		#html.hiddenField(
			name = "objectAction", 
			value = "#event.getCurrentAction()#"
		)#
		#html.hiddenField(
			name = "objectName", 
			value = "#event.getCurrentHandler()#", 
			id = "statusId"
		)#
		#html.hiddenField(
			name = "vacationId", 
			value = "#prc.vacation.getId()#", 
			id = "vacationId"
		)#
		#html.hiddenField(
			name = "teamId", 
			value = "#SESSION.user.team.id#", 
			id = "teamId"
		)#
		#html.hiddenField(
			name = "availableDays", 
			value = "#prc.availableDays#", 
			id = "availableDays"
		)#
		#html.hiddenField(
			name = "daysLimit", 
			value = "#prc.daysLimit#", 
			id = "daysLimit"
		)#
		#html.hiddenField(
			name = "maxAllowedPaid", 
			value = "#getSetting('maxAllowedVacationDays')#", 
			id = "maxAllowedPaid"
		)#
		<div id = "alerts-container-edit"></div>
		<div class="form-group">
			#html.inputField(
				label = "From - To", 
				type = "text", 
				name = "fromToDate", 
				class = "form-control", 
				required = "required", 
				value = "#prc.vacation.fromToDate#", 
				data = { toggle = "popover", placement = "top" }, 
				title = "Please, check if the length is correct"
			)#
		</div>
		<div class="form-group">
			#html.inputField(
				label = "Length", 
				type = "numeric", 
				value = "#prc.vacation.getLength()#", 
				name = "length", 
				class = "form-control", 
				required = "required"
			)#
		</div>
		<div class="form-group">
			#html.select(
		    	options = #prc.types#,
				column = "Id",
				nameColumn = "Name",
				selectedValue = "#prc.vacation.getType().getId()#",
		    	name = "typeId",
		    	label = "Type",
		    	required = "required",
		    	class = "form-control select2"
		    )#
	    </div>
		<div class="form-group">
		    #html.select(
		    	options = #prc.users#,
		    	column = "Id",
		    	nameColumn = "FirstName",
		    	selectedValue = "#prc.vacation.getDeputy().getId()#",
		    	name = "deputyId",
		    	label = "Fill-in",
		    	required = "required",
		    	class = "form-control select2"
		    )#
		</div>
		<div class="form-group">
		    #html.textarea(
		    	label = "Description", 
		    	value = "#prc.vacation.getDescription()#", 
		    	name = "description", 
		    	id = "description", 
		    	rows = "5", 
		    	class = "form-control"
		    )#
		</div>
</cfoutput>
