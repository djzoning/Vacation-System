<cfoutput>
	<div class="form-group">
		#html.inputField(
			type = "hidden", 
			name = "teamId", 
			id = "teamId", 
			value = "#prc.team.getId()#"
		)#	
	</div>
	<div class="form-group">
		#html.textField(
			label = "Name", 
			name = "name", 
			id = "name", 
			class = "form-control", 
			value = "#prc.team.getName()#", 
			required = "required"
		)#
	</div>
	<div class="form-group">
		#html.inputField(
			label = "Max allowed vacationers", 
			type = "number", 
			name = "maxVacationers", 
			id = "maxVacationers", 
			class = "form-control", 
			value = "#prc.team.getMaxVacationers()#", 
			required = "required"
		)#
	</div>
	<div class="form-group">
		#html.select(
			options = #prc.users#,
			column = "Id",
			nameColumn = "FirstName",
			selectedValue = "#isNull(#prc.team.getLead()#) ? '' : prc.team.getLead().getId()#",
			label = "Lead",
			name = "lead",
			id = "lead",
			required = "required",
			class = "form-control"			
		)#
	</div>
	
	<!--- TODO: list employees? --->
	<!--- #html.select(
		options = #prc.team.getUsers()#,
		column = "Id",
		nameColumn = "FirstName",
		label = "Employees",
		multiple = "true",
		name = "users",
		id = "users",
		requirecd = "required",
		wrapper = "div",
		class = "form-control"
	)# --->

</cfoutput>
