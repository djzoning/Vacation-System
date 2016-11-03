<cffunction name="displayDateDiff">
	<cfargument name="date">
	
	<cfset years = dateDiff('yyyy', date, now())>
	<cfif years GT 0>
		<cfset result = years & " years">
		<cfif years EQ 1>
			<cfset result = years & " year">
		</cfif>

		<cfreturn result>
	</cfif>

	<cfset months = dateDiff('m', date, now())>
	<cfif months GT 0>
		<cfset result = months & " months">
		<cfif months EQ 1>
			<cfset result = months & " month">
		</cfif>

		<cfreturn result>
	</cfif>

	<cfset days = dateDiff('d', date, now())>
	<cfif days GT 0>
		<cfset result = days & " days">
		<cfif days EQ 1>
			<cfset result = days & " day">
		</cfif>

		<cfreturn result>
	</cfif>

	<cfset hours = dateDiff('h', date, now())>
	<cfif hours GT 0>
		<cfset result = hours & " hours">
		<cfif hours EQ 1>
			<cfset result = hours & " hour">
		</cfif>

		<cfreturn result>
	</cfif>

	<cfset minutes = dateDiff('n', date, now())>
	<cfif minutes GT 0>
		<cfset result = minutes & " mins">
		<cfif minutes EQ 1>
			<cfset result = minutes & " min">
		</cfif>
		
		<cfreturn result>
	</cfif>

	<cfset result = "Just now">
	<cfreturn result>
</cffunction>

<cffunction name="includeLink">
	<cfargument name="href" type="string" default="" />
	<cfargument name="target" type="string" default="_self" />
	<cfargument name="name" type="string" default="" />
	<cfargument name="isModal" type="boolean" default="false" />

	<cfargument name="id" type="string" default="" />
	<cfargument name="icon" type="string" default="" />
	<cfargument name="title" type="string" default="" />
	<cfargument name="class" type="string" default="" />
	<cfargument name="btnClass" type="string" default="btn btn-primary" />
	<cfargument name="confirm" type="string" default="" />
	<cfargument name="onlyAdmin" type="boolean" default="false" />
	<cfargument name="postJSON" type="string" default="" />	
	
	<cfscript>
	   	/*if(SESSION.user.isAdmin && ARGUMENTS.onlyAdmin) {
	   		return;
		}*/
		
   		var modalClass = ARGUMENTS.isModal ? "ajax-modal-btn" : "";
	   	var dataAttributes = ARGUMENTS.isModal ? "data-target = '##responsive'" : '';
   		ARGUMENTS.title = ARGUMENTS.title != "" ? ARGUMENTS.title : ARGUMENTS.name;
	</cfscript>
	
	<cfoutput>
		<a 
			id = "#ARGUMENTS.id#" 
			class = "#ARGUMENTS.btnClass# #ARGUMENTS.class# #modalClass#"
			href = "#event.buildLink(#ARGUMENTS.href#)#"
			title = "#ARGUMENTS.title#" 
			target = "#ARGUMENTS.target#"
			rel = "tooltip" 
			#dataAttributes#
		>
			<cfif ARGUMENTS.icon NEQ "">
				<i class="#ARGUMENTS.icon#"> </i>
			</cfif>
			#ARGUMENTS.name#
		</a>
	</cfoutput>
</cffunction>