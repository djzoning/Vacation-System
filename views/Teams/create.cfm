<cfoutput>
	<div class="form-group">
		#html.textField(
			label = "Name", 
			name = "name", 
			id = "name", 
			class = "form-control", 
			required = "required"
		)#
	</div>
	<div class="form-group">
		#html.inputField(
			label = "Max Allowed Simultaneous Vacations", 
			type = "number", 
			name = "maxVacationers", 
			id = "maxVacationers", 
			class = "form-control", 
			required = "required"
		)#
	</div>
</cfoutput>