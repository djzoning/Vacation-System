<cfoutput>
	<input type="hidden" name="id" value="#prc.vacationType.getId()#">
	<div class="form-group">
		<label>Name</label>
		<input class="form-control" type="text" name="name" value="#prc.vacationType.getName()#">
	</div>
	<div class="form-group">
		<label>Days limit</label>
		<input class="form-control" type="text" name="daysLimit" value="#prc.vacationType.getDaysLimit()#">
	</div>
</cfoutput>