<cfoutput>
	<form action = "#event.buildLink('vacationStatuses/#prc.actionVar#')#" method = "POST">
		<div class="form-group">
			<label>Role</label>
			<input type="text" class="form-control" name="userRole">
		</div>
		<input type="submit" name="statusName" class="btn btn-primary" value="Approve">
		<input type="submit" name="statusName" class="btn btn-primary" value="Reject">
	</form>
</cfoutput>
