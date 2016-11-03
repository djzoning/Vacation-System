<cfoutput>
	<div class="form-group">
		#html.inputField(
			label = "Name", 
			type = "text", 
			name = "name",
			class = "form-control", 
			required = "required", 
			value = ""
		)#
	</div>
	<div class="form-group">
		#html.inputField(
			label = "Days Limit", 
			type = "text", 
			name = "daysLimit",
			class = "form-control",  
			value = ""

		)#
	</div>
</cfoutput>