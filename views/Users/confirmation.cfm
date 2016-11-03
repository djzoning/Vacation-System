<cfoutput>
	<cfdump var="#html.button#" />

	<p>
		You have pending deputy request from
		<strong>
			#prc.vacation.getUser().getFirstName()# 
			#prc.vacation.getUser().getLastName()#
		</strong>. 
		From #prc.vacation.getFromDate()# to #prc.vacation.getToDate()#.
		Please approve or reject this request until "some date".
	</p>
	<div class="panel panel-default">
	    <div class="panel-heading">
	        <h4 class="panel-title">
	            <a class="accordion-toggle accordion-toggle-styled" data-toggle="collapse" data-parent="##accordion1" href="##accordion1_1">Description</a>
	        </h4>
	    </d
	    <div id="accordion1_1" class="panel-collapse collapse in">
	        <div class="panel-body">#prc.vacation.getDescription()#</div>
	    </div>
	</div>

	<div class="row">
		<a href="#event.buildLink('Users.reject')#" class="btn btn-danger">Reject</a>
		<a href="#event.buildLink('Users.approve')#" class="btn btn-success">Approve</a>
	</div>

</cfoutput>