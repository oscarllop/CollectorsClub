app.controller('switcher_index', function ($scope, $sce, $attrs, $http, $routeParams, CommonSvc, $timeout) {

    var common = CommonSvc.getData($scope);

    $scope.showGoogleMapKey = function () {
        return $scope.ui.data.ShortCodes.Value.indexOf("google maps") > -1 ? true : false;
    };

    $scope.onInit = function () {
        var dm = "<div class=\"options-links help-cont\"><a href = \"https://www.youtube.com/watch?v=854tCJkGxB8\" target=\"_blank\" class=\"style-switcher-help\"><img src=\"http://porto.mandeeps.com/Portals/22/img/switcher.jpg\" /></a><hr /><p>[L:DemoMessage]<span>[L:ImpDemoMsg]</span></p><p>[L:DemoMsg]</p></div>";
        if ($scope.ui.data.IsSuperUser.Value != "False")
            dm = "";
        $scope.demo_markup = $sce.trustAsHtml(dm);
        $scope.show_pc = true;

        if ($('.personalBarContainer').length > 0) {
            $('.StyleSwitcher').addClass('DNN9');
        }

        $('#getCSSModal').on('hidden.bs.modal', function () {
            jQuery("#themeAlert").hide();
        });

        $scope.ui.origStyleData = angular.copy($scope.ui.data);
        $scope.ui.hasStyleDataChanged = !angular.equals($scope.ui.data, $scope.ui.origStyleData);
        $scope.$watch('ui.data', debounceChange, true);

        if ($scope.ui.data.IsSuperUser.Value == "False") {

            // Header
            $scope.$watch('ui.data.Header.Value', debounceHeader, true);

            // Website Type
            $scope.$watch('ui.data.WebsiteType.Value', debounceWebsitetype, true);

            // Background Color
            $scope.$watch('ui.data.BackgroundColor.Value', debounceBackgroundColor, true);

            //Layout Style
            $scope.$watch('ui.data.LayoutStyle.Value', debounceLayoutStyle, true);

            // Breadcrumb
            $scope.$watch('ui.data.Breadcrumb.Value', debounceBreadcrumb, true);

            // Breadcrumb
            $scope.$watch('ui.data.LoginPopup.Value', debounceLoginPopup, true);
        }
        else {
            $scope.$watch('ui.data.WebsiteType.Value', debounceReload, true);
            $scope.$watch('ui.data.Breadcrumb.Value', debounceReload, true);
        }

        // Viewport
        $scope.$watch('ui.data.Viewport.Value', debounceReload, true);

        var SkinOptions = Cookies.get('SkinOptions');
        var Social = Cookies.get('Social');

        if (SkinOptions != null && Social != null) {

            options = JSON.parse(SkinOptions);
            social = JSON.parse(Social);

            if (options != '' && social != '') {

                $scope.ui.data.Theme.Value = options.Theme;
                $scope.ui.data.Header.Value = options.Header;
                $scope.ui.data.BackgroundImages.Value = options.BackgroundImage;
                $scope.ui.data.BackgroundPatterns.Value = options.BackgroundPatterns;
                $scope.ui.data.PrimaryColor.Value = options.PrimaryColor;
                $scope.ui.data.SecondaryColor.Value = options.SecondaryColor;
                $scope.ui.data.TertiaryColor.Value = options.TertiaryColor;
                $scope.ui.data.QuaternaryColor.Value = options.QuaternaryColor;

                if (options.Layout == "wide")
                    $scope.ui.data.LayoutStyle.Value = true;
                else
                    $scope.ui.data.LayoutStyle.Value = false;

                if (options.BRDRadius == "4px")
                    $scope.ui.data.BorderStyle.Value = true;
                else
                    $scope.ui.data.BorderStyle.Value = false;

                if (options.BGColor == "light")
                    $scope.ui.data.BackgroundColor.Value = true;
                else
                    $scope.ui.data.BackgroundColor.Value = false;

                if (options.Type == "normal")
                    $scope.ui.data.WebsiteType.Value = true;
                else
                    $scope.ui.data.WebsiteType.Value = false;

                $.each(social, function (i, option) {
                    $.each($scope.ui.data.Socials.Options, function (int, o) {
                        if (option.id == o.id) {
                            o.href = option.href;
                            o.enabled = option.enabled;

                            if (option.enabled)
                                $("#styleSwitcher ul.social-icons li." + o.id + ", header ul.social-icons li." + o.id).addClass("active");
                            else
                                $("#styleSwitcher ul.social-icons li." + o.id + ", header ul.social-icons li." + o.id).removeClass("active");

                            return false;
                        }
                    });
                });

                $scope.ui.data.SocialIcons.Value = options.SocialIcons;
                $scope.ui.data.Breadcrumb.Value = options.Breadcrumb;
                $scope.ui.data.Login.Value = options.Login;
                $scope.ui.data.LoginPopup.Value = options.LoginPopup;
                $scope.ui.data.Register.Value = options.Register;
                $scope.ui.data.Menu.Value = options.Menu;
                $scope.ui.data.Search.Value = options.Search;
                $scope.ui.data.Copyright.Value = options.Copyright;
                $scope.ui.data.Termsofuse.Value = options.Termsofuse;
                $scope.ui.data.PrivacyStatement.Value = options.PrivacyStatement;
                $scope.ui.data.GoogleMapAPI.Value = options.GoogleMapAPI;
                $scope.ui.data.Language.Value = options.Language;
                $scope.ui.data.Viewport.Value = options.Viewport;
                $scope.ui.data.Toggle.Value = options.Toggle;
                $scope.ui.data.ShortCodes.Value = options.ShortCodes.split(',');

                $scope.Change();
            }
        }

        var PrimaryColor = $scope.ui.data.PrimaryColor.Value;
        var SecondaryColor = $scope.ui.data.SecondaryColor.Value;
        var TertiaryColor = $scope.ui.data.TertiaryColor.Value;
        var QuaternaryColor = $scope.ui.data.QuaternaryColor.Value;
        var $PrimaryColorPicker = $('#PrimaryColorPicker');
        var $SecondaryColorPicker = $('#SecondaryColorPicker');
        var $TertiaryColorPicker = $('#TertiaryColorPicker');
        var $QuarternaryColorPicker = $('#QuarternaryColorPicker');

        $PrimaryColorPicker.ColorPicker({
            color: PrimaryColor,
            onShow: function (el) {
                $(el).ColorPickerShow();
                $scope.ui.data.PrimaryColor.Value = PrimaryColor;
                $scope.Lock();
            },
            onHide: function (el) {
                $(el).ColorPickerHide();
                $scope.bindLock();
            },
            onChange: function (hsb, hex, rgb) {
                $scope.ui.data.PrimaryColor.Value = "#" + hex;
                $PrimaryColorPicker.css("background-color", "#" + hex);
                $scope.Change();
                createCookie();
            },
            onSubmit: function (hsb, hex, rgb, el) {
                $(el).ColorPickerHide();
            }
        });

        $SecondaryColorPicker.ColorPicker({
            color: SecondaryColor,
            onShow: function (el) {
                $(el).ColorPickerShow();
                $scope.ui.data.SecondaryColor.Value = SecondaryColor;
                $scope.Lock();
            },
            onHide: function (el) {
                $(el).ColorPickerHide();
                $scope.bindLock();
            },
            onChange: function (hsb, hex, rgb) {
                $scope.ui.data.SecondaryColor.Value = "#" + hex;
                $SecondaryColorPicker.css("background-color", "#" + hex);
                $scope.Change();
                createCookie();
            },
            onSubmit: function (hsb, hex, rgb, el) {
                $(el).ColorPickerHide();
            }
        });

        $TertiaryColorPicker.ColorPicker({
            color: TertiaryColor,
            onShow: function (el) {
                $(el).ColorPickerShow();
                $scope.ui.data.TertiaryColor.Value = TertiaryColor;
                $scope.Lock();
            },
            onHide: function (el) {
                $(el).ColorPickerHide();
                $scope.bindLock();
            },
            onChange: function (hsb, hex, rgb) {
                $scope.ui.data.TertiaryColor.Value = "#" + hex;
                $TertiaryColorPicker.css("background-color", "#" + hex);
                $scope.Change();
                createCookie();
            },
            onSubmit: function (hsb, hex, rgb, el) {
                $(el).ColorPickerHide();
            }
        });

        $QuarternaryColorPicker.ColorPicker({
            color: QuaternaryColor,
            onShow: function (el) {
                $(el).ColorPickerShow();
                $scope.ui.data.QuaternaryColor.Value = QuaternaryColor;
                $scope.Lock();
            },
            onHide: function (el) {
                $(el).ColorPickerHide();
                $scope.bindLock();
            },
            onChange: function (hsb, hex, rgb) {
                $scope.ui.data.QuaternaryColor.Value = "#" + hex;
                $QuarternaryColorPicker.css("background-color", "#" + hex);
                $scope.Change();
                createCookie();
            },
            onSubmit: function (hsb, hex, rgb, el) {
                $(el).ColorPickerHide();
            }
        });

        $.each($scope.ui.data.Socials.Options, function (key, s) {
            if (s.enabled)
                $("#styleSwitcher ul.social-icons li." + s.id).addClass("active");
            else
                $("#styleSwitcher ul.social-icons input." + s.id).attr("disabled", "disabled");
        });

        $('input[value="' + $scope.ui.data.Header.Value + '"] + label').addClass('active');

        if (!$scope.ui.data.LayoutStyle.Value) {
            $('#styleSwitcher .background-images input[value="' + $scope.ui.data.BackgroundImages.Value + '"]').addClass('active');
            $('#styleSwitcher .background-patterns input[value="' + $scope.ui.data.BackgroundPatterns.Value + '"]').addClass('active');
        }

        var $primaryColor = $('.primary-color input[value="' + $scope.ui.data.PrimaryColor.Value + '"]');
        var $secondaryColor = $('.secondary-color input[value="' + $scope.ui.data.SecondaryColor.Value + '"]');
        var $tertiaryColor = $('.tertiary-color input[value="' + $scope.ui.data.TertiaryColor.Value + '"]');
        var $quaternaryColor = $('.quaternary-color input[value="' + $scope.ui.data.QuaternaryColor.Value + '"]');

        if ($primaryColor.length > 0) {
            $primaryColor.addClass('active');
            $PrimaryColorPicker.next().css('background-color', $scope.ui.data.PrimaryColor.Options[0].HexValue);
        }
        else
            $PrimaryColorPicker.css('background-color', $scope.ui.data.PrimaryColor.Value).addClass('active');

        if ($secondaryColor.length > 0) {
            $secondaryColor.addClass('active');
            $SecondaryColorPicker.next().css('background-color', $scope.ui.data.SecondaryColor.Options[1].HexValue);
        }
        else
            $SecondaryColorPicker.css('background-color', $scope.ui.data.SecondaryColor.Value).addClass('active');

        if ($tertiaryColor.length > 0) {
            $tertiaryColor.addClass('active');
            $TertiaryColorPicker.next().css('background-color', $scope.ui.data.TertiaryColor.Options[2].HexValue);
        }
        else
            $TertiaryColorPicker.css('background-color', $scope.ui.data.TertiaryColor.Value).addClass('active');

        if ($quaternaryColor.length > 0) {
            $quaternaryColor.addClass('active');
            $QuarternaryColorPicker.next().css('background-color', $scope.ui.data.QuaternaryColor.Options[3].HexValue);
        }
        else
            $QuarternaryColorPicker.css('background-color', $scope.ui.data.QuaternaryColor.Value).addClass('active');

        $scope.Change();
    };

    var options = {};
    var timeout = null;

    var debounceChange = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.Bind, 500); // 1000 = 1 second
        }
    };

    var debounceHeader = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.ChangeHeader, 0);
        }
    };

    var debounceWebsitetype = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.ChangeWebsiteType, 0);
        }
    };

    var debounceBackgroundColor = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.ChangeBackgroundColor, 0);
        }
    };

    var debounceLayoutStyle = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.ChangeLayoutStyle, 0);
        }
    };

    var debounceBreadcrumb = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.ChangeBreadcrumb, 0);
        }
    };

    var debounceLoginPopup = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.ChangeLoginPopup, 0);
        }
    };

    var debounceReload = function (newVal, oldVal) {
        if (newVal != oldVal) {
            if (timeout) {
                $timeout.cancel(timeout)
            }
            timeout = $timeout($scope.Reload, 0); // 1000 = 1 second
        }
    };

    $scope.bindLock = function () {
        if ($(".lockSwitcher").hasClass("fa-unlock"))
            $(".StyleSwitcher").removeClass("lockswitcher");
    }

    $scope.Lock = function () {
        if ($(".lockSwitcher").hasClass("fa-unlock")) {
            $(".StyleSwitcher").addClass("lockswitcher");
        }
    }

    $scope.ChangeLess = function () {

        var block = "block";
        var inlineblock = "inline-block";
        var none = "none";
        var BackgroundPattern = null;
        var BackgroundImage = null;

        if ($scope.ui.data.BackgroundPatterns.Value != null && $scope.ui.data.BackgroundPatterns.Value != "")
            BackgroundPattern = $scope.ui.data.BackgroundPatterns.Value.replace("-thumb", "");

        if ($scope.ui.data.BackgroundImages.Value != null && $scope.ui.data.BackgroundImages.Value != "")
            BackgroundImage = $scope.ui.data.BackgroundImages.Value.replace("-thumb", "");

        if ($scope.ui.data.BorderStyle.Value)
            BRDRadius = "4px";
        else
            BRDRadius = 0;

        if ($scope.ui.data.SocialIcons.Value)
            Social = block;
        else
            Social = none;

        if ($scope.ui.data.Login.Value)
            Login = block;
        else
            Login = none;

        if ($scope.ui.data.Register.Value)
            Register = block;
        else
            Register = none;

        if ($scope.ui.data.Menu.Value)
            Menu = block;
        else
            Menu = none;

        if ($scope.ui.data.Search.Value)
            Search = block;
        else
            Search = none;

        if ($scope.ui.data.Copyright.Value)
            Copyright = inlineblock;
        else
            Copyright = none;

        if ($scope.ui.data.Termsofuse.Value)
            Termsofuse = inlineblock;
        else
            Termsofuse = none;

        if ($scope.ui.data.PrivacyStatement.Value)
            PrivacyStatement = inlineblock;
        else
            PrivacyStatement = none;

        if ($scope.ui.data.Language.Value)
            Language = block;
        else
            Language = none;

        less.modifyVars({
            "@background-pattern": BackgroundPattern,
            "@background-image": BackgroundImage,
            "@social": Social,
            "@login": Login,
            "@register": Register,
            "@menu": Menu,
            "@search": Search,
            "@copyright": Copyright,
            "@termsofuse": Termsofuse,
            "@privacystatement": PrivacyStatement,
            "@language": Language,
            "@border-radius": BRDRadius,
            "@color-primary": $scope.ui.data.PrimaryColor.Value,
            "@color-secondary": $scope.ui.data.SecondaryColor.Value,
            "@color-tertiary": $scope.ui.data.TertiaryColor.Value,
            "@color-quaternary": $scope.ui.data.QuaternaryColor.Value
        });
    }

    $scope.Reload = function () {
        createCookie();
        window.location.reload();
    };

    var removeCookie = function () {
        Cookies.remove('SkinOptions');
        Cookies.remove('Social');
        Cookies.remove('SkinName');
    }

    var createCookie = function () {

        removeCookie();

        options.Theme = $scope.ui.data.Theme.Value;
        options.PrimaryColor = $scope.ui.data.PrimaryColor.Value;
        options.SecondaryColor = $scope.ui.data.SecondaryColor.Value;
        options.TertiaryColor = $scope.ui.data.TertiaryColor.Value;
        options.QuaternaryColor = $scope.ui.data.QuaternaryColor.Value;
        options.Header = $scope.ui.data.Header.Value;

        if ($scope.ui.data.LayoutStyle.Value) {
            options.Layout = "wide";
            options.BackgroundImage = null;
            options.BackgroundPatterns = null;
        }
        else {
            options.Layout = "boxed";
            options.BackgroundPatterns = $scope.ui.data.BackgroundPatterns.Value;
            options.BackgroundImage = $scope.ui.data.BackgroundImages.Value;
        }

        if ($scope.ui.data.BorderStyle.Value)
            options.BRDRadius = "4px";
        else
            options.BRDRadius = "0";

        if ($scope.ui.data.BackgroundColor.Value)
            options.BGColor = "light";
        else
            options.BGColor = "dark";

        if ($scope.ui.data.WebsiteType.Value)
            options.Type = "normal";
        else
            options.Type = "one page";

        SocialLinks = [];

        $.each($scope.ui.data.Socials.Options, function (key, option) {
            SocialLinks.push({
                "name": option.name, "id": option.id, "href": option.href, "enabled": option.enabled
            });
        });

        options.SocialIcons = $scope.ui.data.SocialIcons.Value;
        if ($scope.ui.data.IsSuperUser.Value == "True") {
            options.Breadcrumb = $scope.ui.data.Breadcrumb.Value;
        }
        options.Login = $scope.ui.data.Login.Value;
        options.LoginPopup = $scope.ui.data.LoginPopup.Value;
        options.Register = $scope.ui.data.Register.Value;
        options.Menu = $scope.ui.data.Menu.Value;
        options.Search = $scope.ui.data.Search.Value;
        options.Copyright = $scope.ui.data.Copyright.Value;
        options.Termsofuse = $scope.ui.data.Termsofuse.Value;
        options.PrivacyStatement = $scope.ui.data.PrivacyStatement.Value;
        options.GoogleMapAPI = $scope.ui.data.GoogleMapAPI.Value;
        options.Language = $scope.ui.data.Language.Value;
        options.Viewport = $scope.ui.data.Viewport.Value;
        options.Toggle = $scope.ui.data.Toggle.Value;
        options.ShortCodes = $scope.ui.data.ShortCodes.Value.toString();

        Cookies.set('SkinOptions', JSON.stringify(options), { expires: 0.04 });
        Cookies.set('Social', JSON.stringify(SocialLinks), { expires: 0.04 });
        Cookies.set('SkinName', $scope.ui.data.Theme.Value, { expires: 0.04 });
    }

    $scope.Click_SocialActive = function (social, event) {
        var soc = $.extend({}, social);
        $.each($scope.ui.data.Socials.Options, function (key, s) {
            if (soc.name == s.name) {
                if (event == "blur") {
                    s.href = $("#styleSwitcher ul.social-icons input." + s.id).val();
                    $("header .social-icons li." + s.id + ".active").find("a").attr("href", s.href);
                }
                else {
                    s.enabled = !soc.enabled;
                    if (s.enabled) {
                        $("#styleSwitcher ul.social-icons li." + s.id).addClass("active");
                        $("#styleSwitcher ul.social-icons input." + s.id).removeAttr("disabled");
                        $("header .social-icons li." + s.id).addClass("active").find("a").attr("href", s.href);
                    }
                    else {
                        $("#styleSwitcher ul.social-icons li." + s.id).removeClass("active");
                        $("#styleSwitcher ul.social-icons input." + s.id).attr("disabled", "disabled");
                        $("header .social-icons li." + s.id).removeClass("active");
                    }
                }
                return;
            }
        });
    }
    $scope.Click_Active = function (temp) {
        if (temp == "PrimaryColor") {
            $scope.show_sc = false;
            $scope.show_tc = false;
            $scope.show_qc = false;
            $scope.show_pc = !$scope.show_pc;
        }
        else if (temp == "SecondaryColor") {
            $scope.show_pc = false;
            $scope.show_sc = !$scope.show_sc;
            $scope.show_tc = false;
            $scope.show_qc = false;
        }
        else if (temp == "TertiaryColor") {
            $scope.show_pc = false;
            $scope.show_sc = false;
            $scope.show_tc = !$scope.show_tc;
            $scope.show_qc = false;
        }
        else if (temp == "QuaternaryColor") {
            $scope.show_pc = false;
            $scope.show_sc = false;
            $scope.show_tc = false;
            $scope.show_qc = !$scope.show_qc;
        }
    }
    $scope.Click_SaveStyleSwitcher = function () {
        jQuery("#getConfirmedModal").modal("show");
    }
    $scope.Click_Save = function () {
        removeCookie();
        common.webApi.post('index/save', 'name=' + $scope.ui.data.Theme.Value, $scope.ui.data).success(function (data) {
            if (data == "Success")
                jQuery("#getConfirmedModal").modal("hide");
        });
    }

    $scope.Click_Open = function () {
        jQuery('#getCSSModal').modal('show');
        $scope.Name = "";
    }

    $scope.Click_Opens = function () {

        var $styleSwitcher = $("#styleSwitcher");

        if ($styleSwitcher.hasClass("active")) {
            $styleSwitcher.animate({
                left: "-45px"
            }, 300).removeClass("active");

        } else {
            $styleSwitcher.animate({
                left: "0"
            }, 300).addClass("active");
        }
    },

    $scope.Click_Create = function () {

        if ($scope.IsValidateName()) {
            common.webApi.post('index/create', '', $scope.Name).success(function (data) {
                if (data == "File Exist")
                    jQuery("#themeAlert").html("Theme name already exist").show();
                else if (data == "Success") {
                    jQuery("#themeAlert").hide();
                    jQuery('#getCSSModal').modal('hide');
                    jQuery('#getapplyCSSModal').modal('show');
                    var Theme = { Name: $scope.Name, Value: $scope.Name }
                    $scope.ui.data.Theme.Options.push(Theme);
                }
            });
        }
    }

    //apply
    $scope.Click_Apply = function () {
        jQuery('#getapplyCSSModal').modal('hide');
        common.webApi.post('index/apply', '', $scope.Name).success(function (data) {
            $scope.ui.data.Theme.Value = $scope.Name;
            $scope.Change_Theme();
            
        });
    }

    //ApplyCancel
    $scope.Click_ApplyCancel = function () {
        jQuery('#getapplyCSSModal').modal('hide');
            $scope.ui.data.Theme.Value = $scope.Name;
            $scope.Change_Theme();
    }

    //lock
    $scope.Lock_Switcher = function () {
        $(".lockSwitcher").toggleClass("fa-lock fa-unlock");
        $(".StyleSwitcher").toggleClass("lockswitcher");
    }

    $scope.ShowStyleSwitcher = function () {
        if ($scope.ui.data.Theme.Value == "Home" || $scope.ui.data.Theme.Value == "Inner")
            return false;
        else
            return true;
    }

    $scope.IsValidateName = function () {

        if ($scope.Name == "") {
            jQuery("#themeAlert").html("Please specify Theme Name").show();
            return false;
        }
        else {

            var regexSpace = /\s/g;
            var regexAlphabet = /^[a-zA-Z]*$/;

            if (regexSpace.test($scope.Name)) {
                jQuery("#themeAlert").html("Theme Name can't contain spaces").show();
                return false;
            }

            if (!regexAlphabet.test($scope.Name)) {
                jQuery("#themeAlert").html("Theme Name contain only letters").show();
                return false;
            }
        }
        return true;
    }
    $scope.Click_Remove = function () {

        jQuery('#getRemoveModal').modal('show');
    }
    $scope.Click_Delete = function () {
        if ($scope.ShowStyleSwitcher) {
            common.webApi.post('index/remove', 'themename=' + $scope.ui.data.Theme.Value).success(function (data) {
                jQuery("#themeAlert1").html('').hide();
                if (data == true) {
                    jQuery('#getRemoveModal').modal('hide');
                    removeCookie();
                    window.location.reload();
                }
                else
                    jQuery("#themeAlert1").html('You cannot remove <strong>' + $scope.ui.data.Theme.Value + '</strong> theme as it is applied on any of the page.').show();
            });
        }
    }

    $scope.Click_Reset = function () {
        jQuery('#getResetModal').modal('show');
    }

    $scope.Click_ResetTheme = function () {
        removeCookie();
        window.location.reload();
        if (data == "Success")
            jQuery("#getResetModal").modal("hide");

    }

    $scope.Click_Toggle = function () {

        createCookie();

        if ($scope.ui.data.Toggle.Value) {

            $('.ShortContent input[type="checkbox"]').attr('checked', 'checked');
            $scope.ui.data.ShortCodes.Value = $scope.ui.data.ShortCodes.Options.map(function (key) {
                return key.Value
            });
        }
        else {
            $('.ShortContent input[type="checkbox"]').removeAttr('checked');
            $scope.ui.data.ShortCodes.Value = [];
        }
    }

    $scope.Click_Enter = function (event) {
        if (event.which === 13) {
            $scope.Click_Create();
            event.preventDefault();
        }
    }

    $scope.Click_EnterPrevent = function (event) {
        if (event.which === 13)
            event.preventDefault();
    }

    $scope.Bind = function (event) {
        $scope.Change();
        createCookie();
    }

    $scope.ChangeHeader = function () {
        removeCookie();
        if ($scope.ui.data.Header.Value != "")
            window.location.href = "http://porto.mandeeps.com/features/headers/header-" + $scope.ui.data.Header.Value;
    }

    $scope.ChangeWebsiteType = function () {
        removeCookie();
        if ($scope.ui.data.WebsiteType.Value)
            window.location.href = "http://porto.mandeeps.com";
        else
            window.location.href = "http://porto.mandeeps.com/home/one-page";
    }

    $scope.ChangeBackgroundColor = function () {
        removeCookie();
        if ($scope.ui.data.BackgroundColor.Value)
            window.location.href = "http://porto.mandeeps.com";
        else
            window.location.href = "http://porto.mandeeps.com/features/layout-options/dark";
    }

    $scope.ChangeLayoutStyle = function () {
        removeCookie();
        if ($scope.ui.data.LayoutStyle.Value)
            window.location.href = "http://porto.mandeeps.com";
        else
            window.location.href = "http://porto.mandeeps.com/features/layout-options/boxed";
    }

    $scope.ChangeBreadcrumb = function () {
        removeCookie();
        if ($scope.ui.data.Breadcrumb.Value)
            window.location.href = "http://porto.mandeeps.com/blog/blog-full-width";
        else
            window.location.href = "http://porto.mandeeps.com";
    }

    $scope.ChangeLoginPopup = function () {
        removeCookie();
        if ($scope.ui.data.LoginPopup.Value)
            window.location.href = "http://porto.mandeeps.com/popup";
        else
            window.location.href = "http://porto.mandeeps.com";
    }

    $scope.Change = function ($this) {

        $scope.ui.data.CSS.Value = jQuery('style[id^="less:"]').text(); s

        if ($scope.ui.data.BackgroundColor.Value)
            $("html").removeClass("dark");
        else
            $("html").addClass("dark");

        if ($scope.ui.data.LayoutStyle.Value) {

            jQuery("html").removeClass("boxed");
            $scope.ui.data.BackgroundPatterns.Value = null;
            $scope.ui.data.BackgroundImages.Value = null;

        }
        else {

            var $BGIP = $('.background-images input, .background-patterns input');

            jQuery("html").addClass("boxed");

            if ($this == 'BGImage') {
                $scope.ui.data.BackgroundPatterns.Value = null;
                $BGIP.removeClass('active');
                $('.background-images input[value="' + $scope.ui.data.BackgroundImages.Value + '"]').addClass('active');
            }
            else if ($this == 'BGPattern') {
                $scope.ui.data.BackgroundImages.Value = null;
                $BGIP.removeClass('active');
                $('.background-patterns input[value="' + $scope.ui.data.BackgroundPatterns.Value + '"]').addClass('active');
            }
        }

        $('#Colors input').removeClass('active');
        $('.primary-color input[value="' + $scope.ui.data.PrimaryColor.Value + '"]').addClass('active');
        $('.secondary-color input[value="' + $scope.ui.data.SecondaryColor.Value + '"]').addClass('active');
        $('.tertiary-color input[value="' + $scope.ui.data.TertiaryColor.Value + '"]').addClass('active');
        $('.quaternary-color input[value="' + $scope.ui.data.QuaternaryColor.Value + '"]').addClass('active');

        $scope.ChangeLess();
    }

    $scope.Change_Theme = function () {
        removeCookie();
        Cookies.set('SkinName', $scope.ui.data.Theme.Value, { expires: 0.04 });
        window.location.href = window.location.href.split("?")[0] + '?SkinSrc=[G]Skins/Porto/' + $scope.ui.data.Theme.Value;
    }

    $scope.bg_Click = function (Class) {

        var $StyleSwitcher = $(".StyleSwitcher");
        var $StyleSwitcherContent = $(".StyleSwitcher").find(".ms-tab-content");

        $StyleSwitcher.addClass("open");

        $StyleSwitcherContent.removeClass("full middle").on('mouseleave', function () {
            $StyleSwitcher.removeClass("open");
        });

        $StyleSwitcher.find('.vertical-bar').on('mouseenter', function () {
            $StyleSwitcher.addClass("open");
        });

        if (Class != "")
            $StyleSwitcherContent.addClass(Class);
    }
});
