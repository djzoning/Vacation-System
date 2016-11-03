<cfset dateRange = DateDiff("d", data.getFromDate(), data.getToDate()) ? "#DateFormat(data.getFromDate(), "m/d/yy")# - #DateFormat(data.getToDate(), "m/d/yy")#" : "today" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sick Leave Notice</title>
</head>
<body>
    <cfoutput>
        <div>
			<p>Dear colleagues,</p>
			<p>Please note that #data.getUser().getFirstName()# #data.getUser().getLastName()# will be on sick leave #dateRange#. Fill-in will be #data.getDeputy().getFirstName()# #data.getDeputy().getLastName()#.</p>
			<br>
			<br>
			<br>
			This message is automatically sent by the Vacation Module.
		</div>
    </cfoutput> 
</body>
</html>
