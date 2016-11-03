<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Weekly Vacation Notification</title>
    <style>
    	div {
    		font-family: 'Helvetica'
    	}
    	td {
            text-align: center;
            padding: 5px;
        }
        th {
        	padding: 12px;
        }
        .text-left {
        	text-align: left;
        }
    </style>
</head>
<body>
	<cfoutput>
        <div>
			<p>Dear colleagues,</p>
			<p>Please note that the following people will be on vacation next week:</p>
			
			<table>
				<thead>
					<tr>
						<th>Employee</th>
						<th>Team</th>
						<th>Vacation Type</th>
						<th>From-To</th>
						<th>Fill-in</th>
					</tr>					
				</thead>
				<tbody>
					<cfloop array="#data#" index="vacation">
						<cfset fromDate = DateFormat(vacation.getFromDate(), "m/d/yy") />
						<cfset toDate = DateFormat(vacation.getToDate(), "m/d/yy") />
						<tr>
							<td class="text-left">#vacation.getUser().getFirstname()# #vacation.getUser().getLastName()#</td>
							<td>#vacation.getUser().getTeam().getName()#</td>
							<td>#vacation.getType().getName()#</td>
							<td>#fromDate# - #toDate#</td>
							<td class="text-left">#vacation.getDeputy().getfirstName()#</td>
						</tr>
					</cfloop>
				</tbody>
			</table>
			
			<br>
			<br>
			<br>
			This message is automatically sent by the Vacation Module.
		</div>
    </cfoutput> 
</body>
</html>
