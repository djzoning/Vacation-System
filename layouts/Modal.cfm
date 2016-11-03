<cfoutput>
	<div class="modal-header caption">
        <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
        <h4 class="modal-title caption-subject font-green-sharp bold">#prc.title#</h4>
    </div>
   	<div id="alerts-container"></div>

	#getModel( "messagebox@cbmessagebox" ).renderit()#

    #html.startForm(
        action="#prc.action#", 
        method="post", 
        class="#prc.formClass#",
        multipart="true"
    )#
    <cfif "Users.editUser" == prc.action OR "Users.changeImage" == prc.action OR "Users.createUser" == prc.action>
	    #html.hiddenField(name="id", value="#prc.id#")#
    </cfif>
	    <div class="modal-body">
	    	<cfif NOT structKeyExists(prc,"objectAction")>
		    	<cfset prc.objectAction = event.getCurrentAction()>
	    	</cfif>
			<input type="hidden" name="objectAction" value="#prc.objectAction#" placeholder="">	

	    	<cfif NOT structKeyExists(prc,"objectName")>
		    	<cfset prc.objectName = event.getCurrentHandler()>
	    	</cfif>
	    	<input type="hidden" name="objectName" value="#prc.objectName#" placeholder="">
	        
			#renderView()#
	    </div>
	    <div class="modal-footer">
	    	<button type="button" data-dismiss="modal" class="btn grey-cascade">Cancel</button>
	    	<button type="submit" class="btn green">Save</button>
		</div>
	#html.endForm()#  
	
	     
</cfoutput>
