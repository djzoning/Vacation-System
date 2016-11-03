<cfoutput>
	
	<div id = "alerts-container"></div>	

	<!--- <cfset vacationTypes = #prc.vacationTypes# /> --->
	<!--- <cfdump var="#vacationTypes#" /> --->
	#html.hiddenField(
		name = "vacationTypes", 
		value = "",
		id = "vacationTypes"
	)#
	<div class="form-group">
		#html.inputField(
			label = "Name", 
			type = "text", 
			name = "name",
			class = "form-control",
			id = "name", 
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
