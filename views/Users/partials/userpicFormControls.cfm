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

<cfoutput>
    <div class="user-image-container row" id="uic">
        <div class="col-lg-12">
            <div class="modal-userpic-loader">Loading...</div>
            <img class="userpic-preview" width="400" src="/Users/getImage?image=#prc.image#">
        </div>
    </div>
    <div class="form-group">
        #html.inputField(
            label="Picture",
            type="file", 
            name="#prc.fileField#",
            class="form-control user-picture-upload"
        )#
    </div>
    <div>
        #html.inputField(
            type="hidden",
            name="x",
            id="x"
        )#
        #html.inputField(
            type="hidden",
            name="y",
            id="y"
        )#
        #html.inputField(
            type="hidden",
            name="width",
            id="width"
        )#
        #html.inputField(
            type="hidden",
            name="height",
            id="height"
        )#
    </div>
</cfoutput>
