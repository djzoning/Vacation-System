<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Vacation Request Rejected Notice</title>
</head>
<body>
    <cfoutput>
        <div>
            <!--- <h1>rejected by #data.rejectedBy#</h1> --->
            <cfswitch expression = "#data.rejectedBy#">
                <cfcase value = "fill-in">
                    <p>Your request vacation from #DateFormat(data.getFromDate(), "mm/dd/yyyy")# to #DateFormat(data.getToDate(), "mm/dd/yyyy")# has been rejected by #data.getDeputy().getFirstName()# #data.getDeputy().getLastName()#. 
                    </p>
                </cfcase>
                <cfcase value = "team">
                    <p>Your request vacation from #DateFormat(data.getFromDate(), "mm/dd/yyyy")# to #DateFormat(data.getToDate(), "mm/dd/yyyy")# has been rejected by #data.getUser().getTeam().getLead().getFirstName()# #data.getUser().getTeam().getLead().getLastName()#. 
                    </p>
                </cfcase>
                <cfcase value = "manager">
                    <p>Your request vacation from #DateFormat(data.getFromDate(), "mm/dd/yyyy")# to #DateFormat(data.getToDate(), "mm/dd/yyyy")# has been rejected by #data.manager#. 
                    </p>
                </cfcase>
                
                <cfif data.getRejectedMessage() NEQ ''>
                    <br><br>
                    Please check the following message: 
                    <br>
                    #data.getRejectedMessage()#
                </cfif>
            </cfswitch>     	

			<br>
			<br>
			<br>
			This message is automatically sent by the Vacation Module.
		</div>
    </cfoutput> 
</body>
</html>
