app.controller('common_licensing', function ($scope, $attrs, $http, $location, CommonSvc, SweetAlert) {
    var common = CommonSvc.getData($scope);

    $scope.Finish = function (FinishType) {
        if ($scope.ui.data.Editions.Value == "") {
            SweetAlert.swal("Please select an edition");
        }
        else {
            common.webApi.post('~licensing/setworkingedition', 'appname=' + CommonSvc.appName + '&edition=' + $scope.ui.data.Editions.Value).success(function (success) {
                if (success != null)
                    window.location.hash = '#/issues';
            });
        }
    };
    $scope.Activate = function () {
        if ($scope.ui.data.Editions.Value == "") {
            SweetAlert.swal("Please select an edition");
        }
        else {
            common.webApi.post('~licensing/setworkingedition', 'appname=' + CommonSvc.appName + '&edition=' + $scope.ui.data.Editions.Value).success(function (success) {
                if (success != null)
                    window.location.hash = '#/activation';
            });
        }
    };


});