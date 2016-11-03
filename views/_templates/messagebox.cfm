<cfscript>
    switch( msgStruct.type ){
        case "info" : {
            local.cssType = " alert-success";
            local.iconType = "fa-thumbs-up";
            break;
        }   
        case "error" : {
            local.cssType = " alert-danger";
            local.iconType = "fa-exclamation-triangle";
            break;
        }   
        default : {
            local.cssType = "alert-info";
            local.iconType = "fa-info-circle";
        }
    }
</cfscript>

<cfoutput>
	<div class="alert #local.cssType# alert-dismissable">
	    <button type="button" class="close" data-dismiss="alert" aria-hidden="true"></button>
	    <i class="fa #local.iconType# fa-3" aria-hidden="true"></i> 
	    <strong>#msgStruct.message#</strong>
	</div>
</cfoutput>