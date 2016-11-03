<cfoutput>
	#getModel( "messagebox@cbmessagebox" ).renderit()#

	#html.startForm(
		action="Security.loginUser", 
		method="post", 
		class="login-form"
	)#

	#html.hiddenField(
		name="_securedURL",
		value=event.getValue('_securedURL','')
	)#

	<h3 class="form-title font-green">Sign In</h3>
	
	<div class="form-group">
		#html.textField(
				name="username", 
				class="form-control form-control-solid placeholder-no-fix", 
				placeholder="Username", 
				label="Username",
				labelClass="control-label visible-ie8 visible-ie9",
				required="required"
		)#
    </div>
    <div class="form-group">
		#html.passwordField(
			name="password", 
			class="form-control form-control-solid placeholder-no-fix",
			placeholder="Password", 
			label="Password",
			labelClass="control-label visible-ie8 visible-ie9", 
			required="required"
		)#
    </div>
    
	<div class="form-actions">
		#html.submitButton(
			name="Login", 
			value="Login", 
			class="btn green uppercase"
		)#
        <label class="rememberme check mt-checkbox mt-checkbox-outline">
        	#html.checkbox(
        		name="remember",
        		value="1"
        	)#
        	Remember
            <span></span>
        </label>

        <a href="##" class="forget-password" id="forget-password">Forgot Password?</a>
    </div>
	#html.endForm()#

	#html.startForm(
		action="Security.resetPassword", 
		method="post", 
		class="forget-form",
		novalidate="novalidate"
	)#

		#html.hiddenField(
			name="_securedURL",
			value=event.getValue('_securedURL','')
		)#

		<h3 class="font-green">Forget Password ?</h3>
        <p> Enter your e-mail address below to reset your password. </p>
		
		<div class="form-group">
	        #html.emailField(
	        	name="email",
	        	class="form-control", 
	        	required="required"
	        )#
	    </div>
	    <div class="form-actions">
			#html.submitButton(
				name="Login", 
				value="Submit", 
				class="btn btn-success uppercase pull-right"
			)#

			#html.button(
				id="back-btn",
				name="Back", 
				value="Back", 
				class="btn green btn-outline"
			)#
	    </div>
	#html.endForm()#
</cfoutput>