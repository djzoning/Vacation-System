<cfoutput>
    <div class="form-group">
        #html.textField(
            label="Username",
            name="username",
            class="form-control", 
            required="required"
        )#
    </div>
    <div class="form-group">
        #html.emailField(
            label="E-mail",
            name="email",
            class="form-control", 
            required="required"
        )#
    </div>
    <div class="form-group">
        #html.textField(
            label="First Name",
            name="firstName",
            class="form-control", 
            required="required"
        )#
    </div>
    <div class="form-group">
        #html.textField(
            label="Last Name",
            name="lastName",
            class="form-control", 
            required="required"
        )#
    </div>
    <div class="form-group">
        #html.select(
            options = #prc.team#,
            column = "Id",
            nameColumn = "Name",
            name="teamId",
            label="Team",
            required="required",
            class="form-control select2"
        )#
    </div>
    <div class="form-group">
        #html.select(
            options = #prc.roles#,
            column = "Id",
            nameColumn = "Name",
            name="roleId",
            label="Role",
            required="required",
            class="form-control select2"
        )#
    </div>
    <div class="form-group">
        #html.passwordField(
            label="Password",
            name="password",
            class="form-control"
        )#
    </div>
    <div class="form-group">
        #html.passwordField(
            label="Password Confirmation",
            name="passwordConfirm",
            class="form-control"
        )#
    </div>
    <div class="form-group">
        #html.inputField(
            label="Vacation days",
            type="number", 
            name="vacDays",
            class="form-control", 
            value=20
        )#
    </div>
    <cfinclude template="partials/userpicFormControls.cfm" />
</cfoutput>