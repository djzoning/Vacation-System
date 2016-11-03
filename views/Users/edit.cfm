<cfoutput>
    <style>
        .user-image-container > div {
            display: flex;
            justify-content: center;
        }

        .user-image-container > div img {
            max-width: 300px;
            max-height: 300px;
            width: auto;
            height: auto;
        }
    </style>

    <div class="form-group">
        #html.textField(label="Username:",name="username",class="form-control", value=prc.username, readonly=true)#
    </div>
    <div class="form-group">
        <!--- #html.hiddenField(name="id", value="#prc.id#")# --->
    </div>
    <div class="form-group">
        #html.emailField(label="Your Email:",name="email",class="form-control", value=prc.email, required="required")#
    </div>
    <div class="form-group">
        #html.textField(label="First Name:",name="firstName",class="form-control", value=prc.firstName, required="required", minlength="2", maxlength="20")#
    </div>
    <div class="form-group">
        #html.textField(label="Last Name:",name="lastName",class="form-control", value=prc.lastName, required="required", minlength="2", maxlength="20")#
    </div>
    <div class="form-group">
        #html.select(
            selectedValue = #prc.teamId#,
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
            selectedValue = #prc.roleId#,
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
        #html.inputField(
            label="Vacation days",
            type="number",
            name="vacDays",
            class="form-control", 
            value=#prc.vacDays#,
            min=0,
            max=20
        )#
    </div>
    <div class="form-group">
        #html.button(
            value="Change Password", 
            class="btn btn-default show-password-inputs"
        )#
    </div>
    <div class="form-group change-password" style="display: none">
        #html.passwordField(
            label="New Password",
            name="passwordNew",
            class="form-control"
        )#
        #html.passwordField(
            label="Password Confirmation",
            name="passwordConfirm",
            class="form-control"
        )#
    </div>
    
    <cfinclude template="partials/userpicFormControls.cfm" />
</cfoutput>
