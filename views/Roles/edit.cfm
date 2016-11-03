<cfoutput>
	<div class="row">
		<div class="col-md-12">
			<div class="form-group">
				#html.textField(
					name="name", 
					class="col col-md-6 form-control form-control-solid placeholder-no-fix", 
					placeholder="Enter role name", 
					label="Role",
					value=prc.role.getName(),
					required="required"
				)#
			</div>
			#html.hiddenField(name="id", value=prc.id)#
		</div>
	</div>
</cfoutput>