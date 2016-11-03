<cfoutput>
	<h1>LogID-#prc.log.getId()# (#dateTimeFormat(prc.log.getTimeStamp(), 'dd-mm-yyyy HH:nn:ss')#)</h1>
	<h4>URL:</h4>
	#prc.log.getHtmlBaseUrl()##prc.log.getHandler()#/#prc.log.getAction()# (Method: #prc.log.getHttpMethod()#)
	<h4>User:</h4>
	<cfif NOT isNull(prc.Log.getUser())>
		#prc.Log.getUser().getFirstName()# #prc.Log.getUser().getLastName()#
	<cfelse>
		Guest	
	</cfif>

	<cfif prc.log.getEntityName() EQ "LogError">
		<h4>Exception:</h4>
		<cfdump var="#deserializeJson(prc.log.getException())#" />
	</cfif>

	<h4>RC:</h4>
	<cfdump var="#deserializeJson(prc.log.getRc())#" />
</cfoutput>