<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vacation Approval Notice</title>
</head>
<body>
    <cfoutput>
        <div>
            <!--- <h1>approved by #data.approvedBy#</h1>
            <h1>send to #data.getUser().getEmail()#</h1> --->
            <cfswitch expression = "#data.approvedBy#">
                <cfcase value = "Fill-in">
                    <p>Your vacation request from #DateFormat(data.getFromDate(), "mm/dd/yyyy")# to #DateFormat(data.getToDate(), "mm/dd/yyyy")# has been accepted by #data.getDeputy().getFirstName()# #data.getDeputy().getLastName()#.</p>
                </cfcase>
                <cfcase value = "Lead">
                    <p>Your vacation request from #DateFormat(data.getFromDate(), "mm/dd/yyyy")# to #DateFormat(data.getToDate(), "mm/dd/yyyy")# has been approved by #data.getUser().getTeam().getLead().getFirstName()# #data.getUser().getTeam().getLead().getLastName()#.</p>
                </cfcase>
                <cfcase value = "Manager">
                    <p>Your vacation request from #DateFormat(data.getFromDate(), "mm/dd/yyyy")# to #DateFormat(data.getToDate(), "mm/dd/yyyy")# has been approved by #data.sendFromFirstName# #data.sendFromLastName#.</p>
                </cfcase>
            </cfswitch>
			<br>
			<br>
			<br>
			This message is automatically sent by the Vacation Module.
		</div>
    </cfoutput> 
</body>
</html>