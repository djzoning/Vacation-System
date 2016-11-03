<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vacation Request</title>
</head>
<body>
    <cfoutput>
        <div>
            <!--- <h1>send to #data.sendTo#</h1> --->
        	<cfswitch expression = "#data.sendTo#">
        		<cfcase value = "fill-in">
        			<p>#data.getUser().getFirstName()# submitted a vacation request and mentioned you as fill-in. Please review the request and Accept or Deny it:</p>
        		</cfcase>
        		<cfcase value = "lead">
        			<p>#data.getUser().getFirstName()# submitted a vacation request. Please review the request and Approve or Reject it:</p>
        		</cfcase>
        		<cfcase value = "manager">
        			<p>#data.getUser().getFirstName()# submitted a vacation request. Please review the request and Reject it if needed:</p>
        		</cfcase>
        	</cfswitch>
        	
			<table>
				<thead>
				</thead>
				<tbody>
					<tr>
						<th align = "left">Employee</th>
						<td>#data.getUser().getFirstname()#</td>
					</tr>
					<tr>
						<th align = "left">Team</th>
						<td>#data.getUser().getTeam().getName()#</td>
					</tr>
					<tr>
						<th align = "left">Vacation Type</th>
						<td>#data.getType().getName()#</td>
					</tr>
					<tr>
						<th align = "left">From-To</th>
						<td>#DateFormat(data.getFromDate(), "mm/dd/yyyy")# - #DateFormat(data.getToDate(), "mm/dd/yyyy")#</td>
					</tr>
					<tr>
						<th align = "left">Fill-in</th>
						<td>
							#data.getDeputy().getFirstName()# 
							<cfif data.sendTo NEQ "fill-in">
								- Approved
							</cfif>
						</td>
					</tr>
					<tr>
						<th align = "left">Description</th>
						<td>#data.getDescription()#</td>
					</tr>
				</tbody>
			</table>			
			<br>
			<br>
			<a href="http://#CGI.SERVER_NAME#/Vacations/view/#data.getId()#">
				Click here for actions
			</a>
			<br>
			This message is automatically sent by the Vacation Module.
		</div>
    </cfoutput> 
</body>
</html>