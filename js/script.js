(function() {
    String.prototype.ucfirst = function() {
        return this.charAt(0).toUpperCase() + this.slice(1);
    }

    if (typeof vacations === 'undefined' || !Array.isArray(vacations)) {
        return;
    }

    var $element = $('#calendar');
    var url = 'calendar/get';
    var options = {
        vacations: vacations,
        $element: $element,
        // url: url
    }

    var calendar = new Calendar(options);
    calendar.draw();
})();

$(document).ready(function() {
    REJECTED_MESSAGE = " Please be aware that this vacation probably will be rejected!";
    UNPAID_MESSAGE = " The rest will be saved as Unpaid vacation.";

    activeNavigation();
    dashboardVacationsTabs();
    buildNotifications("alerts-container-view");
    setupUserpicLoader();
});

function checkFiles() {
    var allowedTypes = ['jpeg', 'jpg', 'png'];
    $('.user-picture-upload').change(function() {
        console.log('pesho');
        var file = $(this)[0].files[0];
        var ext = file.name.split('.').pop().toLowerCase();
        var $_this = $(this);
        if ($.inArray(ext, allowedTypes) == -1) {
            toastr.warning("The file extention is not allowed.\nThe allowed types are: jpeg, jpg, png!");         
            var $newControl = $_this.clone(true);
            $_this.parent().append($newControl);
            $_this.remove();
        } else {
            readUrl(this);
        }
    });
}

function readUrl(input) {
    if (input.files && input.files[0]) {
        var reader = new FileReader();
        
        reader.onload = function (e) {
            var $userpic = $('.userpic-preview');
            $userpic.attr('src', e.target.result);
            var x = $userpic.width() / 10;
            var y = $userpic.height() / 10;
            var width = $userpic.width() - x;
            var height = $userpic.height() - y;

            if (typeof jcrop != 'undefined') {
                jcrop.destroy();
            }

            jcrop = $.Jcrop('.userpic-preview', {
                onSelect: updateCoordinates,
                bgOpacity: .4,
                setSelect: [x, y, width, height],
                aspectRatio: 1
            });
        }
        
        reader.readAsDataURL(input.files[0]);
    }
}

function updateCoordinates(coordinates) {
    $('#x').val(coordinates.x);
    $('#y').val(coordinates.y);
    $('#width').val(coordinates.w);
    $('#height').val(coordinates.h);
}

function setupUserpicLoader() {
    $('.profile-userpic img').load(function() {
        $('.userpic-loader').hide();
    });
}

function setupModalUserpicLoader() {
    $('.user-image-container img').load(function() {
        $('.modal-userpic-loader').hide();
    });
}

// get the current handler and action, with regex and add a class 'active' to the proper li item
function activeNavigation() {
    var locationUrl = window.location.href;
    var handlerAndAction = locationUrl
        .replace(/(.*\/\/vacation.+?\/)(index.cfm\/)?/i, '')
        .replace(/\?.+/, '')
        .split('/');
    var currentHandler = handlerAndAction[0].toLowerCase();
    var currentAction = handlerAndAction[1] || 'index';
    var currentObjectId = handlerAndAction[2];

    $('[data-handler="' + currentHandler + '"]').addClass('active');

    // breadcrumbs
    buildBradcrumbs(currentHandler, currentAction, currentObjectId);
}

function buildBradcrumbs(currentHandler, currentAction, currentObjectId) {
    var $breadcrumbs = $('.page-breadcrumb');
    var homeItem = '<li>' +
                        '<i class="icon-home"></i>' +
                            '<a href="/">Home</a>' +
                        '<i class="fa fa-angle-right"></i>' +
                    '</li>';

    var handlerText = $('[data-handler="' + currentHandler + '"] span.title').text();
    currentHandler = currentHandler.ucfirst();
    currentAction = currentAction.ucfirst();

    var liItems = homeItem;
    var handlerLi = '<li><a href="/' + currentHandler + '">' + handlerText + '</a>';
    var actionLi = '';
    var href = '';

    if(currentObjectId) {
        href = '/' + currentHandler + '/' + currentAction + '/' + currentObjectId;
        actionLi = '<li><a href="' + href + '">' + currentAction + '</a></li>';
    } 
    else if(currentAction && (currentAction.toLowerCase() !== 'index' && currentAction.toLowerCase() !== 'list')) {
        href = '/' + currentHandler + '/' + currentAction;
        actionLi = '<li><a href="' + href + '">' + currentAction + '</a></li>';
    }

    if(actionLi !== '') {
        handlerLi += '<i id="handler-i" class="fa fa-angle-right"></i>';
    }

    handlerLi += '</li>';

    liItems += handlerLi;
    liItems += actionLi;
    $breadcrumbs.html(liItems);
}

function dashboardVacationsTabs() {
    if($('#dashboard-vacations').length === 0) {
        return;
    }
    
    $('input[name="options"]').on('change', function(){
        var vacationsFilter = $(this).val();
        var loader = '<div class="loader"></div>';
        $('#dashboard-vacations').html(loader);
        
        $.get('/dashboard/vacations?tableOnly=true&filter=' + vacationsFilter, function(tableBody) {
            $('#dashboard-vacations').html(tableBody);
        });
    });
}

$('.ajax-modal-btn').on('click', function(event) {
    event.preventDefault();
    var $this = $(this);
    var $modal = $('#responsive');
    $('body').modalmanager('loading');
    $modal.load($this.attr('href'), function() {
        $modal.modal('show');
        initDateRangePicker();
        initSelect2();
        showPasswordInputs();
        validateVacation();
        buildNotifications("alerts-container-edit");
        validateVacationTypes();
        checkFiles();
        setupModalUserpicLoader();
        UserValidator.validate();
    });
});

function initDateRangePicker() {
    $("input[name='fromToDate']").daterangepicker({
        "locale": {
            "applyLabel": "Confirm selection",
            "firstDay": 1
        }
    });

    $("input[name='fromToDate']").on('apply.daterangepicker', function(ev, picker) {
        var startDate = new Date(picker.startDate.format('MM/DD/YYYY'));
        var endDate = new Date(picker.endDate.format('MM/DD/YYYY'));
        var teamId = $("#teamId").val();

        var count = 0;
        var currentDate = startDate;
        
        while (currentDate <= endDate) {
            var dayOfWeek = currentDate.getDay();
            var isWeekend = (dayOfWeek == 6) || (dayOfWeek == 0);
            
            if (!isWeekend) {
                count++;
            }
   
            currentDate = new Date(currentDate.setDate(currentDate.getDate() + 1));
        }
        
        $('input[name="length"]').val(count);
        $('input[name="length"]').trigger('change');
         
        checkTeamUsersInVacation(startDate, endDate, teamId);
    });

    $('input[name="fromToDate"]').on('cancel.daterangepicker', function(ev, picker) {
        $(this).val('');
    });
}

function initSelect2() {
    $.fn.select2.defaults.set("theme", "bootstrap");

    var placeholder = "Please, select an option";
    
    $(".select2").select2({
        placeholder: placeholder
    });
}

function showPasswordInputs() {
    $('.show-password-inputs').click(function() {
        if ($('.change-password').is(":visible")) {
            $('.change-password').fadeOut('slow', function() {});
        } else {
            $('.change-password').fadeIn('slow', function() {});
        }
    });
}

function validateVacation() {    
    $('.vacation select[name="typeId"]').on('change', function() {
        var userAvailableDays = parseInt($("#availableDays").val());
        var length = parseInt($("#length").val());
        var maxAllowedPaid = parseInt($("#maxAllowedPaid").val());
        var type = $('.vacation select[name="typeId"]').find(":selected").html();

        $.get("VacationTypes.checkMaxLength", {
            typeId: $(this).val()
        }, function(data) {
            var result = $.parseJSON(data);
            
            var hasMaxAllowedPaidNotification = checkMaxAllowedPaidNotification(type, length, maxAllowedPaid);

            if (result != 0 && length >= result) {
                var typeMessage = buildTypeMessage(result);

                showAlert(REJECTED_MESSAGE, "danger", "rejectedAlert");
                showAlert(typeMessage, "warning", "typeAlert");
            } else if (type == "Paid" && length > userAvailableDays) {
                showAlert(REJECTED_MESSAGE, "danger", "rejectedAlert");
                // showAlert(UNPAID_MESSAGE, "warning", "unpaidAlert");
            } else {
                $(".typeAlert .close").trigger('click');
                
                if ($(".close").length == 3 && !hasMaxAllowedPaidNotification) {
                    $(".rejectedAlert .close").trigger('click');
                } 
            }
            
            $("#daysLimit").val(result);
            closeAlerts();
        });
    });

    $('.vacation input[name="length"]').on('change', function() {
        var daysLimitByType = parseInt($("#daysLimit").val());
        var type = $("select[name='typeId']").find(":selected").html(); 
        var userAvailableDays = parseInt($("#availableDays").val());
        var maxAllowedPaid = parseInt($("#maxAllowedPaid").val());
        var length = parseInt($("#length").val());
        var hasMaxAllowedPaidNotification = checkMaxAllowedPaidNotification(type, length, maxAllowedPaid);
        
        if (daysLimitByType != 0 && length >= daysLimitByType) {
            var typeMessage = buildTypeMessage(daysLimitByType);
            
            showAlert(REJECTED_MESSAGE, "danger", "rejectedAlert");
            showAlert(typeMessage, "warning", "typeAlert");
        } else {
            $(".typeAlert .close").trigger('click');        
        }
        
        if (length >= userAvailableDays) {
            var availableDaysMessage = buildAvailableDaysMessage(userAvailableDays);
            showAlert(availableDaysMessage, "warning", "lengthAlert");
            
            if ((length - userAvailableDays) != 0 && type == "Paid") {
                // showAlert(UNPAID_MESSAGE, "warning", "unpaidAlert");
                showAlert(REJECTED_MESSAGE, "danger", "rejectedAlert");
            }
        } else {
            $(".lengthAlert .close").trigger('click');
        }

        closeAlerts();
    });
}

function checkTeamUsersInVacation(startDate, endDate, teamId) {
    $.get("Vacations.checkTeamUsersInVacation", {
        startDate: startDate,
        endDate: endDate,
        teamId: teamId
    }, function(data) {
        var result = $.parseJSON(data);

        if (result.MAXALLOWEDUSERS <= result.VACATIONSCOUNT) {
            var teamMessage = buildTeamMessage(result.VACATIONSCOUNT);

            showAlert(REJECTED_MESSAGE, "danger", "rejectedAlert");
            showAlert(teamMessage, "warning", "teamAlert");
        } else {
            $(".teamAlert .close").trigger('click');
        }
    });

    closeAlerts();
}

function checkMaxAllowedPaidNotification(type, length, maxAllowedPaid) {
    var result = false;

    if (type == "Paid" && length > maxAllowedPaid) {
        var limitMessage = buildLimitMessage(maxAllowedPaid);

        showAlert(REJECTED_MESSAGE, "danger", "rejectedAlert");
        showAlert(limitMessage, "warning", "limitAlert");
        result = true;
    } else {
        $(".limitAlert .close").trigger('click');
        closeAlerts();
    } 

    return result;
}

function closeAlerts() {
    var elements = $("#alerts-container-edit").length ? $("#alerts-container-edit").children() : $("#alerts-container").children();
    var childrenCount = elements.length; 
    
    if (childrenCount == 1) {
        $(".rejectedAlert .close").trigger('click');
    } 
}

function buildTypeMessage(days) {
   return " Max amount of days for this vacation type is " + days + "!";
}

function buildLimitMessage(limit) {
    return " Max allowed length for this vacation type is " + limit + " days!";
}

function buildAvailableDaysMessage(days) {
    return " Available paid vacation is " + days + " days! ";
}

function buildTeamMessage(count) {
    return " There are already " + count + " people from your team in vacation in this period!";
}

function showAlert(message, type, additionalClass, closeDelay) {
    // default to info; other - success, warning, danger
    type = type || "info";
    var icon = "";
    var element = $("#alerts-container").length ? $("#alerts-container") : $("#alerts-container-edit")

    switch (type) {
        case "info":
            icon = '<i class = "fa fa-info"></i>';
            break;
        case "success":
            icon = '<i class = "fa fa-check-square-o"></i>';
            break;
        case "warning":
            icon = '<i class = "fa fa-warning"></i>';
            break;
        case "danger":
            icon = '<i class = "fa fa-close"></i>';
            break;
    } 
    
    if (!$("." + additionalClass + "").length) {
        var alert = $('<div class = "alert alert-' + type + ' fade in ' + additionalClass + '">')
            .append(icon)
            .append(
                $('<button type = "button" class = "close" data-dismiss = "alert">')
                .append("&times;")
            ).append(message);

        if (additionalClass == "rejectedAlert") {
            element.prepend(alert);
        } else {
            element.append(alert);
        }
        
        if (closeDelay) {
            window.setTimeout(function() { alert.alert("close") }, closeDelay);
        }
    }   
}

function validateVacationTypes (){
    $('.createType input[name = "name"]').on('change', function(){
       var typeForCheck = $(this).val();
       $.get(
            "VacationTypes/getTypesByName",
            {typename: typeForCheck},
            function(data) {
                if (parseInt(data) !== 0) {
                    var message = 'The type already exists!';
                    var alert = $('<div class = "alert alert-warning fade in">')
                        .append(
                            $('<button type = "button" class = "close" data-dismiss = "alert">')
                            .append("&times;")
                        ).append(message);
                    $('#alerts-container').prepend(alert);
                } else {
                    $('#alerts-container').empty();
                }
            }
        ).fail(function() {
            alert('woops'); // or whatever
        });
    });
}

function buildNotifications(element) {
    if ($("#" + element + "").length && 
            (   
                $("#teamUsersAlert").val() != 0 
                || $("#vacationTypeLengthAlert").val() != 0 
                || $("#vacationLengthAlert").val() != 0
                || $("#maxAllowedPaidAlert").val() != 0
            )
        ) 
    {
        var type = "danger";
        var message = REJECTED_MESSAGE;
        var icon = "close";

        showNotification(element, message, type, 0, icon);
    }

    if ($("#maxAllowedPaidAlert").val() != 0) {
        var count = $("#maxAllowedPaidAlert").val();
        var type = "warning";
        var message = buildLimitMessage(count);
        var icon = "warning";

        showNotification(element, message, type, 0, icon);
    }

    if ($("#teamUsersAlert").val() != 0) {
        var count = $("#teamUsersAlert").val();
        var type = "warning";
        var message = buildTeamMessage(count);
        var icon = "warning";

        showNotification(element, message, type, 0, icon);
    }

    if ($("#vacationTypeLengthAlert").val() != 0) {
        var limit = $("#vacationTypeLengthAlert").val();
        var type = "warning";
        var message = buildTypeMessage(limit);
        var icon = "warning";

        showNotification(element, message, type, 0, icon);
    }

    if ($("#vacationLengthAlert").val() != 0) {
        var days = $("#vacationLengthAlert").val();
        var type = "warning";
        var message = buildAvailableDaysMessage(days);
        var icon = "warning";

        showNotification(element, message, type, 0, icon);
    }
}

function showNotification(element, message, type, closeInSeconds, icon) {
    if (typeof message != "undefined") {
        App.alert({
            container: $("#" + element + ""), // alerts parent container(by default placed after the page breadcrumbs)
            place: "append", // append or prepent in container 
            type: type,  // alert's type
            message: message,  // alert's message
            close: 1, // make alert closable
            reset: 0, // close all previouse alerts first
            focus: 1, // auto scroll to the alert after shown
            closeInSeconds: closeInSeconds, // auto close after defined seconds
            icon: icon // put icon before the message
        });
    }
}

$('.quick-action-btn').on('click', submitUserQuickAction);

function submitUserQuickAction() {
    var $form = $(this).parent();
    var formData = $form.serializeArray();
    var $theRow = $(this).closest('.mt-action');
    var action = $(this).attr('data-action');
    var badge = 'success';

    if(action !== 'Approved') {
        badge = 'danger';
        formData.push({name: "rejectedMessage", value: $('#rejectedMessage').val()});
    }
    
    setOverlay($('#dashboard-quick-actions'));
    
    $.ajax({
        url: $form.attr('action'),
        type: 'POST',
        data: formData,
    })
    .done(function(data) {
        toastr.success('You have successfully ' + action + ' the vacation.', 'Vacation ' + action, {timeOut: 3000});

        var status = '<span class="badge badge-' + badge + '">' + action + '</span>';

        $theRow
            .remove()
            .find('.mt-action-buttons')
            .html(status);

        $('#tab_actions_completed .mt-actions').prepend($theRow);
        reloadMessInboxBar();
    })
    .fail(function() {
        toastr.error('We are fixing it! Please come back in a while.', 'Oops! Something went wrong.', {timeOut: 2500});
    })
    .always(function() {
        $('#overlay').remove();
        $('#dashboard-quick-actions').attr('style', '');
    });
}

$('.quick-action-reject-btn').on('click', function () {
    var self = this;
    var modalHtml = '<div class="modal-header caption"><button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button><h4 class="modal-title caption-subject font-green-sharp bold">Message</h4></div><div class="modal-body"><label></label><textarea name="rejectedMessage" rows="5" id="rejectedMessage" class="form-control"></textarea></div><div class="modal-footer"><button type="button" data-dismiss="modal" class="btn grey-cascade">Cancel</button><button type="button" class="btn green quick-action-btn" data-action="reject">Save</button></div>';

    $('.modal-content')
        .html(modalHtml)
        .find('.quick-action-btn')
        .on('click', function () {
            $('.close[data-dismiss="modal"]').trigger('click');
            submitUserQuickAction.call(self);
            // $('.modal-content').html('');
        });
});

function setOverlay($parent) {
    var $loader = '<div class="loader"></div>';
    var $overlay = $('<div id="overlay">')
        .css({
            backgroundColor: 'white',
            position: 'absolute',
            height: '100%',
            top: '0',
            zIndex: '5',
            width: '100%'
        })
        .append($loader);
    
    $parent
        .css({
            position: 'relative',
            minHeight: '15em'
        })
        .append($overlay);
}

function reloadMessInboxBar() {
    $.ajax({
        url: '/main/inboxDropdown',
        type: 'GET'
    })
    .done(function(html) {
        var menuInnerHtml = $(html).find('.dropdown-menu');
        var numberOfNotifications = $(menuInnerHtml).find('.dropdown-menu-list li').length;

        $('#header_inbox_bar .badge').text(numberOfNotifications);
        $('.dropdown.dropdown-user .badge.badge-danger').text(numberOfNotifications);

        if(numberOfNotifications === 0) {
            $('#header_inbox_bar .badge').hide();
            $('.dropdown.dropdown-user .badge.badge-danger').hide();

            $('#header_inbox_bar .icon-envelope-open')
                .removeClass('icon-envelope-open')
                .addClass('icon-envelope');
        }
        
        $('#header_inbox_bar .dropdown-menu').replaceWith(menuInnerHtml);
    });
}
