<cfoutput>
	<cfloop array="#prc.requests#" index="vacation">
        <cfset prc.rightsToApprove = prc.UserModel.getSessionUserRightsToApprove(vacation)>
        <div class="mt-action">
            <div class="mt-action-img">
                <img src="/users/getImage?image=#vacation.getUser().getImage()#"> 
            </div>
            <div class="mt-action-body">
                <div class="mt-action-row">
                    <div class="mt-action-info">
                        <div class="mt-action-icon">
                        	<cfset colorClass = "">
                        	<cfif prc.rightsToApprove NEQ "Fill-in">
	                        	<cfset colorClass = "color-red">
                        	</cfif>

                            <i class="icon-bell #colorClass#"></i>
                        </div>
                        <div class="mt-action-details ">
                            <span class="mt-action-author">#vacation.getId()# #vacation.getUser().getFirstName()# #vacation.getUser().getLastName()#</span>
                            <cfif trim(prc.rightsToApprove) NEQ "">
                                <p class="mt-action-desc">#prc.rightsToApprove# Approval Request</p>
                            </cfif>
                        </div>
                    </div>
                    <div class="mt-action-datetime">
                        <span class="mt-action-date">#dateFormat(vacation.getFromDate())#</span>
                        <span class="mt-action-dot bg-green"></span>
                        <span class="mt-action-date">#dateFormat(vacation.getToDate())#</span>
                    </div>
                    
                    <cfif prc.tabType EQ "pending">
	                    <div class="mt-action-buttons">
                            <cfset btnGroupClass = "">
                            <cfif 
                                prc.rightsToApprove NEQ "Manager" OR 
                                (
                                    prc.rightsToApprove EQ "Manager" AND 
                                    (
                                        vacation.getUser().getRole().getName() EQ "Team Lead" OR
                                        vacation.getUser().getRole().getName() EQ "Manager"
                                    ) AND 
                                    vacation.getStatus().getName() EQ "Fill-in Approved"
                                )
                            >
                                <cfset btnGroupClass = "btn-group-circle">
                            </cfif>

                            <div class="btn-group #btnGroupClass#">
                                <cfset circleBtn = "btn-circle">

                                <cfif 
                                    prc.rightsToApprove NEQ "Manager" OR 
                                    (
                                        prc.rightsToApprove EQ "Manager" AND 
                                        (
                                            vacation.getUser().getRole().getName() EQ "Team Lead" OR
                                            vacation.getUser().getRole().getName() EQ "Manager"
                                        ) AND 
                                        vacation.getStatus().getName() EQ "Fill-in Approved"
                                    )
                                >
                                    <cfset circleBtn = "">    
                                    <form class="btn btn-outline green btn-sm" action="/Users/mailingPrepare" method="post">
                                        <input type="hidden" name="objectAction" value="#prc.rightsToApprove# Approved" placeholder="">
                                        <input type="hidden" name="objectName" value="Vacation">

                                        <input type = "hidden" name = "responsible" id="responsible" value="#prc.rightsToApprove#">
                                        <input type = "hidden" name = "action" id="action" value="Approved">
                                        <input type = "hidden" name = "vacationId" id="vacationId" value="#vacation.getId()#">
                                        <button type="button" class="btn-invisible quick-action-btn" data-action="Approved">Approve</button>
                                    </form>
                                </cfif>

                                <form class="btn btn-outline #circleBtn# red btn-sm" action="/Users/mailingPrepare" method="post">
                                    <input type="hidden" name="objectAction" value="#prc.rightsToApprove# Rejected">
                                    <input type="hidden" name="objectName" value="Vacation">
                                    <input type = "hidden" name = "responsible" id="responsible" value="#prc.rightsToApprove#">
                                    <input type = "hidden" name = "action" id="action" value="Rejected">
                                    <input type = "hidden" name = "vacationId" id="vacationId" value="#vacation.getId()#">
                                    <button type="button" class="btn-invisible quick-action-reject-btn" data-toggle="modal" data-target="##responsive" data-action="Rejected">Reject</button>
                                </form>
                            </div>
	                    </div>
	                <cfelse>
						<div class="mt-action-buttons">
                            <cfset userActions = prc.logAction.getByObjectIdAndUserId(vacation.getId(), SESSION.user.id)>
                            <cfif arrayLen(userActions) NEQ 0>
                                <cfset badgeType = "success">
                                <cfset userAction = rEFind("approved", lcase(userActions[1].getObjectAction())) ? "Approved" : "Rejected">
                                <cfif lcase(userAction) EQ "rejected">
                                    <cfset badgeType = "danger">
                                </cfif>
                                <span class="badge badge-#badgeType#">#userAction#</span>
                            </cfif>
	                    </div>
                    </cfif>
                </div>
            </div>
        </div>
    </cfloop>
</cfoutput>